# Week 6 – Apache Spark Architecture and Performance

## Objective

The objective of this assignment is to understand Apache Spark architecture, execution model, lazy evaluation, transformations, actions, schema handling, optimized file formats, and efficient data processing using Spark DataFrames.

---

## Technologies Used

- Apache Spark
- PySpark
- Databricks Community Edition
- Python
- GitHub

---

## Dataset

Dataset Name:

dataset.csv

The dataset contains product information including product ID, title, category, ratings, prices, seller information, discounts, and delivery details.

---

## Project Structure

```
Spark_Assignment_week_6/
│
├── data/
│   └── dataset.csv
│
├── notebook/
│   └── spark_architecture.ipynb
│
├── output/
│   ├── output_csv/
│   └── output_parquet/
│
├── screenshots/
│
└── README.md
```

---

## Tasks Performed

### Spark Architecture

- Driver
- Cluster Manager
- Executors
- Client Mode
- Cluster Mode

### Spark Execution

- Lazy Evaluation
- DAG (Lineage Graph)

### Data Loading

- CSV
- Parquet

### Data Processing

- Filtering
- Selecting Columns
- Renaming Columns
- Type Casting
- Adding New Columns

### Data Cleaning

- Removing Duplicates
- Handling Null Values

### Performance Optimization

- Predicate Pushdown
- Wide Transformations
- Shuffle Operations

### Output

- Saved processed data as CSV
- Saved processed data as Parquet

---

## Final Pipeline

1. Load Dataset
2. Remove Duplicate Products
3. Handle Missing Values
4. Filter Required Records
5. Add New Columns
6. Select Required Columns
7. Save CSV Output
8. Save Parquet Output

---

## Key Concepts Learned

- Spark Architecture
- Driver and Executors
- Lazy Evaluation
- DAG
- Transformations
- Actions
- Predicate Pushdown
- Shuffle
- CSV vs Parquet
- Data Cleaning
- Spark Performance Optimization

---

## Learning Outcome

This assignment helped in understanding Spark architecture, execution optimization, schema handling, distributed processing, and efficient storage formats for large-scale data analytics.

---

## Note

The assignment questions reference example columns such as `status`, `amount`, `region`, and `user_id`. The provided dataset contains product-related fields instead. Therefore, equivalent columns (`product_id`, `category`, `rating`, `initial_price`, `final_price`, etc.) were used to demonstrate the required Spark concepts while keeping all code executable.

---

## Author

Prithvi Sahu

B.Tech CSE

SOA University