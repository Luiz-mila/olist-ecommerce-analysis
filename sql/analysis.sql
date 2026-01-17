-- ================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- Author: Luiz Milaré
-- Date: January 2026
-- ================================================

-- ================================================
-- ANALYSIS 1: Revenue by Product Category
-- Purpose: Identify most profitable categories
-- ================================================

SELECT 
    p.product_category_name AS category,
    COUNT(oi.order_id) AS total_sales,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ================================================
-- ANALYSIS 2: Top 10 Sellers by Performance
-- Purpose: Rank sellers by total revenue
-- ================================================

SELECT 
    oi.seller_id AS seller,
    COUNT(oi.order_id) AS total_sales,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ================================================
-- ANALYSIS 3: Monthly Sales Evolution
-- Purpose: Identify trends and seasonality
-- ================================================

SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;


-- ================================================
-- ANALYSIS 4: Revenue by Price Range
-- Purpose: Pricing strategy insights
-- ================================================

SELECT 
    CASE 
        WHEN oi.price < 50 THEN 'Low (0-50)'
        WHEN oi.price BETWEEN 50 AND 200 THEN 'Mid (50-200)'
        WHEN oi.price BETWEEN 200 AND 500 THEN 'High (200-500)'
        ELSE 'Premium (500+)'
    END AS price_range,
    COUNT(oi.order_id) AS total_sales,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_price
FROM order_items oi
GROUP BY price_range
ORDER BY total_revenue DESC;