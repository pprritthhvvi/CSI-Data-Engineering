# src/bronze/ingest_incremental.py

from pyspark.sql.functions import current_timestamp, col, lit
from src.utils.spark_utils import get_spark_session
from src.config import (
    INCR_PATH, CHECKPOINT_PATH, SCHEMA_PATH,
    BRONZE_ORDERS_INCR, BRONZE_CUSTOMERS_CDC, BRONZE_PRODUCTS_CDC
)

def ingest_incremental_files(spark, file_pattern, target_table, stream_name):
    """
    Ingests incremental daily CSV files into Bronze Delta tables using Auto Loader.
    Allows schema evolution (mergeSchema = true) to handle Day 3 schema changes.
    """
    checkpoint_dir = f"{CHECKPOINT_PATH}/{stream_name}"
    schema_dir = f"{SCHEMA_PATH}/{stream_name}"
    
    # We point to the parent incremental directory, and use a glob filter to pick specific file types
    path_with_pattern = f"{INCR_PATH}/{file_pattern}"
    print(f"Starting incremental stream for: {path_with_pattern} into {target_table}")
    
    df = spark.readStream \
        .format("cloudFiles") \
        .option("cloudFiles.format", "csv") \
        .option("cloudFiles.schemaLocation", schema_dir) \
        .option("cloudFiles.inferColumnTypes", "false") \
        .option("header", "true") \
        .load(path_with_pattern)
        
    df_with_metadata = df.withColumn("source_file", col("_metadata.file_path")) \
                         .withColumn("ingestion_ts", current_timestamp()) \
                         .withColumn("load_type", lit("incremental"))
        
    # Write stream to Delta
    query = df_with_metadata.writeStream \
        .format("delta") \
        .outputMode("append") \
        .option("checkpointLocation", checkpoint_dir) \
        .option("mergeSchema", "true") \
        .trigger(availableNow=True) \
        .toTable(target_table)
        
    query.awaitTermination()
    print(f"Finished incremental run for {target_table}.")

def main():
    spark = get_spark_session("BronzeIncrementalIngestion")
    
    # 1. Orders Incremental (includes schema change later on)
    ingest_incremental_files(
        spark, 
        file_pattern="orders_incremental_*.csv", 
        target_table=BRONZE_ORDERS_INCR, 
        stream_name="bronze_orders_incr"
    )
    
    # 2. Customers CDC
    ingest_incremental_files(
        spark, 
        file_pattern="customers_cdc_*.csv", 
        target_table=BRONZE_CUSTOMERS_CDC, 
        stream_name="bronze_customers_cdc"
    )
    
    # 3. Products CDC
    ingest_incremental_files(
        spark, 
        file_pattern="products_cdc_*.csv", 
        target_table=BRONZE_PRODUCTS_CDC, 
        stream_name="bronze_products_cdc"
    )

if __name__ == "__main__":
    main()
