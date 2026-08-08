# src/silver/clean_orders.py

from pyspark.sql.functions import col, to_timestamp, regexp_replace, cast, row_number
from pyspark.sql.window import Window
from src.utils.spark_utils import get_spark_session
from src.config import BRONZE_ORDERS, BRONZE_ORDERS_INCR, SILVER_ORDERS_CLEAN

def clean_orders(spark):
    """
    Cleans Bronze Orders (combines batch and incremental records).
    - Removes currency symbols/text from unit_price.
    - Casts timestamps and numeric fields.
    - Filters out rows with null order_id or customer_id.
    - Deduplicates by order_id keeping the most recently ingested record.
    """
    
    # 1. Read batch and incremental bronze tables
    df_batch = spark.read.table(BRONZE_ORDERS)
    df_incr = spark.read.table(BRONZE_ORDERS_INCR)
    
    # 2. Combine them. (Note: Incremental might have a new column 'coupon_code'.
    # We use unionByName with allowMissingColumns to safely combine.)
    df_combined = df_batch.unionByName(df_incr, allowMissingColumns=True)
    
    # 3. Clean and Cast
    # Extract only digits and decimal points from unit_price using regex
    df_cleaned = df_combined \
        .withColumn("order_ts", expr("try_to_timestamp(order_ts, 'yyyy-MM-dd HH:mm:ss')")) \
        .withColumn("unit_price_clean", regexp_replace(col("unit_price"), r"[^0-9\.]", "")) \
        .withColumn("unit_price", expr("try_cast(unit_price_clean AS double)")) \
        .withColumn("quantity", expr("try_cast(quantity AS integer)")) \
        .withColumn("discount_pct", expr("try_cast(discount_pct AS double)")) \
        .withColumn("gross_amount", expr("try_cast(gross_amount AS double)")) \
        .drop("unit_price_clean")
        
    # 4. Filter bad records (Quarantine conceptually, here we just filter for simplicity)
    df_valid = df_cleaned.filter(col("order_id").isNotNull() & col("customer_id").isNotNull())
    
    # 5. Deduplicate by order_id
    # If a record was updated, we keep the one with the latest ingestion_ts
    window_spec = Window.partitionBy("order_id").orderBy(col("ingestion_ts").desc())
    
    df_deduped = df_valid \
        .withColumn("rn", row_number().over(window_spec)) \
        .filter(col("rn") == 1) \
        .drop("rn")
        
    # Write to Silver 1 table
    print(f"Writing clean orders to {SILVER_ORDERS_CLEAN}")
    df_deduped.write \
        .format("delta") \
        .mode("overwrite") \
        .option("mergeSchema", "true") \
        .saveAsTable(SILVER_ORDERS_CLEAN)
        
    print("Orders cleaning completed successfully.")

def main():
    spark = get_spark_session("SilverCleanOrders")
    clean_orders(spark)

if __name__ == "__main__":
    main()
