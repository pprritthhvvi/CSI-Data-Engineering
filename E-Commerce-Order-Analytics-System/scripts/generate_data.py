import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os

fake = Faker()

random.seed(42)
Faker.seed(42)

# Create output folder
os.makedirs("data/raw", exist_ok=True)

# Configuration
NUM_CUSTOMERS = 500
NUM_PRODUCTS = 500
NUM_ORDERS = 500
NUM_ORDER_ITEMS = 500

customer_types = [
    "REGULAR",
    "PREMIUM",
    "VIP"
]

categories = {
    "Electronics": ["Laptop", "Mobile", "Tablet", "Headphones"],
    "Clothing": ["Shirt", "Jeans", "Jacket", "T-Shirt"],
    "Home": ["Chair", "Table", "Fan", "Sofa"],
    "Books": ["Novel", "Dictionary", "Notebook", "Magazine"]
}

order_status = [
    "PLACED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
    "RETURNED"
]

regions = [
    "NORTH",
    "SOUTH",
    "EAST",
    "WEST"
]

print("=" * 60)
print("E-Commerce Order Analytics System")
print("=" * 60)
print("Generating datasets...")

# -----------------------------
# Generate Customers Dataset
# -----------------------------

customers = []

for i in range(1, NUM_CUSTOMERS + 1):

    email = fake.email()

    # Introduce ~2% invalid emails
    if random.random() < 0.02:
        email = "invalid_email"

    customer = {
        "customer_id": i,
        "customer_name": fake.name(),
        "email": email,
        "phone": fake.phone_number(),
        "city": fake.city(),
        "state": fake.state(),
        "region": random.choice(regions),
        "customer_type": random.choice(customer_types),
        "registration_date": fake.date_between(
            start_date="-5y",
            end_date="today"
        )
    }

    customers.append(customer)

customers_df = pd.DataFrame(customers)

customers_df.to_csv(
    "data/raw/customers.csv",
    index=False
)

print("✔ customers.csv created")
print(customers_df.head())

# -----------------------------
# Generate Products Dataset
# -----------------------------

brands = [
    "Samsung",
    "Apple",
    "Sony",
    "Dell",
    "HP",
    "Nike",
    "Adidas",
    "Puma",
    "IKEA",
    "Philips",
    "Penguin",
    "Oxford"
]

products = []

for i in range(1, NUM_PRODUCTS + 1):

    category = random.choice(list(categories.keys()))
    product_name = random.choice(categories[category])

    # Introduce ~3% extra spaces in product names
    if random.random() < 0.03:
        product_name = "  " + product_name + "  "

    price = round(random.uniform(100, 50000), 2)

    # Introduce ~2% missing prices
    if random.random() < 0.02:
        price = None

    stock = random.randint(0, 500)

    product = {
        "product_id": i,
        "product_name": product_name,
        "category": category,
        "brand": random.choice(brands),
        "price": price,
        "stock": stock
    }

    products.append(product)

products_df = pd.DataFrame(products)

products_df.to_csv(
    "data/raw/products.csv",
    index=False
)

print("✔ products.csv created")
print(products_df.head())

# -----------------------------
# Generate Orders Dataset
# -----------------------------

payment_methods = [
    "Credit Card",
    "Debit Card",
    "UPI",
    "Net Banking",
    "Cash on Delivery"
]

orders = []

for i in range(1, NUM_ORDERS + 1):

    customer_id = random.randint(1, NUM_CUSTOMERS)

    # Introduce ~2% missing customer IDs
    if random.random() < 0.02:
        customer_id = None

    order_date = fake.date_between(
        start_date="-2y",
        end_date="today"
    )

    # Introduce ~2% invalid dates
    if random.random() < 0.02:
        order_date = "2026-15-45"

    order = {
        "order_id": i,
        "customer_id": customer_id,
        "order_date": order_date,
        "order_status": random.choice(order_status),
        "payment_method": random.choice(payment_methods)
    }

    orders.append(order)

orders_df = pd.DataFrame(orders)

orders_df.to_csv(
    "data/raw/orders.csv",
    index=False
)

print("✔ orders.csv created")
print(orders_df.head())


# -----------------------------
# Generate Order Items Dataset
# -----------------------------

order_items = []

for i in range(1, NUM_ORDER_ITEMS + 1):

    quantity = random.randint(1, 10)

    # Introduce ~3% negative quantities
    if random.random() < 0.03:
        quantity = -quantity

    product_id = random.randint(1, NUM_PRODUCTS)

    # Introduce ~2% invalid product IDs
    if random.random() < 0.02:
        product_id = NUM_PRODUCTS + random.randint(100, 500)

    unit_price = round(random.uniform(100, 50000), 2)

    discount = round(random.uniform(0, 50), 2)

    order_item = {
        "order_item_id": i,
        "order_id": random.randint(1, NUM_ORDERS),
        "product_id": product_id,
        "quantity": quantity,
        "unit_price": unit_price,
        "discount": discount
    }

    order_items.append(order_item)

order_items_df = pd.DataFrame(order_items)

order_items_df.to_csv(
    "data/raw/order_items.csv",
    index=False
)

print("✔ order_items.csv created")
print(order_items_df.head())

print("\n" + "=" * 60)
print("DATASET GENERATION COMPLETED")
print("=" * 60)

print(f"Customers     : {len(customers_df)}")
print(f"Products      : {len(products_df)}")
print(f"Orders        : {len(orders_df)}")
print(f"Order Items   : {len(order_items_df)}")

print("\nAll datasets saved successfully in data/raw/")