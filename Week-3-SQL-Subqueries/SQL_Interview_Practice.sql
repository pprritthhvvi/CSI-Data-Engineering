-- Contains:
-- CASE
-- GROUP BY
-- HAVING
-- COUNT
-- SUM
-- AVG
-- MIN
-- MAX
-- Interview Questions

DROP DATABASE IF EXISTS sql_interview;

CREATE DATABASE sql_interview;

USE sql_interview;

CREATE TABLE employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(30),
salary INT
);

INSERT INTO employees VALUES
(1,'John','IT',70000),
(2,'Maria','HR',50000),
(3,'Peter','IT',80000),
(4,'Emma','Finance',90000),
(5,'David','HR',45000),
(6,'Alex','Sales',55000),
(7,'Sophia','Sales',65000),
(8,'James','Finance',75000);

SELECT * FROM employees;

SELECT department,
COUNT(*) Employees
FROM employees
GROUP BY department;

SELECT department,
SUM(salary) TotalSalary
FROM employees
GROUP BY department;

SELECT department,
AVG(salary) AvgSalary
FROM employees
GROUP BY department;

SELECT department,
MIN(salary) MinSalary
FROM employees
GROUP BY department;

SELECT department,
MAX(salary) MaxSalary
FROM employees
GROUP BY department;

SELECT department,
AVG(salary) AvgSalary
FROM employees
GROUP BY department
HAVING AVG(salary)>60000;

SELECT *,
CASE
WHEN salary>=80000 THEN 'High'
WHEN salary>=60000 THEN 'Medium'
ELSE 'Low'
END Salary_Level
FROM employees;

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

SELECT *
FROM employees
WHERE salary=
(
SELECT MAX(salary)
FROM employees
);

SELECT *
FROM employees
WHERE salary>
(
SELECT AVG(salary)
FROM employees
);