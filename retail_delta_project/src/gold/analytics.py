# src/gold/analytics.py

from pyspark.sql.functions import col, sum as _sum, count, countDistinct, avg
from src.utils.spark_utils import get_spark_session
from src.config import (
    FACT_ORDERS, DIM_CUSTOMER_SCD2, DIM_PRODUCT_SCD2, SILVER_STORES_CLEAN,
    GOLD_DAILY_SALES, GOLD_CATEGORY_SALES, GOLD_SEGMENT_SALES, GOLD_REGION_SALES
)

def create_analytics_tables(spark):
    """
    Creates high-level aggregated analytics tables in the Gold layer.
    Reads from the conformed fact table and the dimension tables.
    """
    
    df_fact = spark.read.table(FACT_ORDERS).filter(col("order_status") != "cancelled")
    df_cust = spark.read.table(DIM_CUSTOMER_SCD2)
    df_prod = spark.read.table(DIM_PRODUCT_SCD2)
    df_store = spark.read.table(SILVER_STORES_CLEAN)
    
    # 1. Daily Sales
    # Calculate total orders, total revenue, total units, and average order value per day
    df_daily = df_fact.groupBy("order_date").agg(
        countDistinct("order_id").alias("total_orders"),
        _sum("gross_amount").alias("total_revenue"),
        _sum("quantity").alias("total_units"),
        avg("gross_amount").alias("average_order_value")
    )
    
    df_daily.write.format("delta").mode("overwrite").saveAsTable(GOLD_DAILY_SALES)
    print(f"Created {GOLD_DAILY_SALES}")
    
    # 2. Category Sales
    # Calculate orders, revenue, and units sold per product category, ordered by revenue
    # Join using surrogate key to be accurate to the time of    # Category
    print("Aggregating by Category...")
    df_fact.join(df_products, "product_sk") \
        .groupBy("category") \
        .agg(countDistinct("order_id").alias("orders"), _sum("gross_amount").alias("revenue"), _sum("quantity").alias("units_sold")) \
        .orderBy(col("revenue").desc()) \
        .write.format("delta").mode("overwrite").saveAsTable(GOLD_CATEGORY_SALES)

    # Segment
    print("Aggregating by Segment...")
    df_fact.join(df_customers, "customer_sk") \
        .groupBy("segment") \
        .agg(countDistinct("customer_sk").alias("unique_customers"), countDistinct("order_id").alias("orders"), _sum("gross_amount").alias("revenue")) \
        .write.format("delta").mode("overwrite").saveAsTable(GOLD_SEGMENT_SALES)

    # Region
    print("Aggregating by Region...")
    df_fact.join(df_stores, "store_id") \
        .groupBy("region") \
        .agg(countDistinct("order_id").alias("orders"), _sum("gross_amount").alias("revenue"), _sum("quantity").alias("units")) \
        .write.format("delta").mode("overwrite").saveAsTable(GOLD_REGION_SALES)
    print(f"Created {GOLD_REGION_SALES}")

def main():
    spark = get_spark_session("GoldAnalytics")
    create_analytics_tables(spark)

if __name__ == "__main__":
    main()
