-- =====================================================
-- ADVANCED SQL QUERIES
-- =====================================================

-- Row number by revenue
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS row_num
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- Rank customers by revenue
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS customer_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- Dense rank customers by revenue
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    DENSE_RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS dense_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- Running total revenue by month
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue,
    SUM(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;

-- Moving average revenue by month
SELECT
    order_month,
    monthly_revenue,
    AVG(monthly_revenue) OVER (ORDER BY order_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
        SUM(oi.quantity * oi.unit_price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY order_month
) AS monthly_summary
ORDER BY order_month;

-- CTE example: orders with customer names
WITH customer_orders AS (
    SELECT o.order_id, c.customer_name, o.order_date
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
)
SELECT *
FROM customer_orders
ORDER BY order_date DESC
LIMIT 20;

-- Nested subquery: orders above average order value
SELECT *
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS order_summary
WHERE order_value > (
    SELECT AVG(order_value)
    FROM (
        SELECT
            SUM(oi.quantity * oi.unit_price) AS order_value
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY o.order_id
    ) AS avg_summary
);