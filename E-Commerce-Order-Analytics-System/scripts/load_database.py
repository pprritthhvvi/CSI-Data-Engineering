import os
import subprocess
import sys
from pathlib import Path

import pandas as pd

try:
    import mysql.connector
    from mysql.connector import Error
except Exception:  # pragma: no cover - fallback for environments without a compatible connector
    mysql = None
    Error = Exception


ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data" / "cleaned"
SQL_DIR = ROOT_DIR / "sql"

DB_HOST = os.getenv("MYSQL_HOST", "localhost")
DB_PORT = int(os.getenv("MYSQL_PORT", "3306"))
DB_USER = os.getenv("MYSQL_USER", "root")
DB_PASSWORD = os.getenv("MYSQL_PASSWORD", "123456")
DB_NAME = os.getenv("MYSQL_DATABASE", "ecommerce_analytics")


def get_connection():
    """Create a MySQL connection using the project settings."""
    if mysql is None:
        raise RuntimeError("mysql-connector-python is not available")

    return mysql.connector.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        autocommit=True,
    )


def load_csv_data():
    """Load the cleaned CSV datasets from the data folder."""
    files = {
        "customers": DATA_DIR / "customers_clean.csv",
        "products": DATA_DIR / "products_clean.csv",
        "orders": DATA_DIR / "orders_clean.csv",
        "order_items": DATA_DIR / "order_items_clean.csv",
    }

    for table_name, file_path in files.items():
        if not file_path.exists():
            raise FileNotFoundError(f"Missing expected file: {file_path}")

    customers = pd.read_csv(files["customers"])
    products = pd.read_csv(files["products"])
    orders = pd.read_csv(files["orders"])
    order_items = pd.read_csv(files["order_items"])

    valid_customer_ids = set(customers["customer_id"].dropna().astype(int))
    valid_product_ids = set(products["product_id"].dropna().astype(int))

    orders = orders[orders["customer_id"].fillna(-1).astype(int).isin(valid_customer_ids)]
    order_items = order_items[order_items["order_id"].isin(orders["order_id"])]
    order_items = order_items[order_items["product_id"].fillna(-1).astype(int).isin(valid_product_ids)]

    return {
        "customers": customers,
        "products": products,
        "orders": orders,
        "order_items": order_items,
    }


def normalize_dataframe(dataframe):
    """Convert pandas values into MySQL-friendly Python values."""
    normalized = dataframe.copy()

    for column in normalized.columns:
        normalized[column] = normalized[column].where(pd.notna(normalized[column]), None)

        if column in {"quantity"}:
            normalized[column] = normalized[column].apply(
                lambda value: 0 if value is None else max(0, int(value))
            )
        elif column in {"price", "unit_price", "discount"}:
            normalized[column] = normalized[column].apply(
                lambda value: None if value is None else float(value)
            )
        elif column in {"customer_id", "product_id", "order_id", "order_item_id", "stock"}:
            normalized[column] = normalized[column].apply(
                lambda value: None if value is None else int(value)
            )

    return normalized


def insert_table_data(cursor, table_name, dataframe):
    """Insert rows from a pandas DataFrame into the target MySQL table."""
    records = normalize_dataframe(dataframe).to_dict(orient="records")
    columns = list(dataframe.columns)
    placeholders = ", ".join(["%s"] * len(columns))
    column_sql = ", ".join(columns)
    sql = f"INSERT INTO `{table_name}` ({column_sql}) VALUES ({placeholders})"

    cursor.executemany(sql, [tuple(record.get(column) for column in columns) for record in records])


def create_schema(cursor):
    """Create the schema and tables in MySQL."""
    schema_file = SQL_DIR / "schema.sql"
    if not schema_file.exists():
        raise FileNotFoundError(f"Missing schema file: {schema_file}")

    with schema_file.open("r", encoding="utf-8") as file_handle:
        statements = file_handle.read().split(";")

    for statement in statements:
        statement = statement.strip()
        if statement:
            cursor.execute(statement)


def verify_row_counts(cursor):
    """Print row counts for all target tables."""
    tables = ["customers", "products", "orders", "order_items"]

    print("\nRow Counts")
    print("-" * 30)

    for table_name in tables:
        cursor.execute(f"SELECT COUNT(*) FROM `{table_name}`")
        row_count = cursor.fetchone()[0]
        print(f"{table_name:<15}: {row_count}")


def run_mysql_cli(sql_script_path):
    """Use the MySQL CLI to execute a SQL script when the Python connector is not usable."""
    mysql_executable = os.getenv("MYSQL_BIN", r"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe")
    if not os.path.exists(mysql_executable):
        raise FileNotFoundError(f"MySQL CLI not found at {mysql_executable}")

    command = [
        mysql_executable,
        f"-h{DB_HOST}",
        f"-P{DB_PORT}",
        f"-u{DB_USER}",
        f"-p{DB_PASSWORD}",
        "--protocol=TCP",
        "--force",
        "<",
        str(sql_script_path),
    ]
    result = subprocess.run(
        " ".join(command),
        shell=True,
        capture_output=True,
        text=True,
        check=False,
    )

    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or result.stdout.strip())


def main():
    print("=" * 60)
    print("Loading cleaned datasets into MySQL")
    print("=" * 60)

    try:
        if mysql is not None:
            try:
                connection = get_connection()
            except Exception as exc:
                raise RuntimeError(
                    "Could not connect to MySQL with the Python connector. "
                    f"Please verify the local MySQL server and credentials. Details: {exc}"
                ) from exc

            cursor = connection.cursor()

            cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}`")
            cursor.execute(f"USE `{DB_NAME}`")
            create_schema(cursor)

            datasets = load_csv_data()
            insert_table_data(cursor, "customers", datasets["customers"])
            insert_table_data(cursor, "products", datasets["products"])
            insert_table_data(cursor, "orders", datasets["orders"])
            insert_table_data(cursor, "order_items", datasets["order_items"])

            verify_row_counts(cursor)
            connection.commit()
            print("\nData loaded successfully into MySQL.")
        else:
            schema_path = SQL_DIR / "schema.sql"
            if not schema_path.exists():
                raise FileNotFoundError(f"Missing schema file: {schema_path}")
            run_mysql_cli(schema_path)
            print("\nSchema created successfully via MySQL CLI.")
    except Error as exc:
        print(f"MySQL error: {exc}")
        sys.exit(1)
    except Exception as exc:  # pragma: no cover - defensive logging
        print(f"Unexpected error: {exc}")
        print("Please verify that MySQL 8.x is running locally and that the server is reachable on the configured host/port.")
        sys.exit(1)
    finally:
        if "cursor" in locals() and cursor is not None:
            cursor.close()
        if "connection" in locals() and connection is not None:
            connection.close()


if __name__ == "__main__":
    main()