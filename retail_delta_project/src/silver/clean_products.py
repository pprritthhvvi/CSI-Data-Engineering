# src/silver/clean_products.py

from pyspark.sql.functions import col, regexp_replace, row_number, expr
from pyspark.sql.window import Window
from src.utils.spark_utils import get_spark_session
from src.config import BRONZE_PRODUCTS, BRONZE_PRODUCTS_CDC, SILVER_PRODUCTS_CLEAN

def clean_products(spark):
    """
    Cleans Bronze Products (combines batch and CDC inserts/updates).
    - Cleans unit_price ('unknown' etc.)
    - Parses created_date
    - Deduplicates by product_id keeping the latest ingestion_ts.
    """
    
    print("Cleaning Products data...")
    # 1. Read batch and CDC tables
    df_batch = spark.read.table(BRONZE_PRODUCTS)
    df_cdc = spark.read.table(BRONZE_PRODUCTS_CDC)
    
    # 2. Combine them
    df_combined = df_batch.unionByName(df_cdc, allowMissingColumns=True)
    
    # 3. Clean and Cast
    df_cleaned = df_combined \
        .withColumn("created_date", expr("try_cast(created_date AS date)")) \
        .withColumn("unit_price_clean", regexp_replace(col("unit_price"), r"[^0-9\.]", "")) \
        .withColumn("unit_price", expr("try_cast(unit_price_clean AS double)")) \
        .drop("unit_price_clean")
        
    # 4. Filter bad records
    df_valid = df_cleaned.filter(col("product_id").isNotNull())
    
    # 5. Deduplicate by product_id based on latest ingestion_ts
    window_spec = Window.partitionBy("product_id").orderBy(col("ingestion_ts").desc())
    
    df_deduped = df_valid \
        .withColumn("rn", row_number().over(window_spec)) \
        .filter(col("rn") == 1) \
        .drop("rn")
        
    # Write to Silver 1 table
    print(f"Writing clean products to {SILVER_PRODUCTS_CLEAN}")
    df_deduped.write \
        .format("delta") \
        .mode("overwrite") \
        .option("mergeSchema", "true") \
        .saveAsTable(SILVER_PRODUCTS_CLEAN)
        
    print("Products cleaning completed successfully.")

def main():
    spark = get_spark_session("SilverCleanProducts")
    clean_products(spark)

if __name__ == "__main__":
    main()
