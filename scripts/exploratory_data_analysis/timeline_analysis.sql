/*
===============================================================================
Timeline Analysis
===============================================================================
Objective:
    This script evaluates date fields to identify earliest and latest records,
    helping define the overall time span of the dataset.

    It also evaluates the oldest and youngest customer.

SQL Functions Applied:
    - MIN()
    - MAX()
    - DATEDIFF()
===============================================================================
*/

-- Find the date of the first and last order and how many years of the sales are available

SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales;

-- Find the total duration of sale in months
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_month
FROM gold.fact_sales;

--  Find the youngest and the oldest customer

SELECT 
MIN(birthdate) AS oldest_customer,
DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_customer,
DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;
