# E-Commerce Order Analytics System

## Project Overview
This project builds a complete end-to-end e-commerce analytics pipeline using Python and MySQL. It covers data generation, cleaning, loading into a relational database, SQL analytics, and a command-line reporting tool.

## Architecture
The project is organized into four main layers:
1. Data generation and cleaning using Python and pandas.
2. Relational storage in MySQL.
3. Analytical queries in SQL for business insights.
4. CLI reporting with argparse and tabulate.

## Folder Structure
- data/raw: raw synthetic datasets
- data/cleaned: cleaned datasets
- scripts: Python scripts for generation, cleaning, loading, reporting, and tests
- sql: MySQL-compatible schema and analytics queries
- output/reports: generated report files and session logs
- output/screenshots: screenshots and visual evidence

## Installation
1. Create a virtual environment.
2. Install the required packages:
   ```bash
   pip install -r requirements.txt
   ```
3. Start MySQL 8.x locally and ensure the database credentials match the defaults in the scripts.
4. From the project root, run the commands below in order.

## Requirements
- Python 3.13+
- MySQL 8.x
- pandas
- faker
- mysql-connector-python
- tabulate

## Execution Steps
Run the following commands from the project root:

```bash
python scripts/generate_data.py
python scripts/clean_data.py
python scripts/test_cases.py
python scripts/load_database.py
python scripts/report_cli.py --report revenue
python scripts/report_cli.py --report top_customers
python scripts/report_cli.py --report retention
python scripts/report_cli.py --report products
```

### What each step does
- Generate synthetic raw datasets for customers, products, orders, and order items.
- Clean and export the data into the cleaned CSV files under the data folder.
- Validate that the required project files are present.
- Load the cleaned datasets into MySQL and verify the row counts.
- Produce business reports for revenue, top customers, retention, and products.

## Session Reports
The project now includes structured session logs under the output reports folder:
- [output/reports/session_summary.md](output/reports/session_summary.md)
- [output/reports/session_reports/session_01_data_generation.txt](output/reports/session_reports/session_01_data_generation.txt)
- [output/reports/session_reports/session_02_data_cleaning.txt](output/reports/session_reports/session_02_data_cleaning.txt)
- [output/reports/session_reports/session_03_project_tests.txt](output/reports/session_reports/session_03_project_tests.txt)
- [output/reports/session_reports/session_04_mysql_load.txt](output/reports/session_reports/session_04_mysql_load.txt)
- [output/reports/session_reports/session_05_reporting_cli.txt](output/reports/session_reports/session_05_reporting_cli.txt)

## Terminal Output Summary
The latest verified execution results are summarized below:
- Dataset generation completed successfully.
- Data cleaning completed successfully and exported cleaned CSV files.
- Project smoke tests passed.
- MySQL loading completed successfully and loaded 493 orders and 489 order items.
- CLI reports can be generated after the database load completes.

### Example CLI output
The revenue report command was verified successfully and produced a monthly revenue table in the terminal.

### How to read the output
- Revenue report: shows monthly revenue trends. Larger values indicate stronger sales performance.
- Top customers report: lists customers with the highest total spend or order volume.
- Retention report: highlights repeat-purchase behavior and customer loyalty over time.
- Products report: identifies the best-selling or highest-revenue products.

## Screenshots
Add screenshots of the CLI output and database schema inside the output/screenshots folder.

## SQL Features Used
- SELECT, WHERE, ORDER BY, GROUP BY, COUNT, SUM, AVG, MIN, MAX
- JOINs and subqueries
- Window functions such as ROW_NUMBER and RANK
- CTE-based cohort analysis

## Python Features Used
- pandas for data cleaning and transformation
- Faker for synthetic data generation
- mysql-connector-python for database integration
- argparse and tabulate for the reporting interface

## Future Improvements
- Add automated tests for the SQL queries
- Build a dashboard with Streamlit or Power BI
- Add Docker support for a reproducible environment
- Expand reporting for customer segmentation and retention forecasting