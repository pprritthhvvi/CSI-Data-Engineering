# Week 5 – Apache Spark Fundamentals and Data Processing

## Objective

The objective of this assignment is to understand Apache Spark fundamentals and perform data cleaning, transformation, filtering, aggregation, and analysis using Spark DataFrames in Databricks.

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

The dataset contains product-related information such as product ID, title, ratings, prices, seller details, category, discounts, and delivery options.

---

## Project Structure

```
spark-assignment/
│
├── data/
│   └── dataset.csv
│
├── notebook/
│   └── spark_basics.ipynb
│
├── output/
│   └── results.csv
│
├── screenshots/
│
└── README.md
```

---

## Tasks Performed

### Spark Fundamentals

- Created Spark Session
- Loaded dataset into Spark DataFrame
- Explored schema
- Viewed dataset statistics

### Data Cleaning

- Removed duplicate products
- Filled missing values
- Removed invalid records

### Filtering

- Applied multiple filtering conditions
- Selected products based on rating and price

### Transformations

- Renamed columns
- Cast data types
- Created new DataFrames

### Aggregations

- Average Price
- Minimum Price
- Maximum Price
- Category-wise statistics

### Grouping

- Grouped products by category
- Grouped products by seller
- Calculated total revenue

### Pipeline

The final pipeline performs:

1. Remove duplicate products
2. Fill missing prices
3. Group by seller
4. Calculate total revenue

---

## Key Concepts Learned

- Spark vs MapReduce
- In-Memory Computing
- DataFrame Immutability
- Wide Transformations
- Shuffle Operations
- Data Cleaning
- Aggregation
- GroupBy
- Schema Inference

---

## Output

The final processed results are saved in the output folder.

---

## Learning Outcome

This assignment helped in understanding how Apache Spark efficiently processes large datasets using distributed in-memory computing and DataFrame APIs for scalable data analysis.

---

## Author

Prithvi Sahu

B.Tech CSE

SOA University