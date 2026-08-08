# src/silver/scd2_products.py

from pyspark.sql.functions import col, sha2, concat_ws, lit, expr
from src.utils.spark_utils import get_spark_session
from src.config import SILVER_PRODUCTS_CLEAN, DIM_PRODUCT_SCD2

def create_or_merge_scd2(spark):
    """
    Implements SCD Type 2 for the Product dimension.
    Uses a 2-step MERGE process.
    """
    
    df_source = spark.read.table(SILVER_PRODUCTS_CLEAN)
    
    # Attributes to track for changes
    attr_cols = ["product_name", "category", "brand", "unit_price", "status", "created_date"]
    
    df_stg = df_source.withColumn(
        "hash_value", 
        sha2(concat_ws("||", *[col(c).cast("string") for c in attr_cols]), 256)
    )
    
    table_exists = spark.catalog.tableExists(DIM_PRODUCT_SCD2)
    
    if not table_exists:
        print(f"Creating initial SCD2 table: {DIM_PRODUCT_SCD2}")
        from pyspark.sql.functions import to_date
        df_init = df_stg \
            .withColumn("effective_start_date", col("ingestion_ts").cast("date")) \
            .withColumn("effective_end_date", to_date(lit("9999-12-31"), "yyyy-MM-dd")) \
            .withColumn("is_current", lit(True)) \
            .withColumn("product_sk", expr("uuid()"))
            
        df_init.write.format("delta").saveAsTable(DIM_PRODUCT_SCD2)
        return
        
    print(f"Merging into SCD2 table: {DIM_PRODUCT_SCD2}")
    
    df_stg.withColumn("effective_start_date", col("ingestion_ts").cast("date")).createOrReplaceTempView("source_products")
    
    # Step 1: Expire
    spark.sql(f"""
        MERGE INTO {DIM_PRODUCT_SCD2} t
        USING source_products s
        ON t.product_id = s.product_id AND t.is_current = true
        WHEN MATCHED AND t.hash_value <> s.hash_value THEN
            UPDATE SET 
                t.effective_end_date = date_sub(s.effective_start_date, 1),
                t.is_current = false
    """)
    
    # Step 2: Insert
    spark.sql(f"""
        MERGE INTO {DIM_PRODUCT_SCD2} t
        USING source_products s
        ON t.product_id = s.product_id AND t.is_current = true AND t.hash_value = s.hash_value
        WHEN NOT MATCHED THEN
            INSERT (
                product_sk, product_id, product_name, category, brand, unit_price, status, created_date,
                source_file, ingestion_ts, load_type, hash_value,
                effective_start_date, effective_end_date, is_current
            )
            VALUES (
                uuid(), s.product_id, s.product_name, s.category, s.brand, s.unit_price, s.status, s.created_date,
                s.source_file, s.ingestion_ts, s.load_type, s.hash_value,
                s.effective_start_date, to_date('9999-12-31', 'yyyy-MM-dd'), true
            )
    """)
    
    print("Product SCD2 merge completed successfully.")

def main():
    spark = get_spark_session("SilverSCD2Products")
    create_or_merge_scd2(spark)

if __name__ == "__main__":
    main()
