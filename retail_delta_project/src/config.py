# src/config.py

# Databricks Unity Catalog & Schemas
CATALOG = "retail_demo"
RAW_SCHEMA = "raw"
SILVER_SCHEMA = "silver"
GOLD_SCHEMA = "gold"

# File Paths
# Assuming the data is uploaded to this volume path in Databricks
BASE_PATH = "/Volumes/retail_demo/raw/retail_files/retail_delta_project"
BATCH_PATH = BASE_PATH
INCR_PATH = BASE_PATH
CHECKPOINT_PATH = f"{BASE_PATH}/_checkpoints"
SCHEMA_PATH = f"{BASE_PATH}/_schemas"

# Table Names
# Bronze
BRONZE_ORDERS = f"{CATALOG}.{RAW_SCHEMA}.bronze_orders"
BRONZE_ORDERS_INCR = f"{CATALOG}.{RAW_SCHEMA}.bronze_orders_incremental"
BRONZE_CUSTOMERS = f"{CATALOG}.{RAW_SCHEMA}.bronze_customers"
BRONZE_CUSTOMERS_CDC = f"{CATALOG}.{RAW_SCHEMA}.bronze_customers_cdc"
BRONZE_PRODUCTS = f"{CATALOG}.{RAW_SCHEMA}.bronze_products"
BRONZE_PRODUCTS_CDC = f"{CATALOG}.{RAW_SCHEMA}.bronze_products_cdc"
BRONZE_STORES = f"{CATALOG}.{RAW_SCHEMA}.bronze_stores"

# Silver 1 (Clean)
SILVER_ORDERS_CLEAN = f"{CATALOG}.{SILVER_SCHEMA}.silver1_orders_clean"
SILVER_CUSTOMERS_CLEAN = f"{CATALOG}.{SILVER_SCHEMA}.silver1_customers_clean"
SILVER_PRODUCTS_CLEAN = f"{CATALOG}.{SILVER_SCHEMA}.silver1_products_clean"
SILVER_STORES_CLEAN = f"{CATALOG}.{SILVER_SCHEMA}.dim_store" # Store is simple, directly to dim

# Silver 2 (SCD2)
DIM_CUSTOMER_SCD2 = f"{CATALOG}.{SILVER_SCHEMA}.dim_customer_scd2"
DIM_PRODUCT_SCD2 = f"{CATALOG}.{SILVER_SCHEMA}.dim_product_scd2"

# Gold
FACT_ORDERS = f"{CATALOG}.{GOLD_SCHEMA}.fact_orders"
GOLD_DAILY_SALES = f"{CATALOG}.{GOLD_SCHEMA}.gold_daily_sales"
GOLD_CATEGORY_SALES = f"{CATALOG}.{GOLD_SCHEMA}.gold_category_sales"
GOLD_SEGMENT_SALES = f"{CATALOG}.{GOLD_SCHEMA}.gold_segment_sales"
GOLD_REGION_SALES = f"{CATALOG}.{GOLD_SCHEMA}.gold_region_sales"
