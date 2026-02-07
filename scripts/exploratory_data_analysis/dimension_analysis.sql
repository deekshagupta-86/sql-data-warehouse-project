/*
===============================================================================
Dimensions Analysis
===============================================================================
Objective:
    This script is intended to examine the structure and contents of dimension
    tables to better understand available attributes and value distributions.

SQL Operations Applied:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- A list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- A list of unique categories, subcategories, maintenance and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name,
    maintenance
FROM gold.dim_products
ORDER BY category, subcategory, product_name, maintenance;
