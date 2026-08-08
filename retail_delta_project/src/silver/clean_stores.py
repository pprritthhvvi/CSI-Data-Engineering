# src/silver/clean_stores.py

from pyspark.sql.functions import col, row_number
from pyspark.sql.window import Window
from src.utils.spark_utils import get_spark_session
from src.config import BRONZE_STORES, SILVER_STORES_CLEAN

def clean_stores(spark):
    """
    Cleans Bronze Stores.
    - Deduplicates by store_id keeping the latest ingestion_ts.
    - Stores don't have CDC/incremental files in this scenario, so it's a simple clean.
    - Resulting table is effectively the dimension table (dim_store) since no SCD2 is mentioned.
    """
    
    # 1. Read batch table
    df_batch = spark.read.table(BRONZE_STORES)
    
    # 2. Filter bad records
    df_valid = df_batch.filter(col("store_id").isNotNull())
    
    # 3. Deduplicate by store_id based on latest ingestion_ts
    window_spec = Window.partitionBy("store_id").orderBy(col("ingestion_ts").desc())
    
    df_deduped = df_valid \
        .withColumn("rn", row_number().over(window_spec)) \
        .filter(col("rn") == 1) \
        .drop("rn")
        
    # Write to Silver dimension table directly
    print(f"Writing clean stores to {SILVER_STORES_CLEAN}")
    df_deduped.write \
        .format("delta") \
        .mode("overwrite") \
        .option("mergeSchema", "true") \
        .saveAsTable(SILVER_STORES_CLEAN)
        
    print("Stores cleaning completed successfully.")

def main():
    spark = get_spark_session("SilverCleanStores")
    clean_stores(spark)

if __name__ == "__main__":
    main()
