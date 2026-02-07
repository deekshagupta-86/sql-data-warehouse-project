/*
===============================================================================
Key Metrics Analysis
===============================================================================
Objective:
    This script computes summary statistics such as totals and averages to gain
    high-level insights into the data. It also helps highlight potential trends
    and detect unusual values.

SQL Functions Applied:
    - COUNT()
    - SUM()
    - AVG()
===============================================================================
*/

-- Calculate the total sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Calculate how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Calculate the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Calculate the total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales;

-- Calculate the total number of products
SELECT COUNT(DISTINCT product_key) AS total_product FROM gold.dim_products;

-- Calculate the total number of customers
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.dim_customers;

-- Calculate the total number of customers that has been placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;



-- Produce a summary report covering core business metrics

SELECT 'Total_sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total_quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average_price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total no. of orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL 
SELECT 'Total no. of products', COUNT(product_name) FROM gold.dim_products
UNION ALL 
SELECT 'Total no. of customers', COUNT(customer_key) FROM gold.dim_customers;
