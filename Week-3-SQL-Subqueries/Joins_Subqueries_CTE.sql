-- Contains:
-- INNER JOIN
-- LEFT JOIN
-- RIGHT JOIN
-- FULL JOIN
-- Subqueries
-- Correlated Subquery
-- CTE

DROP DATABASE IF EXISTS sql_join;

CREATE DATABASE sql_join;

USE sql_join;

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(40),
city VARCHAR(30)
);

INSERT INTO customers VALUES
(1,'John','New York'),
(2,'Maria','Berlin'),
(3,'Peter','London'),
(4,'Emma','Mumbai'),
(5,'David','Delhi');

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
product VARCHAR(40),
amount INT
);

INSERT INTO orders VALUES
(101,1,'Laptop',70000),
(102,2,'Phone',30000),
(103,3,'Keyboard',5000),
(104,1,'Mouse',1000),
(105,4,'Monitor',15000);

SELECT * FROM customers;

SELECT * FROM orders;

SELECT *
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id

UNION

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *
FROM orders
WHERE amount>
(
SELECT AVG(amount)
FROM orders
);

SELECT *
FROM customers c
WHERE EXISTS
(
SELECT *
FROM orders o
WHERE c.customer_id=o.customer_id
);

SELECT *
FROM
(
SELECT customer_id,
SUM(amount) TotalSales
FROM orders
GROUP BY customer_id
) Sales;

WITH Sales AS
(
SELECT customer_id,
SUM(amount) TotalSales
FROM orders
GROUP BY customer_id
)
SELECT *
FROM Sales;