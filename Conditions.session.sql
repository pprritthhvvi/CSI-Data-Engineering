-- Where operators

--(1) comparison operators -- =, <>, =!, >, >=, <, <=
--(2) logical operators -- AND, OR, NOT
--(3) range operators -- BETWEEN
--(4) membership operator -- IN, NOT IN
--(5) search operator -- LIKE

-- 1 compare two things, condition -> expression, operator, expression

create database company2;

use company2;

create table customers (
    id int primary key,
    firstname varchar(50),
    country varchar(50),
    score int
);

insert into customers (id, firstname, country, score)
values
(1, 'Maria', 'Germany', 350),
(2, 'John', 'USA', 900),
(3, 'Georg', 'UK', 750),
(4, 'Martin', 'Germany', 500),
(5, 'Peter', 'USA', 0);

-- Retrieve all customer data

select * from customers where country = 'Germany'

select * from customers where country != 'Germany'

select * from customers where country <> 'Germany'

select * from customers where country > 'Germany'

select * from customers where country >= 'Germany'

select * from customers where country < 'Germany'

select * from customers where country <= 'Germany'


-- Retrieve all customers who are from USA and have a score greater than 500.

SELECT * FROM customers WHERE country = 'USA' AND score > 500

-- (2)
-- and -- all condition must be true
-- or -- at least one condition must be true
--  at least one condition must be true
-- not -- (reverse) excludes matching values
-- between -- check if a value is with a range
-- in -- check if a value exists in a list
-- like -- search for a pattern in text

/* Retrieve all customers who are either from USA
or have a score greater than 500. */
SELECT * FROM customers WHERE country = 'USA' OR score > 500

-- retrieve all customerds with a score not less than 500
select * from customers where not score < 500

/* Retrieve all customers whose score falls
in the range between 100 and 500 */
SELECT * FROM customers WHERE score BETWEEN 100 AND 500

/* Retrieve all customers from
either Germany or USA. */
select * FROM customers WHERE country = 'Germany' OR country = 'USA'

select * from customer where country in ('Germany', 'USA')

-- Retrieve all customers from either Germany or USA.

SELECT * 
FROM customers 
WHERE country = 'Germany'
    OR country = 'USA'
    OR country = 'France'
    OR country = 'Canada';

SELECT * FROM customers WHERE country IN ('Germany', 'USA')

-- Find all customers whose first name ends with 'r'
SELECT * FROM customers WHERE firstname LIKE '%r%'












