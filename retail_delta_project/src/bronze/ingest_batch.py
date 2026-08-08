# src/bronze/ingest_batch.py

from pyspark.sql.functions import current_timestamp, col, lit
from src.utils.spark_utils import get_spark_session
from src.config import (
    BATCH_PATH, BRONZE_ORDERS, BRONZE_CUSTOMERS, BRONZE_PRODUCTS, BRONZE_STORES
)

def ingest_batch_file(spark, file_name, target_table):
    """
    Ingests a historical batch CSV file into a Bronze Delta table.
    Reads all columns as strings to prevent schema enforcement errors on dirty data.
    Adds metadata columns: source_file, ingestion_ts, load_type.
    """
    file_path = f"{BATCH_PATH}/{file_name}"
    
    print(f"Reading batch file from: {file_path}")
    df = spark.read \
        .format("csv") \
        .option("header", "true") \
        .option("inferSchema", "false") \
        .load(file_path)
        
    df_with_metadata = df \
        .withColumn("source_file", input_file_name()) \
        .withColumn("ingestion_ts", current_timestamp()) \
        .withColumn("load_type", lit("batch"))
        
    print(f"Writing to Bronze table: {target_table}")
    df_with_metadata.write \
        .format("delta") \
        .mode("overwrite") \
        .saveAsTable(target_table)
    
    print(f"Successfully ingested {file_name} into {target_table}.")

def main():
    spark = get_spark_session("BronzeBatchIngestion")
    
    # Ingest Batch Files
    ingest_batch_file(spark, "orders_batch.csv", BRONZE_ORDERS)
    ingest_batch_file(spark, "customers_batch.csv", BRONZE_CUSTOMERS)
    ingest_batch_file(spark, "products_batch.csv", BRONZE_PRODUCTS)
    ingest_batch_file(spark, "stores_batch.csv", BRONZE_STORES)

if __name__ == "__main__":
    main()
