USE ecommerce_dw;

-- =====================================================
-- 1. TOTAL REVENUE
-- =====================================================
SELECT 
    SUM(total_amount) AS total_revenue
FROM fact_sales;

-- =====================================================
-- 2. MONTHLY REVENUE TREND
-- =====================================================
SELECT 
    d.year,
    d.month_name,
    SUM(f.total_amount) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- =====================================================
-- 3. TOP 5 SELLING PRODUCTS (BY REVENUE)
-- =====================================================
SELECT 
    p.product_name,
    SUM(f.quantity) AS total_units_sold,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- =====================================================
-- 4. CATEGORY-WISE REVENUE
-- =====================================================
SELECT 
    p.category,
    SUM(f.total_amount) AS category_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY category_revenue DESC;

-- =====================================================
-- 5. CUSTOMER-WISE SPENDING
-- =====================================================
SELECT 
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(f.total_amount) AS total_spent
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC;

-- =====================================================
-- 6. TOP 5 CUSTOMERS BY REVENUE
-- =====================================================
SELECT 
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 5;

-- =====================================================
-- 7. CITY-WISE REVENUE DISTRIBUTION
-- =====================================================
SELECT 
    c.city,
    SUM(f.total_amount) AS city_revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.city
ORDER BY city_revenue DESC;

-- =====================================================
-- 8. WEEKDAY VS WEEKEND SALES
-- =====================================================
SELECT 
    CASE 
        WHEN d.weekday IN ('Saturday','Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY day_type;

-- =====================================================
-- 9. AVERAGE ORDER VALUE (AOV)
-- =====================================================
SELECT 
    ROUND(SUM(total_amount) / COUNT(DISTINCT transaction_id), 2) 
    AS avg_order_value
FROM fact_sales;

-- =====================================================
-- 10. PRODUCT PERFORMANCE (UNITS + REVENUE)
-- =====================================================
SELECT 
    p.product_name,
    SUM(f.quantity) AS units_sold,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY units_sold DESC;

-- =====================================================
-- 11. LOW REVENUE PRODUCTS (FOR DISCOUNT STRATEGY)
-- =====================================================
SELECT 
    p.product_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
HAVING revenue < 10000
ORDER BY revenue;

-- =====================================================
-- 12. SALES STATUS DISTRIBUTION
-- =====================================================
SELECT 
    s.status,
    COUNT(*) AS total_orders
FROM fact_sales f
JOIN dim_status s ON f.status_key = s.status_key
GROUP BY s.status;

-- =====================================================
-- 13. MONTH-OVER-MONTH GROWTH
-- =====================================================
SELECT 
    d.month_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.month, d.month_name
ORDER BY d.month;

-- =====================================================
-- 14. TOP CATEGORY PER MONTH
-- =====================================================
SELECT 
    d.month_name,
    p.category,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.month_name, p.category
ORDER BY d.month_name, revenue DESC;

-- =====================================================
-- 15. EXECUTIVE SUMMARY (ONE VIEW)
-- =====================================================
SELECT
    (SELECT SUM(total_amount) FROM fact_sales) AS total_revenue,
    (SELECT COUNT(DISTINCT transaction_id) FROM fact_sales) AS total_orders,
    (SELECT COUNT(DISTINCT customer_key) FROM fact_sales) AS active_customers,
    (SELECT SUM(quantity) FROM fact_sales) AS total_units_sold;
