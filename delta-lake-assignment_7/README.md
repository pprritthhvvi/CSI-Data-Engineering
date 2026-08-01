# Week 7 – Delta Lake MERGE Implementation

## Objective

The objective of this assignment is to understand Delta Lake concepts and implement incremental data processing using the MERGE operation in Databricks. The assignment demonstrates ACID transactions, table versioning, data cleaning, MERGE (UPSERT), validation, and Delta Lake architecture.

---

## Technologies Used

- Databricks Community Edition
- Apache Spark
- PySpark
- Delta Lake
- Python
- GitHub

---

## Project Structure

```
delta-lake-assignment/
│
├── data/
│   ├── customer_master.csv
│   └── customer_incremental.csv
│
├── notebooks/
│   └── delta_merge_assignment.ipynb
│
├── output/
│
├── screenshots/
│   ├── 01_cluster/
│   ├── 02_data_loading/
│   ├── 03_cleaning/
│   ├── 04_merge/
│   ├── 05_validation/
│   └── 06_final_output/
│
├── report/
│
└── README.md
```

---

## Assignment Workflow

### 1. Created Spark Session

- Initialized Spark in Databricks
- Verified Spark Version

---

### 2. Created Customer Master Dataset

Created a sample customer dataset containing:

- Customer ID
- Customer Name
- City
- Salary

Stored the dataset as a Delta Table.

---

### 3. Data Cleaning

Performed basic preprocessing:

- Removed duplicate customer records
- Filled missing salary values
- Validated cleaned dataset

---

### 4. Created Incremental Dataset

Created another dataset to simulate new incoming data containing:

- Existing customers (to update)
- New customers (to insert)

---

### 5. Delta MERGE (UPSERT)

Implemented Delta Lake MERGE operation.

Operations performed:

- Updated existing customer records
- Inserted new customer records

This demonstrates incremental data processing using Delta Lake.

---

### 6. Validation

Validated:

- Final row count
- Duplicate customer IDs
- Updated records
- Newly inserted records

---

### 7. Delta Lake Features

Implemented:

- ACID Transactions
- Table Version History
- Time Travel
- MERGE Operation

---

### 8. Data Architecture

Learned Medallion Architecture:

Bronze Layer

↓

Silver Layer

↓

Gold Layer

---

## Key Concepts Covered

- Delta Lake
- ACID Transactions
- Versioning
- Time Travel
- MERGE INTO
- UPSERT
- Spark SQL
- Data Cleaning
- Validation
- Medallion Architecture

---

## Screenshots Included

- Spark Session
- Master Dataset
- Delta Table
- Data Cleaning
- Incremental Dataset
- MERGE Operation
- Final Output
- Row Count Validation
- Duplicate Validation
- Version History
- Time Travel
- ACID Properties
- Medallion Architecture

---

## Learning Outcome

This assignment helped in understanding how Delta Lake supports reliable and scalable data engineering through ACID transactions, version control, incremental processing, and MERGE operations for modern data pipelines.

---

## Author

**Prithvi Sahu**

B.Tech Computer Science & Engineering

SOA University