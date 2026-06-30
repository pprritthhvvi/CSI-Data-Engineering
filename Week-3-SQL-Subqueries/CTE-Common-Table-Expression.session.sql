DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

USE company;

CREATE TABLE employees( emp_id INT PRIMARY KEY, emp_name VARCHAR(50), department VARCHAR(30), city VARCHAR(30), salary INT );

INSERT INTO employees VALUES (101,'John','IT','New York',70000), (102,'Maria','HR','Berlin',50000), (103,'Peter','IT','London',80000),(104,'David','Finance','New York',65000), (105,'Sophia','HR','Berlin',55000), (106,'James','Finance','London',60000), (107,'Emma','IT','New York',90000), (108,'Alex','Sales','Mumbai',45000), (109,'Olivia','Sales','Delhi',48000), (110,'Noah','HR','Mumbai',52000);

SELECT * FROM employees;

WITH EmployeeCTE AS ( SELECT * FROM employees ) SELECT * FROM EmployeeCTE;

WITH HighSalary AS ( SELECT * FROM employees WHERE salary > 60000 ) SELECT * FROM HighSalary;

WITH ITEmployees AS ( SELECT * FROM employees WHERE department='IT' ) SELECT emp_name,salary FROM ITEmployees;

WITH DepartmentSalary AS ( SELECT department, AVG(salary) AS AvgSalary FROM employees GROUP BY department ) SELECT * FROM DepartmentSalary;

WITH DepartmentSalary AS ( SELECT department, SUM(salary) AS TotalSalary FROM employees GROUP BY department ) SELECT * FROM DepartmentSalary ORDER BY TotalSalary DESC;

WITH CityEmployees AS ( SELECT city, COUNT(*) AS TotalEmployees FROM employees GROUP BY city ) SELECT * FROM CityEmployees;

WITH AvgSalary AS ( SELECT AVG(salary) AS CompanyAverage FROM employees ) SELECT emp_name, salary FROM employees WHERE salary > ( SELECT CompanyAverage FROM AvgSalary );

WITH MaxSalary AS ( SELECT MAX(salary) AS HighestSalary FROM employees ) SELECT * FROM employees WHERE salary= ( SELECT HighestSalary FROM MaxSalary );

WITH EmployeeCount AS ( SELECT department, COUNT(*) AS TotalEmployees FROM employees GROUP BY department ) SELECT * FROM EmployeeCount WHERE TotalEmployees>=2;

WITH SalaryReport AS ( SELECT department, AVG(salary) AvgSalary, MAX(salary) MaxSalary, MIN(salary) MinSalary, SUM(salary) TotalSalary, COUNT(*) Employees FROM employees GROUP BY department ) SELECT * FROM SalaryReport;

WITH HighSalary AS ( SELECT * FROM employees WHERE salary>60000 ), ITEmployees AS ( SELECT * FROM HighSalary WHERE department='IT' ) SELECT * FROM ITEmployees;

WITH EmployeeRanks AS ( SELECT emp_name, department, salary FROM employees ) SELECT * FROM EmployeeRanks ORDER BY salary DESC;

WITH FinanceEmployees AS ( SELECT * FROM employees WHERE department='Finance' ) SELECT * FROM FinanceEmployees;

WITH SalesEmployees AS ( SELECT * FROM employees WHERE department='Sales' ) SELECT * FROM SalesEmployees;

WITH CompanyStats AS ( SELECT COUNT(*) AS Employees, AVG(salary) AS AvgSalary, SUM(salary) AS TotalSalary, MAX(salary) AS HighestSalary, MI (salary) AS LowestSalary FROM employees ) SELECT * FROM CompanyStats;