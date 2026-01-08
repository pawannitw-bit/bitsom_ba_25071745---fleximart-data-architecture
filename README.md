FlexiMart Data Architecture Project
Student Name: Pawan Kulmi  
Student ID: bitsom_ba_25071745  
Email: pawannitw@gmail.com
Date: 05-Jan-2026
## Project Overview
This project demonstrates the end-to-end data architecture design for FlexiMart, covering transactional ETL processing, NoSQL-based product catalog analysis, and a dimensional data warehouse for analytical reporting. The solution includes data cleaning, schema design, MongoDB operations, star schema modeling, and OLAP analytics to support business decision-making.

## Repository Structure
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md

## Technologies Used
- **Python 3.x**, pandas, mysql-connector-python  
- **MySQL 8.0 / PostgreSQL 14**  
- **MongoDB 6.0**

Setup Instructions
(As provided in the assignment)

# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse Schema and Data
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

mongosh < part2-nosql/mongodb_operations.js

Key Learnings
⦁	End-to-End Data Architecture Understanding
⦁	Handling Data Variety and Quality
⦁	Analytical Thinking with Dimensional Modeling
Challenges Faced
1.	Data Quality and Inconsistency
2.	Schema Design Across Multiple Data Models
3.	Writing Efficient Analytical Queries
