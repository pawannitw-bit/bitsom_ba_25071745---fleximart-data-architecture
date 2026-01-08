Part 3 – Data Analysis & Business Reporting
📌 Overview

Part 3 focuses on analyzing cleaned and structured data produced in Part 1 and Part 2 to generate business insights and reports.

This phase demonstrates how data engineering outputs are consumed by analytics, supporting decision-making for sales, customers, and inventory management in an e-commerce environment.

🎯 Objectives

Perform analytical queries on cleaned data

Generate business-focused metrics

Validate data consistency post-ETL

Produce summary reports for stakeholders

📂 Data Sources
Source	Description
MySQL	Customers, Products, Sales (cleaned)
MongoDB	Product catalog with specifications and reviews
📊 Key Analytics Areas
1️⃣ Sales Analysis

Total revenue

Monthly sales trends

Top-selling products

Order status distribution

2️⃣ Customer Analysis

Active customers

Repeat customers

City-wise customer distribution

Registration trends

3️⃣ Product & Inventory Analysis

Product-wise sales volume

Low-stock products

Category-wise revenue

High-rated products (from MongoDB reviews)

🧮 Sample Analytical Queries
Total Revenue (MySQL)
SELECT 
    SUM(quantity * unit_price) AS total_revenue
FROM sales
WHERE status = 'Completed';

Monthly Sales Trend
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(quantity * unit_price) AS monthly_revenue
FROM sales
WHERE status = 'Completed'
GROUP BY month
ORDER BY month;

📈 MongoDB Analytics
Average Rating per Product
db.products_catalog.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$product_id",
      avg_rating: { $avg: "$reviews.rating" }
    }
  }
])

Top Reviewed Products
db.products_catalog.find(
  {},
  { name: 1, reviews: { $size: "$reviews" } }
)

📄 Reports Generated
Report	Description
Sales Summary	Revenue and order statistics
Customer Insights	Customer activity and location
Product Performance	Sales vs ratings
Inventory Status	Low-stock alerts
🔍 Data Validation Checks

Orphan sales records reviewed

Revenue calculations validated

Cross-system consistency checks

Review-to-product mapping verified

🛠️ Tools Used

MySQL

MongoDB

SQL

MongoDB Aggregation Framework

Python (optional for reporting)

📌 Business Impact

Identifies high-performing products

Highlights underperforming inventory

Supports pricing and stocking decisions

Enables customer behavior analysis

🔮 Future Enhancements

Create dashboards using Power BI / Tableau

Automate reporting with scheduled jobs

Add predictive sales forecasting

Integrate real-time analytics

👤 Author

Pawan Kulmi
