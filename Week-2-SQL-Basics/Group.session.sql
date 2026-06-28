DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

USE company;

CREATE TABLE employees (
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

SELECT COUNT(*) AS TotalEmployees
FROM employees;

SELECT COUNT(*) AS ITEmployees
FROM employees
WHERE department='IT';

SELECT SUM(salary) AS TotalSalary
FROM employees;

SELECT SUM(salary) AS TotalITSalary
FROM employees
WHERE department='IT';

SELECT AVG(salary) AS AverageSalary
FROM employees;

SELECT AVG(salary) AS HRAverageSalary
FROM employees
WHERE department='HR';

SELECT MIN(salary) AS LowestSalary
FROM employees;

SELECT MAX(salary) AS HighestSalary
FROM employees;

SELECT department, COUNT(*) AS Employees
FROM employees
GROUP BY department;

SELECT department, SUM(salary) AS TotalSalary
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS AverageSalary
FROM employees
GROUP BY department;

SELECT department, MIN(salary) AS LowestSalary
FROM employees
GROUP BY department;

SELECT department, MAX(salary) AS HighestSalary
FROM employees
GROUP BY department;

SELECT city, COUNT(*) AS Employees
FROM employees
GROUP BY city;

SELECT city, SUM(salary) AS TotalSalary
FROM employees
GROUP BY city;

SELECT city, AVG(salary) AS AverageSalary
FROM employees
GROUP BY city;

SELECT city, MIN(salary) AS LowestSalary
FROM employees
GROUP BY city;

SELECT city, MAX(salary) AS HighestSalary
FROM employees
GROUP BY city;

SELECT department, AVG(salary) AS AvgSalary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

SELECT city, COUNT(*) AS Employees
FROM employees
GROUP BY city
HAVING COUNT(*) >= 2;

SELECT department, SUM(salary) AS TotalSalary
FROM employees
GROUP BY department
ORDER BY TotalSalary DESC;

SELECT city, AVG(salary) AS AvgSalary
FROM employees
GROUP BY city
ORDER BY AvgSalary DESC;