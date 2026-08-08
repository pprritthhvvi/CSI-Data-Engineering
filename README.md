# 🚀 Data Engineering003 Internship – Celebal Technologies 2026

## 📌 Internship Details

| Field | Details |
|-------|----------|
| **Organization** | Celebal Technologies |
| **Domain** | Data Engineering |
| **Duration** | 8 Weeks |
| **Technologies** | SQL, Python, Pandas, MySQL, Apache Spark (PySpark), ETL, Big Data, Azure Data Factory, Git & GitHub |

---

# 📖 Introduction

During my **8-week Data Engineering Internship at Celebal Technologies**, I gained practical experience in the complete **Data Engineering lifecycle**, from collecting raw data to transforming it into meaningful insights for analytics and business intelligence.

The internship combined theoretical learning with hands-on assignments, helping me understand how modern data engineering solutions are designed and implemented. Throughout the program, I worked on SQL databases, Python programming, data cleaning with Pandas, ETL concepts, Big Data fundamentals, Apache Spark, Azure Data Factory concepts, and data pipeline architecture.

By the end of the internship, I developed a solid understanding of how data is extracted, transformed, loaded, stored, analyzed, and prepared for reporting and machine learning applications.

---

# 🗓 Week 1 – SQL Fundamentals

SQL formed the foundation of the internship by introducing relational databases and data manipulation techniques.

## Topics Covered

- Database Concepts
- DBMS vs RDBMS
- MySQL Installation & Setup
- Creating Databases
- Creating Tables
- SQL Data Types
- Constraints
  - Primary Key
  - Foreign Key
  - NOT NULL
  - UNIQUE
  - DEFAULT
- INSERT
- UPDATE
- DELETE
- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- LIKE
- BETWEEN
- IN
- IS NULL
- Aliases

## Practical Skills

- Created relational databases.
- Designed tables using constraints.
- Inserted, updated, deleted, and retrieved records.
- Practiced filtering and sorting using SQL queries.

---

# 🗓 Week 2 – Advanced SQL

This week focused on writing optimized SQL queries for reporting and analytics.

## Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

## GROUP BY

Grouped records based on departments and categories.

## HAVING

Filtered grouped records.

## CASE Statements

Implemented conditional logic.

Example:

- High Salary
- Medium Salary
- Low Salary

## ORDER BY

Sorted records in ascending and descending order.

---

# 🗓 Week 3 – SQL Joins, Subqueries & Advanced SQL

## SQL Joins

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN (using UNION in MySQL)

Learned how relational databases connect tables using Primary Keys and Foreign Keys.

---

## SQL Subqueries

Studied various types of subqueries.

### Types

- Single Row Subquery
- Multi Row Subquery
- Correlated Subquery
- Subquery in SELECT
- Subquery in WHERE
- Subquery in FROM

---

## Common Table Expressions (CTE)

Learned the SQL WITH Clause.

Covered:

- Reusable Query Blocks
- Nested CTEs
- Multiple CTEs

### Advantages

- Improved readability
- Easier debugging
- Better query organization
- Reusable SQL logic

---

## Window Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- ORDER BY

Used for ranking employees, department-wise analysis, and advanced reporting.

---

## Transactions & ACID Properties

### Transactions

- START TRANSACTION
- COMMIT
- ROLLBACK
- SAVEPOINT

### ACID Properties

- Atomicity
- Consistency
- Isolation
- Durability

---

# 🗓 Week 4 – Python Programming

Developed programming skills required for data engineering.

## Topics Covered

- Variables
- Data Types
- Operators
- Conditional Statements
- Loops
- Functions
- Lists
- Tuples
- Dictionaries
- Sets
- File Handling
- Exception Handling
- Modules
- Basic Object-Oriented Programming

## Practical Work

- Python problem-solving
- File operations
- Modular programming
- Data manipulation

---

# 🗓 Week 5 – Pandas for Data Analysis

One of the most practical weeks of the internship.

## DataFrame Operations

- Creating DataFrames
- Reading CSV Files
- Writing CSV Files
- Selecting Rows & Columns
- Sorting
- Filtering
- Indexing
- Slicing

---

## Data Cleaning

Learned how to:

- Handle Missing Values
- Fill Missing Data
- Drop Missing Values
- Remove Duplicate Records
- Rename Columns
- Change Data Types
- Feature Engineering

---

## Data Transformation

Worked with:

- apply()
- transform()
- filter()
- agg()

---

## GroupBy Operations

Studied:

- groupby()
- subgrouping
- agg()
- apply()
- transform()
- filter()

### Aggregation Functions

- Sum
- Mean
- Count
- Min
- Max
- Median
- Standard Deviation
- Variance

---

# 🗓 Week 6 – ETL & Data Warehousing

Learned how enterprise ETL pipelines work.

## ETL

Extract → Transform → Load

### Extract

Collect data from source systems.

### Transform

- Clean
- Validate
- Modify
- Standardize
- Aggregate

### Load

Store transformed data inside a Data Warehouse.

---

## ELT

Extract → Load → Transform

Compared ETL vs ELT and identified suitable use cases.

---

## Data Loading Techniques

### Initial Load

Load complete dataset once.

### Full Load

Reload entire dataset every execution.

### Incremental Load

Process only:

- New Records
- Updated Records
- Deleted Records

---

## Change Detection Methods

- Timestamp
- Auto Increment ID
- Change Data Capture (CDC)
- Hash Comparison

---

## Slowly Changing Dimensions (SCD)

- Type 0
- Type 1
- Type 2
- Type 3

---

# 🗓 Week 7 – Big Data & Apache Spark

Learned why traditional databases are insufficient for processing massive datasets.

## Big Data

### The 5 V's

- Volume
- Velocity
- Variety
- Veracity
- Value

---

## Batch Processing

Examples:

- Payroll
- Billing
- Monthly Reports

---

## Stream Processing

Examples:

- Fraud Detection
- Banking
- UPI Transactions
- GPS Tracking
- IoT Devices

---

## Apache Spark

Studied Spark Architecture:

- Driver
- Cluster Manager
- Executors
- Partitions

---

## Spark Components

- Spark Core
- Spark SQL
- Spark Streaming
- MLlib
- GraphX

---

## PySpark

Worked with:

- SparkSession
- DataFrame
- select()
- show()
- filter()
- where()
- groupBy()
- orderBy()
- withColumn()
- withColumnRenamed()
- Spark SQL

---

# 🗓 Week 8 – Data Pipelines & Azure Concepts

Learned the design of modern enterprise data pipelines.

## Azure Data Factory Concepts

- Linked Services
- Datasets
- Pipelines
- Activities
- Copy Activity
- Lookup Activity
- Get Metadata
- ForEach
- If Condition
- Execute Pipeline

---

## Data Pipeline Architecture

```text
Source
   ↓
Extract
   ↓
Transform
   ↓
Validate
   ↓
Load
   ↓
Data Warehouse
   ↓
Visualization / Analytics
```

---

# 💻 Projects & Hands-on Assignments

Throughout the internship, I completed several practical assignments and mini-projects.

### SQL

- Employee Database
- Customer & Orders Database
- Aggregate Functions
- GROUP BY Analysis
- SQL Joins
- SQL Subqueries
- CTE Practice
- Window Functions

### Python

- File Handling
- Data Processing
- CSV Operations

### Pandas

- Employee Dataset Analysis
- Data Cleaning
- Data Transformation
- GroupBy Analysis
- Aggregation

### Apache Spark

- Spark DataFrame Operations
- Spark SQL
- GroupBy Analysis
- Data Processing

### ETL

- ETL Workflow
- Incremental Loading
- Data Warehouse Concepts

---

# 🛠 Technical Skills Gained

## SQL

- CRUD Operations
- Aggregate Functions
- GROUP BY
- HAVING
- CASE
- JOINS
- Subqueries
- CTE
- Window Functions
- Transactions
- ACID Properties

---

## Python

- Core Python
- Functions
- File Handling
- Exception Handling
- OOP Basics

---

## Pandas

- DataFrames
- Cleaning
- Transformation
- Aggregation
- GroupBy
- Apply
- Transform
- Filter

---

## Big Data

- Big Data Fundamentals
- Batch Processing
- Stream Processing
- Apache Spark
- PySpark

---

## ETL & Data Warehousing

- ETL
- ELT
- Incremental Loading
- SCD Types
- Data Warehousing

---

## Data Engineering Concepts

- Data Pipelines
- Data Validation
- Data Cleaning
- Schema Design
- Data Transformation

---

# 🧰 Tools & Technologies

- Python
- Pandas
- NumPy
- MySQL
- SQLTools (VS Code)
- Jupyter Notebook
- Visual Studio Code
- Apache Spark (PySpark)
- Git
- GitHub
- Azure Data Factory (Concepts)

---

# 🚧 Challenges Faced

During the internship, I encountered several practical challenges, including:

- Handling missing and inconsistent data.
- Writing optimized SQL queries.
- Understanding complex joins, subqueries, and window functions.
- Cleaning and transforming real-world datasets.
- Learning distributed data processing concepts using Spark.
- Understanding ETL workflows and incremental loading strategies.
- Designing data pipelines conceptually using Azure Data Factory.

These challenges improved my analytical thinking, debugging skills, and problem-solving approach.

---

# 🎯 Learning Outcomes

By the end of the internship, I was able to:

- Design relational databases using SQL.
- Write optimized SQL queries using joins, subqueries, CTEs, and window functions.
- Perform data cleaning and preprocessing using Pandas.
- Analyze datasets using GroupBy, aggregation, transformation, and filtering.
- Understand ETL/ELT workflows and data warehousing concepts.
- Explain Big Data concepts, including the 5 V's, batch processing, and stream processing.
- Work with Apache Spark DataFrames and PySpark transformations.
- Understand Azure Data Factory concepts and enterprise data pipeline architecture.
- Use Git and GitHub for version control and project management.
- Apply data engineering concepts to solve practical data processing problems.

---

# 📚 Key Concepts Covered

- SQL Fundamentals
- Advanced SQL
- Aggregate Functions
- GROUP BY
- HAVING
- CASE Statements
- Joins
- Subqueries
- Common Table Expressions (CTE)
- Window Functions
- Transactions
- ACID Properties
- Python Programming
- Pandas
- Data Cleaning
- Data Transformation
- Feature Engineering
- ETL & ELT
- Initial, Full & Incremental Loading
- Slowly Changing Dimensions
- Big Data
- Batch vs Stream Processing
- Apache Spark
- PySpark
- Azure Data Factory Concepts
- Data Pipelines
- Git & GitHub

---

# 🎓 Conclusion

The **8-week Data Engineering Internship at Celebal Technologies** provided me with a strong foundation in modern data engineering practices. Through structured learning, coding assignments, and hands-on projects, I developed practical skills in **SQL, Python, Pandas, ETL, Data Warehousing, Big Data, Apache Spark, PySpark, and Azure Data Factory concepts**.

This internship enhanced my understanding of how raw data is collected, cleaned, transformed, stored, and analyzed using industry-standard tools and workflows. It also strengthened my problem-solving abilities, analytical thinking, debugging skills, and familiarity with modern data engineering practices.

The knowledge and practical experience gained during this internship have prepared me to take on future opportunities in **Data Engineering, Data Analytics, Big Data, and Cloud Data Engineering**, while providing a strong foundation for continuous learning and professional growth.

---

## 🙏 Acknowledgement

I sincerely thank **Celebal Technologies** for providing this internship opportunity and for offering a structured learning environment that helped me strengthen my technical knowledge and practical skills in Data Engineering. I also appreciate the guidance provided by the mentors and instructors throughout the internship, which played an important role in my learning journey.
