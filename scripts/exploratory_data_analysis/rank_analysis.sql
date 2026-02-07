/*
===============================================================================
Performance Ranking Analysis
===============================================================================
Objective:
    This script ranked entities such as products or customers according to
    selected performance measures, helping highlight high achievers as well
    as underperforming records.

SQL Techniques Applied:
    - Ranking functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - GROUP BY
    - ORDER BY

===============================================================================
*/

-- Find the top 5 products generate the highest revenue
SELECT TOP 5
pr.product_name,
SUM(ft.sales_amount) As total_revenue
FROM gold.fact_sales ft
LEFT JOIN  gold.dim_products pr
ON pr.product_key = ft.product_key
GROUP BY pr.product_name
ORDER BY total_revenue DESC;

-- Using window function
SELECT * FROM(
	SELECT
	p.product_name,
	SUM(f.sales_amount) As total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN  gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5;

-- Find the 5 worst-performing products in terms of sales
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) As total_revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC

-- Find the top categories generate the highest revenue
SELECT TOP 5
pr.category,
SUM(ft.sales_amount) As total_revenue
FROM gold.fact_sales ft
LEFT JOIN  gold.dim_products pr
ON pr.product_key = ft.product_key
GROUP BY pr.category
ORDER BY total_revenue DESC


-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) As total_revenue
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

-- find the 10 customers with the fewest orders placed
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) As total_orders
FROM gold.fact_sales f
LEFT JOIN  gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders;
