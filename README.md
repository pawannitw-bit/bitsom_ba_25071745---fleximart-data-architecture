Part 1 – ETL Pipeline & Data Quality (MySQL)
Overview

Part 1 of this project focuses on building a robust ETL (Extract, Transform, Load) pipeline for an e-commerce system using raw CSV datasets.
The goal is to identify data quality issues, clean and standardize the data, and load it into a relational database (MySQL).

This part simulates real-world production data challenges such as missing values, duplicates, and inconsistent formats.

 Input Datasets
Dataset	Description
customers_raw.csv	Customer master data
products_raw.csv	Product master data
sales_raw.csv	Transactional sales data

🧹 Data Quality Challenges
Customers Data

Missing email addresses

Duplicate customer records

Inconsistent phone number formats

Mixed date formats

Inconsistent city casing

Products Data

Missing prices

Missing stock quantities

Inconsistent category values

Extra spaces in product names

Sales Data

Duplicate transactions

Missing customer IDs

Missing product IDs

Multiple date formats

 Data Quality Checks

Before loading, the following checks are performed:

Duplicate record detection

Missing value identification

Date format validation and normalization

Category standardization

Phone number normalization

Referential integrity validation for sales data

📄 Detailed findings are documented in:
reports/data_quality_report.txt

🔄 ETL Pipeline Flow
1️⃣ Extract

Read raw CSV files using Python

Load data into pandas DataFrames

2️⃣ Transform

Remove duplicate records

Standardize date formats to YYYY-MM-DD

Normalize phone numbers

Clean and trim text fields

Normalize category values

Handle missing and null values

Validate foreign key relationships

3️⃣ Load

Load cleaned data into MySQL

Store customers, products, and sales in relational tables

🗄️ Database Design

Database: ecommerce_db

Tables

customers

products

sales

Refer to:
📘 schema_documentation.md for full schema details.

🛠️ Technologies Used

Python (pandas)

MySQL

SQL

Git

▶️ How to Run Part 1

Clone the repository

git clone <repo-url>
cd part1-etl-mysql


Create database and tables

source sql/create_tables.sql;


Run ETL pipeline

python etl/etl_pipeline.py


Verify loaded data

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM sales;

📈 Outcomes

Raw data transformed into clean, analytics-ready tables

Improved data consistency and integrity

Clear documentation of data quality issues

Production-style ETL workflow

🔮 Future Improvements

Add automated data validation checks

Introduce incremental loads

Implement Airflow for scheduling

Add indexes for performance optimization

👤 Author

Pawan Kulmi
