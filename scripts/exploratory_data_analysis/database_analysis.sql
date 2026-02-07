/*
===============================================================================
Database Structure Review
===============================================================================
Objective:
    This script is used to analyze the database layout by identifying available
    tables along with their associated schemas. It also retrieves column-level
    details to better understand table definitions and metadata.

System Views Referenced:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- List of all tables present across database
SELECT *
FROM INFORMATION_SCHEMA.TABLES;

-- List of all columns for a specific table (dim_customers)
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

-- Analysing the dimensions of different tables
SELECT 
DISTINCT country 
FROM gold.dim_customer;
SELECT
DISTINCT country 
FROM gold.dim_customer;
SELECT
DISTINCT category, subcategory , product_name 
FROM gold.dim_products
ORDER BY 1,2,3;
