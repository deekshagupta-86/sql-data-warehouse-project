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
