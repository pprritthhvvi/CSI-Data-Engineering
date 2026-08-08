# src/silver/clean_customers.py

from pyspark.sql.functions import col, to_date, when, row_number
from pyspark.sql.window import Window
from src.utils.spark_utils import get_spark_session
from src.config import BRONZE_CUSTOMERS, BRONZE_CUSTOMERS_CDC, SILVER_CUSTOMERS_CLEAN

def clean_customers(spark):
    """
    Cleans Bronze Customers (combines batch and CDC inserts/updates).
    - Parses signup_date.
    - Handles null categorical fields (sets to "Unknown").
    - Deduplicates by customer_id keeping the latest ingestion_ts.
    """
    
    # 1. Read batch and CDC tables
    df_batch = spark.read.table(BRONZE_CUSTOMERS)
    df_cdc = spark.read.table(BRONZE_CUSTOMERS_CDC)
    
    # 2. Combine them
    df_combined = df_batch.unionByName(df_cdc, allowMissingColumns=True)
    
    # 3. Clean and Cast
    # For dates, spark try_cast will return null if format doesn't match/invalid
    df_cleaned = df_combined \
        .withColumn("signup_date", expr("try_cast(signup_date AS date)")) \
        .withColumn("segment", when(col("segment").isNull() | (col("segment") == ""), "Unknown").otherwise(col("segment"))) \
        .withColumn("city", when(col("city").isNull() | (col("city") == ""), "Unknown").otherwise(col("city")))
        
    # 4. Filter bad records
    df_valid = df_cleaned.filter(col("customer_id").isNotNull())
    
    # 5. Deduplicate by customer_id based on latest ingestion_ts
    window_spec = Window.partitionBy("customer_id").orderBy(col("ingestion_ts").desc())
    
    df_deduped = df_valid \
        .withColumn("rn", row_number().over(window_spec)) \
        .filter(col("rn") == 1) \
        .drop("rn")
        
    # Write to Silver 1 table
    print(f"Writing clean customers to {SILVER_CUSTOMERS_CLEAN}")
    df_deduped.write \
        .format("delta") \
        .mode("overwrite") \
        .option("mergeSchema", "true") \
        .saveAsTable(SILVER_CUSTOMERS_CLEAN)
        
    print("Customers cleaning completed successfully.")

def main():
    spark = get_spark_session("SilverCleanCustomers")
    clean_customers(spark)

if __name__ == "__main__":
    main()
