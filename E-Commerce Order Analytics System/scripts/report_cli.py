import argparse
import os
import sys
from typing import List, Tuple

import mysql.connector
from mysql.connector import Error
from tabulate import tabulate


DB_HOST = os.getenv("MYSQL_HOST", "localhost")
DB_PORT = int(os.getenv("MYSQL_PORT", "3306"))
DB_USER = os.getenv("MYSQL_USER", "root")
DB_PASSWORD = os.getenv("MYSQL_PASSWORD", "123456")
DB_NAME = os.getenv("MYSQL_DATABASE", "ecommerce_analytics")


def get_connection():
    """Create a MySQL connection for the reporting CLI."""
    return mysql.connector.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        autocommit=True,
    )


def fetch_report_data(cursor, report_name: str):
    """Return report rows and headers for the requested report."""
    if report_name == "revenue":
        sql = """
        SELECT
            DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
            SUM(oi.quantity * oi.unit_price) AS revenue
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY order_month
        ORDER BY order_month
        """
    elif report_name == "top_customers":
        sql = """
        SELECT
            c.customer_name,
            SUM(oi.quantity * oi.unit_price) AS total_revenue,
            COUNT(DISTINCT o.order_id) AS order_count
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY c.customer_id, c.customer_name
        ORDER BY total_revenue DESC
        LIMIT 10
        """
    elif report_name == "retention":
        sql = """
        WITH first_purchase AS (
            SELECT
                customer_id,
                DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
            FROM orders
            GROUP BY customer_id
        ), activity AS (
            SELECT
                fp.customer_id,
                fp.cohort_month,
                DATE_FORMAT(o.order_date, '%Y-%m') AS order_month
            FROM first_purchase fp
            JOIN orders o ON fp.customer_id = o.customer_id
        )
        SELECT
            cohort_month,
            order_month,
            COUNT(DISTINCT customer_id) AS active_customers
        FROM activity
        GROUP BY cohort_month, order_month
        ORDER BY cohort_month, order_month
        """
    elif report_name == "products":
        sql = """
        SELECT
            p.product_name,
            SUM(oi.quantity * oi.unit_price) AS revenue,
            SUM(oi.quantity) AS units_sold
        FROM products p
        JOIN order_items oi ON p.product_id = oi.product_id
        GROUP BY p.product_id, p.product_name
        ORDER BY revenue DESC
        LIMIT 10
        """
    else:
        raise ValueError(f"Unsupported report: {report_name}")

    cursor.execute(sql)
    rows = cursor.fetchall()
    headers = [col[0] for col in cursor.description] if cursor.description else []
    return headers, rows


def print_report(headers: List[str], rows: List[Tuple]) -> None:
    if not rows:
        print("No data available for this report.")
        return

    print(tabulate(rows, headers=headers, tablefmt="grid"))


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Generate analytics reports from the MySQL database")
    parser.add_argument(
        "--report",
        required=True,
        choices=["revenue", "top_customers", "retention", "products"],
        help="Choose the report to display",
    )
    return parser


def main() -> None:
    parser = build_argument_parser()
    args = parser.parse_args()

    try:
        connection = get_connection()
        cursor = connection.cursor()
        headers, rows = fetch_report_data(cursor, args.report)
        print_report(headers, rows)
    except Error as exc:
        print(f"MySQL error: {exc}")
        sys.exit(1)
    except ValueError as exc:
        print(str(exc))
        sys.exit(2)
    finally:
        if "cursor" in locals() and cursor is not None:
            cursor.close()
        if "connection" in locals() and connection is not None:
            connection.close()


if __name__ == "__main__":
    main()