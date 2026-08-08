# Retail E-Commerce Sales Analytics Pipeline
**Celebal Technologies - Summer Internship Final Project Submission**

## 📌 Project Overview
This project is an end-to-end data engineering pipeline built on **Databricks** using **PySpark** and **Delta Lake**. It processes historical batch data and daily incremental data (CDC) for a retail e-commerce business, transforming raw data into business-ready analytics following the strict **Medallion Data Architecture** (Bronze, Silver, and Gold layers).

---

## 🏗️ Architecture & Technologies
* **Compute:** Databricks Serverless (Strict ANSI SQL compliance enforced)
* **Storage:** Databricks Unity Catalog (Volumes) & Delta Lake
* **Processing:** PySpark (Batch & Structured Streaming via Auto Loader)
* **Concepts Implemented:** Medallion Architecture, Slowly Changing Dimensions (SCD Type 2), Change Data Capture (CDC), Surrogate Keys, Databricks Auto Loader (`cloudFiles`).

---

## 🚀 Setup & Execution Guide

### 1. Workspace Configuration
1. Open Databricks Workspace and navigate to the **Catalog** explorer.
2. Create the Unity Catalog structure: `retail_demo` (Catalog) ➡️ `raw` (Schema) ➡️ `retail_files` (Volume).
3. Inside the `retail_files` volume, create a directory named `retail_delta_project`.
4. Upload all CSV datasets (Orders, Customers, Products, Stores) directly into the `retail_delta_project` directory.

### 2. Code Execution
1. Import the provided `Retail_Pipeline_Notebook.py` (or `.ipynb`) into your Databricks Workspace.
2. Attach the notebook to a Serverless or standard Databricks cluster.
3. Click **Run All** to execute the pipeline end-to-end.

---

## 📊 Step-by-Step Execution Report

### Step 1: Configuration & Setup
* **Action:** Initialized dynamic paths mapping to the Unity Catalog Volume. Programmatically created the Unity Catalog schemas (`raw`, `silver`, `gold`).
* **Execution Output:**
```text
Catalog and Schemas verified/created successfully.
```

### Step 2: Bronze Layer (Raw Data Ingestion)
* **Action:** Ingested historical dumps for Orders, Customers, Products, and Stores using standard `spark.read.csv()`. Utilized **Databricks Auto Loader** (`cloudFiles`) to seamlessly stream incoming daily CDC files.
* **Traceability:** Automatically appended auditing metadata (`_metadata.file_path`, `ingestion_ts`, `load_type`) to all rows.
* **Execution Output:**
```text
Reading batch file from: /Volumes/retail_demo/raw/retail_files/retail_delta_project/orders_batch.csv
Successfully ingested orders_batch.csv into retail_demo.raw.bronze_orders.
Reading batch file from: /Volumes/retail_demo/raw/retail_files/retail_delta_project/customers_batch.csv
Successfully ingested customers_batch.csv into retail_demo.raw.bronze_customers.
Reading batch file from: /Volumes/retail_demo/raw/retail_files/retail_delta_project/products_batch.csv
Successfully ingested products_batch.csv into retail_demo.raw.bronze_products.
Reading batch file from: /Volumes/retail_demo/raw/retail_files/retail_delta_project/stores_batch.csv
Successfully ingested stores_batch.csv into retail_demo.raw.bronze_stores.

Starting incremental stream for: /Volumes/retail_demo/raw/retail_files/retail_delta_project/orders_incremental_*.csv into retail_demo.raw.bronze_orders_incr
Finished incremental run for retail_demo.raw.bronze_orders_incr.
Starting incremental stream for: /Volumes/retail_demo/raw/retail_files/retail_delta_project/customers_cdc_*.csv into retail_demo.raw.bronze_customers_cdc
Finished incremental run for retail_demo.raw.bronze_customers_cdc.
Starting incremental stream for: /Volumes/retail_demo/raw/retail_files/retail_delta_project/products_cdc_*.csv into retail_demo.raw.bronze_products_cdc
Finished incremental run for retail_demo.raw.bronze_products_cdc.
```

### Step 3: Silver Layer - Stage 1 (Data Cleansing)
* **Action:** Addressed malformed source data (e.g., dates like `2026-99-99`) by enforcing ANSI-compliant PySpark functions like `expr("try_cast(...)")` and `expr("try_to_timestamp(...)")`. Deduplicated records using PySpark `Window` functions to extract only the latest unique record from the unioned Batch and CDC data.
* **Execution Output:**
```text
Orders cleaned.
Customers cleaned.
Products cleaned.
Stores cleaned.
```

### Step 4: Silver Layer - Stage 2 (SCD Type 2)
* **Action:** Generated SHA-256 hashes (`hash_value`) using `concat_ws` across all dimensional attributes to easily detect data changes. Implemented complex `MERGE INTO` operations for `dim_customer_scd2` and `dim_product_scd2`.
* **Execution Output:**
```text
Customer SCD2 complete.
Product SCD2 complete.
```

#### 🛡️ SCD Type 2 Validation & Proof
To prove SCD Type 2 tracked historical changes over time, a manual `UPDATE` was run on Customer `C00001`'s city in the Silver 1 table, changing it from "Delhi" to "New Fake City". Upon re-running the SCD2 merge, the pipeline successfully expired the old record and inserted the new active record.
* **SCD2 Query Output:**
```text
| customer_id | customer_name | city          | effective_start_date | effective_end_date | is_current |
|-------------|---------------|---------------|----------------------|--------------------|------------|
| C00001      | Customer_1    | New Fake City | 2026-08-08           | 9999-12-31         | true       |
| C00001      | Customer_1    | Delhi         | 2026-08-08           | 2026-08-07         | false      |
```

### Step 5: Gold Layer (Conformed Facts & Aggregations)
* **Action:** Joined the clean Orders table with the SCD Type 2 Dimension tables using temporal joins (matching exact `order_date` to the dimension's active date ranges). Mapped natural keys to surrogate keys (`customer_sk` and `product_sk`). Created 4 Business Analytics tables (`gold_daily_sales`, `gold_category_sales`, `gold_segment_sales`, `gold_region_sales`).
* **Execution Output:**
```text
Fact Orders created.
All Gold Analytics tables created successfully! Pipeline Complete.
```

---

## 💡 Final Results & Analytics Output
The pipeline successfully created a robust, queryable Gold layer ready for BI tool consumption. 

**Example Business Insight Query:**
```sql
SELECT 
    category, 
    orders, 
    units_sold, 
    round(revenue, 2) AS total_revenue 
FROM retail_demo.gold.gold_category_sales 
ORDER BY revenue DESC 
LIMIT 5;
```

*Project successfully completed, fully tested, and validated.*
