-- =====================================================
-- COHORT ANALYSIS QUERIES
-- =====================================================

-- Customer cohorts by first purchase month
WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
)
SELECT
    cohort_month,
    COUNT(*) AS customer_count
FROM first_purchase
GROUP BY cohort_month
ORDER BY cohort_month;

-- Monthly retention by cohort
WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
), activity AS (
    SELECT
        fp.customer_id,
        fp.cohort_month,
        DATE_FORMAT(o.order_date, '%Y-%m') AS order_month
    FROM first_purchase fp
    JOIN orders o ON fp.customer_id = o.customer_id
)
SELECT
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM activity
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;

-- Repeat customers
SELECT
    customer_id,
    COUNT(*) AS purchase_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY purchase_count DESC;

-- Customers with no orders
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Customer lifetime value (CLV)
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;

-- RFM-style segmentation
WITH customer_summary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS purchase_frequency,
        SUM(oi.quantity * oi.unit_price) AS total_spend
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    purchase_frequency,
    total_spend,
    CASE
        WHEN total_spend >= 50000 THEN 'VIP'
        WHEN total_spend >= 10000 THEN 'High Value'
        WHEN total_spend >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS spend_tier
FROM customer_summary
ORDER BY total_spend DESC;