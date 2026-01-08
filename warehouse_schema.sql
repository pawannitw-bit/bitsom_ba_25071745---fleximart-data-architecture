-- =============================================
-- Data Warehouse Schema (Star Schema)
-- Part 3 – Analytics & Reporting
-- Database: ecommerce_dw
-- =============================================

-- Create Data Warehouse Database
CREATE DATABASE IF NOT EXISTS ecommerce_dw;
USE ecommerce_dw;

-- =============================================
-- Dimension: Date
-- =============================================
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,              -- YYYYMMDD
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(15) NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL,
    weekday VARCHAR(10) NOT NULL
);

-- =============================================
-- Dimension: Customer
-- =============================================
CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    registration_date DATE,
    UNIQUE (customer_id)
);

-- =============================================
-- Dimension: Product
-- =============================================
CREATE TABLE dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(10) NOT NULL,
    product_name VARCHAR(100),
    category VARCHAR(30),
    subcategory VARCHAR(50),
    price DECIMAL(10,2),
    warranty_months INT,
    UNIQUE (product_id)
);

-- =============================================
-- Dimension: Order Status
-- =============================================
CREATE TABLE dim_status (
    status_key INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(20) NOT NULL UNIQUE
);

-- =============================================
-- Fact Table: Sales
-- =============================================
CREATE TABLE fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id VARCHAR(10) NOT NULL,
    customer_key INT,
    product_key INT,
    date_key INT NOT NULL,
    status_key INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,

    -- Foreign Keys
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    CONSTRAINT fk_sales_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    CONSTRAINT fk_sales_status
        FOREIGN KEY (status_key)
        REFERENCES dim_status(status_key)
);

-- =============================================
-- Indexes for Performance
-- =============================================
CREATE INDEX idx_fact_sales_date ON fact_sales(date_key);
CREATE INDEX idx_fact_sales_product ON fact_sales(product_key);
CREATE INDEX idx_fact_sales_customer ON fact_sales(customer_key);
CREATE INDEX idx_fact_sales_status ON fact_sales(status_key);
