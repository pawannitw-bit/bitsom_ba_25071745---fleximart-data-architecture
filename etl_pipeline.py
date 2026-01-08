"""
ETL Pipeline for FlexiMart
Author: Pawan Kulmi
"""

import pandas as pd
import re
from datetime import datetime
from sqlalchemy import create_engine

# -----------------------------
# DATABASE CONNECTION
# -----------------------------
# Update credentials as required
engine = create_engine(
    "mysql+mysqlconnector://username:password@localhost/fleximart"
)

# -----------------------------
# UTILITY FUNCTIONS
# -----------------------------
def standardize_phone(phone):
    """Convert phone numbers to +91-XXXXXXXXXX format"""
    if pd.isna(phone):
        return None
    phone = re.sub(r"\D", "", phone)
    phone = phone[-10:]
    return f"+91-{phone}"

def standardize_date(date_val):
    """Convert mixed date formats to YYYY-MM-DD"""
    if pd.isna(date_val):
        return None
    return pd.to_datetime(date_val, errors="coerce").strftime("%Y-%m-%d")

def standardize_category(cat):
    """Normalize category names"""
    if pd.isna(cat):
        return "Others"
    return cat.strip().capitalize()

# -----------------------------
# EXTRACT
# -----------------------------
customers = pd.read_csv("customers_raw.csv")
products = pd.read_csv("products_raw.csv")
sales = pd.read_csv("sales_raw.csv")

# Record counts
cust_initial = len(customers)
prod_initial = len(products)
sales_initial = len(sales)

# -----------------------------
# TRANSFORM – CUSTOMERS
# -----------------------------
customers.drop_duplicates(inplace=True)

# Remove records with missing email (mandatory field)
customers = customers[customers["email"].notna()]

customers["phone"] = customers["phone"].apply(standardize_phone)
customers["registration_date"] = customers["registration_date"].apply(standardize_date)

cust_final = len(customers)

# -----------------------------
# TRANSFORM – PRODUCTS
# -----------------------------
products.drop_duplicates(inplace=True)

# Fill missing prices with category average
products["price"] = products.groupby("category")["price"].transform(
    lambda x: x.fillna(x.mean())
)

# Fill missing stock with 0
products["stock_quantity"].fillna(0, inplace=True)

products["category"] = products["category"].apply(standardize_category)

prod_final = len(products)

# -----------------------------
# TRANSFORM – SALES
# -----------------------------
sales.drop_duplicates(inplace=True)

# Remove records with missing customer or product IDs
sales = sales[sales["customer_id"].notna() & sales["product_id"].notna()]

sales["transaction_date"] = sales["transaction_date"].apply(standardize_date)

sales_final = len(sales)

# -----------------------------
# LOAD – CUSTOMERS
# -----------------------------
customers_to_load = customers[
    ["first_name", "last_name", "email", "phone", "city", "registration_date"]
]

customers_to_load.to_sql(
    "customers", engine, if_exists="append", index=False
)

# -----------------------------
# LOAD – PRODUCTS
# -----------------------------
products_to_load = products[
    ["product_name", "category", "price", "stock_quantity"]
]

products_to_load.to_sql(
    "products", engine, if_exists="append", index=False
)

# -----------------------------
# LOAD – ORDERS & ORDER ITEMS
# -----------------------------
orders = sales.groupby(
    ["transaction_id", "customer_id", "transaction_date", "status"]
).agg(total_amount=("unit_price", "sum")).reset_index()

orders.rename(columns={
    "transaction_date": "order_date"
}, inplace=True)

orders[["customer_id", "order_date", "total_amount", "status"]].to_sql(
    "orders", engine, if_exists="append", index=False
)

order_items = sales.copy()
order_items["subtotal"] = order_items["quantity"] * order_items["unit_price"]

order_items.rename(columns={
    "quantity": "quantity",
    "unit_price": "unit_price"
}, inplace=True)

order_items[["product_id", "quantity", "unit_price", "subtotal"]].to_sql(
    "order_items", engine, if_exists="append", index=False
)

# -----------------------------
# DATA QUALITY REPORT
# -----------------------------
with open("data_quality_report.txt", "w") as report:
    report.write("DATA QUALITY REPORT\n")
    report.write("-------------------\n")
    report.write(f"Customers processed: {cust_initial}\n")
    report.write(f"Customers loaded: {cust_final}\n")
    report.write(f"Products processed: {prod_initial}\n")
    report.write(f"Products loaded: {prod_final}\n")
    report.write(f"Sales processed: {sales_initial}\n")
    report.write(f"Sales loaded: {sales_final}\n")

print("ETL Pipeline executed successfully.")

