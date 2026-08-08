-- =====================================================
-- BASIC SQL QUERIES
-- =====================================================

-- Q1. View all customers
SELECT * FROM customers LIMIT 20;

-- Q2. View all products
SELECT * FROM products LIMIT 20;

-- Q3. View delivered orders
SELECT *
FROM orders
WHERE order_status = 'DELIVERED'
ORDER BY order_date DESC;

-- Q4. Products with price greater than 1000
SELECT *
FROM products
WHERE price > 1000
ORDER BY price DESC;

-- Q5. Top 10 expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 10;

-- Q6. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q7. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q8. Total revenue
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;

-- Q9. Average product price
SELECT AVG(price) AS average_product_price
FROM products;

-- Q10. Revenue by order status
SELECT
a.order_status,
SUM(b.quantity * b.unit_price) AS revenue
FROM orders a
JOIN order_items b ON a.order_id = b.order_id
GROUP BY a.order_status
ORDER BY revenue DESC;