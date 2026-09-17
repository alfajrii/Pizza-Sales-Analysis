-- ============================================================
-- PIZZA SALES DATA ANALYSIS
-- ============================================================


-- ============================================================
-- 1. MELIHAT SELURUH DATA
-- ============================================================

SELECT *
FROM pizza_sales;


-- ============================================================
-- 2. MELIHAT JUMLAH DATA
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM pizza_sales;


-- ============================================================
-- 3. TOTAL REVENUE
-- ============================================================

SELECT 
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales;


-- ============================================================
-- 4. TOTAL ORDERS
-- ============================================================

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;


-- ============================================================
-- 5. TOTAL PIZZA SOLD
-- ============================================================

SELECT 
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales;


-- ============================================================
-- 6. AVERAGE ORDER VALUE
-- Total Revenue / Total Orders
-- ============================================================

SELECT 
    ROUND(
        SUM(total_price) / COUNT(DISTINCT order_id), 
        2
    ) AS average_order_value
FROM pizza_sales;


-- ============================================================
-- 7. AVERAGE PIZZAS PER ORDER
-- ============================================================

SELECT 
    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS average_pizzas_per_order
FROM pizza_sales;


-- ============================================================
-- 8. SEMUA KPI DALAM SATU QUERY
-- ============================================================

SELECT
    ROUND(SUM(total_price), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_pizza_sold,
    ROUND(
        SUM(total_price) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS average_pizzas_per_order
FROM pizza_sales;


-- ============================================================
-- 9. DAILY TREND - TOTAL ORDER BERDASARKAN HARI
-- ============================================================

SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date), DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);


-- ============================================================
-- 10. HOURLY TREND - TOTAL ORDER BERDASARKAN JAM
-- ============================================================

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hour;


-- ============================================================
-- 11. MONTHLY TREND - TOTAL ORDER PER BULAN
-- ============================================================

SELECT
    MONTH(order_date) AS month_number,
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_number;


-- ============================================================
-- 12. REVENUE PER BULAN
-- ============================================================

SELECT
    MONTH(order_date) AS month_number,
    MONTHNAME(order_date) AS month_name,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_number;


-- ============================================================
-- 13. REVENUE BERDASARKAN PIZZA CATEGORY
-- ============================================================

SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- ============================================================
-- 14. PERSENTASE SALES BERDASARKAN PIZZA CATEGORY
-- ============================================================

SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- ============================================================
-- 15. REVENUE BERDASARKAN PIZZA SIZE
-- ============================================================

SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC;


-- ============================================================
-- 16. PERSENTASE SALES BERDASARKAN PIZZA SIZE
-- ============================================================

SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC;


-- ============================================================
-- 17. TOTAL PIZZA SOLD BERDASARKAN CATEGORY
-- ============================================================

SELECT
    pizza_category,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizza_sold DESC;


-- ============================================================
-- 18. TOTAL PIZZA SOLD BERDASARKAN SIZE
-- ============================================================

SELECT
    pizza_size,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_pizza_sold DESC;


-- ============================================================
-- 19. TOP 5 BEST SELLING PIZZAS
-- Berdasarkan quantity
-- ============================================================

SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;


-- ============================================================
-- 20. BOTTOM 5 PIZZAS
-- Berdasarkan quantity
-- ============================================================

SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;


-- ============================================================
-- 21. TOP 5 PIZZA BERDASARKAN REVENUE
-- ============================================================

SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;


-- ============================================================
-- 22. BOTTOM 5 PIZZA BERDASARKAN REVENUE
-- ============================================================

SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;


-- ============================================================
-- 23. TOP 5 PIZZA BERDASARKAN JUMLAH ORDER
-- ============================================================

SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;


-- ============================================================
-- 24. RATA-RATA HARGA PIZZA PER CATEGORY
-- ============================================================

SELECT
    pizza_category,
    ROUND(AVG(unit_price), 2) AS average_unit_price
FROM pizza_sales
GROUP BY pizza_category
ORDER BY average_unit_price DESC;


-- ============================================================
-- 25. REVENUE DAN QUANTITY PER CATEGORY
-- ============================================================

SELECT
    pizza_category,
    SUM(quantity) AS total_pizza_sold,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- ============================================================
-- 26. PENJUALAN BERDASARKAN CATEGORY DAN SIZE
-- ============================================================

SELECT
    pizza_category,
    pizza_size,
    SUM(quantity) AS total_pizza_sold,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category, pizza_size
ORDER BY total_revenue DESC;


-- ============================================================
-- 27. HARI DENGAN ORDER TERBANYAK
-- ============================================================

SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;


-- ============================================================
-- 28. JAM DENGAN ORDER TERBANYAK
-- ============================================================

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC;


-- ============================================================
-- 29. TANGGAL DENGAN REVENUE TERTINGGI
-- ============================================================

SELECT
    order_date,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY order_date
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 30. RINGKASAN PER PIZZA
-- ============================================================

SELECT
    pizza_name,
    pizza_category,
    SUM(quantity) AS total_pizza_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(unit_price), 2) AS average_price,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name, pizza_category
ORDER BY total_revenue DESC;