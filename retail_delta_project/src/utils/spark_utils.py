# src/utils/spark_utils.py

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))

from pyspark.sql import SparkSession

def get_spark_session(app_name="RetailAnalyticsPipeline"):
    """
    Get or create a SparkSession.
    In Databricks, SparkSession is already provided as 'spark', 
    but this is good practice for portability.
    """
    spark = SparkSession.builder \
        .appName(app_name) \
        .getOrCreate()
    return spark

def setup_databases(spark):
    """
    Creates the required catalog and schemas if they don't exist.
    """
    from src.config import CATALOG, RAW_SCHEMA, SILVER_SCHEMA, GOLD_SCHEMA
    
    spark.sql(f"CREATE CATALOG IF NOT EXISTS {CATALOG}")
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {CATALOG}.{RAW_SCHEMA}")
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {CATALOG}.{SILVER_SCHEMA}")
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {CATALOG}.{GOLD_SCHEMA}")
    print("Catalog and Schemas verified/created successfully.")

if __name__ == "__main__":
    spark = get_spark_session("SetupDatabases")
    setup_databases(spark)

