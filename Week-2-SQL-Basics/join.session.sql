DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

USE company;

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
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
    product VARCHAR(50),
    amount INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(101,1,'Laptop',70000),
(102,2,'Phone',30000),
(103,3,'Keyboard',5000),
(104,1,'Mouse',1000),
(105,4,'Monitor',15000);

SELECT * FROM customers;

SELECT * FROM orders;

SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.product,
o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id;

SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.product,
o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.product,
o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.product,
o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id

UNION

SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.product,
o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT
c.customer_name,
COUNT(o.order_id) AS TotalOrders
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

SELECT
c.customer_name,
SUM(o.amount) AS TotalAmount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

SELECT
c.customer_name,
AVG(o.amount) AS AverageAmount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

SELECT
c.customer_name,
MIN(o.amount) AS MinimumAmount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

SELECT
c.customer_name,
MAX(o.amount) AS MaximumAmount
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

SELECT
c.customer_name,
SUM(o.amount) AS TotalSales
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name
ORDER BY TotalSales DESC;

SELECT
c.customer_name,
COUNT(o.order_id) AS Orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id)>=1;