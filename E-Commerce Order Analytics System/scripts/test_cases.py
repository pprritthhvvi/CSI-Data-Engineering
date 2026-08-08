import os
import sys
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent.parent


def verify_required_files() -> None:
    required_files = [
        ROOT_DIR / "data" / "cleaned" / "customers_clean.csv",
        ROOT_DIR / "data" / "cleaned" / "products_clean.csv",
        ROOT_DIR / "data" / "cleaned" / "orders_clean.csv",
        ROOT_DIR / "data" / "cleaned" / "order_items_clean.csv",
        ROOT_DIR / "sql" / "schema.sql",
        ROOT_DIR / "scripts" / "load_database.py",
        ROOT_DIR / "scripts" / "report_cli.py",
    ]

    missing_files = [path for path in required_files if not path.exists()]
    if missing_files:
        raise FileNotFoundError(f"Missing files: {missing_files}")


def main() -> None:
    print("Running project smoke tests...")
    verify_required_files()
    print("All required project files are present.")


if __name__ == "__main__":
    main()