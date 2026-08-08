# src/gold/fact_orders.py

from pyspark.sql.functions import col, to_date
from src.utils.spark_utils import get_spark_session
from src.config import (
    SILVER_ORDERS_CLEAN, 
    DIM_CUSTOMER_SCD2, 
    DIM_PRODUCT_SCD2,
    SILVER_STORES_CLEAN,
    FACT_ORDERS
)

def create_fact_orders(spark):
    """
    Creates the Gold Conformed Fact Table (fact_orders).
    Joins cleaned orders with SCD2 dimensions using point-in-time logic to resolve surrogate keys.
    """
    
    # Read tables
    df_orders = spark.read.table(SILVER_ORDERS_CLEAN)
    df_customers = spark.read.table(DIM_CUSTOMER_SCD2)
    df_products = spark.read.table(DIM_PRODUCT_SCD2)
    df_stores = spark.read.table(SILVER_STORES_CLEAN)
    
    # We need the order date to compare against effective date ranges
    df_orders = df_orders.withColumn("order_date", to_date(col("order_ts")))
    
    # Join with Customer Dimension
    # Point in time: order_date >= effective_start_date AND order_date <= effective_end_date
    fact_with_cust = df_orders.alias("o").join(
        df_customers.alias("c"),
        (col("o.customer_id") == col("c.customer_id")) &
        (col("o.order_date") >= col("c.effective_start_date")) &
        (col("o.order_date") <= col("c.effective_end_date")),
        "left_outer"
    ).select(
        "o.*",
        col("c.customer_sk")
    )
    
    # Join with Product Dimension
    fact_with_prod = fact_with_cust.alias("o").join(
        df_products.alias("p"),
        (col("o.product_id") == col("p.product_id")) &
        (col("o.order_date") >= col("p.effective_start_date")) &
        (col("o.order_date") <= col("p.effective_end_date")),
        "left_outer"
    ).select(
        "o.*",
        col("p.product_sk")
    )
    
    # Join with Store Dimension (Store does not use SCD2, just simple join)
    fact_final = fact_with_prod.alias("o").join(
        df_stores.alias("s"),
        col("o.store_id") == col("s.store_id"),
        "left_outer"
    ).select(
        col("o.order_id"),
        col("o.order_ts"),
        col("o.order_date"),
        col("o.customer_id"),
        col("o.customer_sk"),
        col("o.product_id"),
        col("o.product_sk"),
        col("o.store_id"),
        col("o.quantity"),
        col("o.unit_price"),
        col("o.discount_pct"),
        col("o.gross_amount"),
        col("o.payment_method"),
        col("o.order_status")
    )
    
    # Write to Gold schema
    print(f"Writing Fact table to {FACT_ORDERS}")
    fact_final.write \
        .format("delta") \
        .mode("overwrite") \
        .option("mergeSchema", "true") \
        .saveAsTable(FACT_ORDERS)
        
    print("Fact Orders table created successfully.")

def main():
    spark = get_spark_session("GoldFactOrders")
    create_fact_orders(spark)

if __name__ == "__main__":
    main()
