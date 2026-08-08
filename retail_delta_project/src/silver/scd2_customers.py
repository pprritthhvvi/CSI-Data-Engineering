# src/silver/scd2_customers.py

from pyspark.sql.functions import col, sha2, concat_ws, lit, expr
from delta.tables import DeltaTable
from src.utils.spark_utils import get_spark_session
from src.config import SILVER_CUSTOMERS_CLEAN, DIM_CUSTOMER_SCD2, CATALOG, SILVER_SCHEMA

def create_or_merge_scd2(spark):
    """
    Implements SCD Type 2 for the Customer dimension.
    Uses a 2-step MERGE process to expire old records and insert new ones.
    """
    
    # 1. Read the cleaned source data
    df_source = spark.read.table(SILVER_CUSTOMERS_CLEAN)
    
    # Define columns that constitute the business state (to detect changes)
    # excluding metadata like ingestion_ts
    attr_cols = ["customer_name", "city", "segment", "gender", "signup_date", "status"]
    
    # Calculate hash to detect changes
    df_stg = df_source.withColumn(
        "hash_value", 
        sha2(concat_ws("||", *[col(c).cast("string") for c in attr_cols]), 256)
    )
    
    # Ensure the target table exists
    table_exists = spark.catalog.tableExists(DIM_CUSTOMER_SCD2)
    
    if not table_exists:
        print(f"Creating initial SCD2 table: {DIM_CUSTOMER_SCD2}")
        # Initialize
        df_init = df_stg \
            .withColumn("effective_start_date", col("ingestion_ts").cast("date")) \
            .withColumn("effective_end_date", to_date(lit("9999-12-31"), "yyyy-MM-dd")) \
            .withColumn("is_current", lit(True)) \
            .withColumn("customer_sk", expr("uuid()")) # Surrogate Key
            
        df_init.write.format("delta").saveAsTable(DIM_CUSTOMER_SCD2)
        return
        
    print(f"Merging into SCD2 table: {DIM_CUSTOMER_SCD2}")
    
    # Create temp views for Spark SQL 2-step merge
    df_stg.withColumn("effective_start_date", col("ingestion_ts").cast("date")).createOrReplaceTempView("source_customers")
    
    # Step 1: Expire old records where attributes have changed
    # We find matched records where hash is different, and we update their effective_end_date and is_current
    spark.sql(f"""
        MERGE INTO {DIM_CUSTOMER_SCD2} t
        USING source_customers s
        ON t.customer_id = s.customer_id AND t.is_current = true
        WHEN MATCHED AND t.hash_value <> s.hash_value THEN
            UPDATE SET 
                t.effective_end_date = date_sub(s.effective_start_date, 1),
                t.is_current = false
    """)
    
    # Step 2: Insert new records (both entirely new customers, and new versions of updated customers)
    # A new version needs to be inserted if the hash is different, or if it's a completely new customer.
    # To do this safely, we insert from source where it doesn't match an *active* record with the *same* hash.
    spark.sql(f"""
        MERGE INTO {DIM_CUSTOMER_SCD2} t
        USING source_customers s
        ON t.customer_id = s.customer_id AND t.is_current = true AND t.hash_value = s.hash_value
        WHEN NOT MATCHED THEN
            INSERT (
                customer_sk, customer_id, customer_name, city, segment, gender, signup_date, status,
                source_file, ingestion_ts, load_type, hash_value,
                effective_start_date, effective_end_date, is_current
            )
            VALUES (
                uuid(), s.customer_id, s.customer_name, s.city, s.segment, s.gender, s.signup_date, s.status,
                s.source_file, s.ingestion_ts, s.load_type, s.hash_value,
                s.effective_start_date, to_date('9999-12-31', 'yyyy-MM-dd'), true
            )
    """)
    
    print("Customer SCD2 merge completed successfully.")

def main():
    spark = get_spark_session("SilverSCD2Customers")
    # For PySpark to use date_sub etc., we need to ensure SQL context has access to standard functions
    from pyspark.sql.functions import to_date
    create_or_merge_scd2(spark)

if __name__ == "__main__":
    main()
