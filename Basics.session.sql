create database company;

use company;

create table customers (
    id int primary key,
    FirstName varchar(50),
    Country varchar(50),
    Score int
);

insert into customers (id, FirstName, Country, Score)
values
(1, 'Maria', 'Germany', 350),
(2, 'John', 'USA', 900),
(3, 'Georg', 'UK', 750),
(4, 'Martin', 'Germany', 500),
(5, 'Peter', 'USA', 0);

-- Retrieve all customer data

select * from customers

create table orders (
    orderid int primary key,
    customerid int,
    orderdate date,
    sales int
);

insert into orders (orderid, customerid, orderdate, sales)
values
(1001, 1, '2021-01-11', 35),
(1002, 2, '2021-04-05', 15),
(1003, 3, '2021-06-18', 20),
(1004, 6, '2021-08-31', 10);

select * from orders;

-- Retrieve each customer's name, country and score
select
    FirstName,
    Country,
    score
from customers

-- Where 
-- Filters Your Data based on a Condition Score Higher than 500
select * from customers where Score < 500;

-- retrieve customers with a score not equle to 0
select * from customers where Score != 0;

-- Retrieve customer from germany COMMENT
select * from customers where Country = 'Germany';
select FirstName, Country from customers where Country = 'Germany';

-- order by
-- sort your data
-- default acsending 
-- retrieve all customers and sort the result by the highest score first
select * from customers order by Score;
select * from customers order by Score asc;
select * from customers order by Score desc;

-- nested -- order by
-- Retrieve all customers and sort the results by the country and then by the highest score
select * from customers order by Score desc, Country asc;
select * from customers order by Country asc, Score desc;

-- group by 
-- its betwwen where and order by 
-- aggregate your data 
-- Combines rows with the Same Value Aggregates a Column By another  Column

-- findi the total score for each country
select Country, sum(Score) from customers group by Country
select Country, sum(Score) as TotalScore from customers group by Country

-- find the total score and total number of customers for each country
select Country, sum(Score) as total_score, count(id) as total_customers from customers group by Country

-- having -- filter data after aggregation can be used only with group by

/* Find the average score for each country
considering only customers with a score not equal to 0
and return only those countries with an average score greater than 430*/

select Country,avg(Score) as avg_score from customers where Score != 0 group by Country having avg(Score) > 430

-- Distinct -- removes Duplicettes (Repeated Values) -- Cach Value appears Only Once

select distinct Country From customers

-- top (limit) -- restrict the number of rows returned 

SELECT *
FROM customers
ORDER BY Score ASC
LIMIT 2;

-- execution order vs coding order