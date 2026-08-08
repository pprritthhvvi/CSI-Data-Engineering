import pandas as pd
import os
import re

os.makedirs("data/cleaned", exist_ok=True)

customers = pd.read_csv("data/raw/customers.csv")
products = pd.read_csv("data/raw/products.csv")
orders = pd.read_csv("data/raw/orders.csv")
order_items = pd.read_csv("data/raw/order_items.csv")

print("=" * 60)
print("DATA CLEANING STARTED")
print("=" * 60)

print("\nCustomers")
print(customers.info())

print("\nProducts")
print(products.info())

print("\nOrders")
print(orders.info())

print("\nOrder Items")
print(order_items.info())


print("\nMissing Values\n")

print("Customers")
print(customers.isnull().sum())

print("\nProducts")
print(products.isnull().sum())

print("\nOrders")
print(orders.isnull().sum())

print("\nOrder Items")
print(order_items.isnull().sum())


customers = customers.drop_duplicates()

products = products.drop_duplicates()

orders = orders.drop_duplicates()

order_items = order_items.drop_duplicates()

print("\nDuplicate records removed successfully.")


# -----------------------------
# Clean Orders
# -----------------------------

def clean_orders():

    global orders

    # Handle missing customer IDs
    orders["customer_id"] = orders["customer_id"].fillna(-1)

    # Convert customer_id to integer
    orders["customer_id"] = orders["customer_id"].astype(int)

    # Convert invalid dates to NaT and fill missing values with a safe default.
    orders["order_date"] = pd.to_datetime(
        orders["order_date"],
        errors="coerce"
    )
    orders["order_date"] = orders["order_date"].fillna(pd.Timestamp("1970-01-01"))

    print("\nOrders cleaned successfully.")
    print(orders.head())


# -----------------------------
# Clean Products
# -----------------------------

def clean_products():

    global products

    # Remove leading/trailing spaces
    products["product_name"] = (
        products["product_name"]
        .str.strip()
        .str.title()
    )

    # Fill missing prices
    products["price"] = products["price"].fillna(
        products["price"].median()
    )

    print("\nProducts cleaned successfully.")
    print(products.head())


# -----------------------------
# Validate Emails
# -----------------------------

def validate_emails():

    pattern = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

    invalid = customers[
        ~customers["email"].str.match(
            pattern,
            na=False
        )
    ]

    print("\nInvalid Emails Found")

    print(invalid[
        ["customer_id","email"]
    ])

    return invalid


# -----------------------------
# Referential Integrity
# -----------------------------

def check_referential_integrity():

    invalid_orders = order_items[
        ~order_items["order_id"].isin(
            orders["order_id"]
        )
    ]

    print("\nInvalid Order References")

    print(invalid_orders)

    return invalid_orders


clean_orders()

clean_products()

validate_emails()

check_referential_integrity()


customers.to_csv(
    "data/cleaned/customers_clean.csv",
    index=False
)

products.to_csv(
    "data/cleaned/products_clean.csv",
    index=False
)

orders.to_csv(
    "data/cleaned/orders_clean.csv",
    index=False
)

order_items.to_csv(
    "data/cleaned/order_items_clean.csv",
    index=False
)

print("\nCleaned datasets exported successfully.")


