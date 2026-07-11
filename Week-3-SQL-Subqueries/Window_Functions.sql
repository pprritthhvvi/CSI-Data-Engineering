-- Contains:
-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()
-- PARTITION BY
-- ORDER BY
-- Running Total
-- Window AVG

DROP DATABASE IF EXISTS sql_window;

CREATE DATABASE sql_window;

USE sql_window;

CREATE TABLE employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(30),
city VARCHAR(30),
salary INT
);

INSERT INTO employees VALUES
(101,'John','IT','New York',70000),
(102,'Maria','HR','Berlin',50000),
(103,'Peter','IT','London',80000),
(104,'David','Finance','New York',65000),
(105,'Sophia','HR','Berlin',55000),
(106,'James','Finance','London',60000),
(107,'Emma','IT','New York',90000),
(108,'Alex','Sales','Mumbai',45000),
(109,'Olivia','Sales','Delhi',48000),
(110,'Noah','HR','Mumbai',52000);

SELECT * FROM employees;

SELECT *,
ROW_NUMBER() OVER(ORDER BY salary DESC) Row_Num
FROM employees;

SELECT *,
RANK() OVER(ORDER BY salary DESC) Rank_No
FROM employees;

SELECT *,
DENSE_RANK() OVER(ORDER BY salary DESC) Dense_Rank_No
FROM employees;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) Dept_Row_Number
FROM employees;

SELECT *,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) Dept_Rank
FROM employees;

SELECT *,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) Dept_Dense_Rank
FROM employees;

SELECT *,
SUM(salary) OVER(ORDER BY emp_id) Running_Total
FROM employees;

SELECT *,
AVG(salary) OVER(PARTITION BY department) Avg_Department_Salary
FROM employees;