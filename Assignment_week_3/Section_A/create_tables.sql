show databases;

create database superstore_analytics;

use superstore_analytics;

select database();

show tables;

describe superstore_raw;


create table superstore_raw (
    rowid int,
    orderid varchar(20),
    orderdate varchar(20),
    shipdate varchar(20),
    shipmode varchar(50),
    customerid varchar(20),
    customername varchar(100),
    segment varchar(50),
    country varchar(50),
    city varchar(100),
    state varchar(100),
    postalcode int,
    region varchar(50),
    productid varchar(30),
    category varchar(50),
    subcategory varchar(50),
    productname varchar(255),
    sales decimal(10,2),
    quantity int,
    discount decimal(5,2),
    profit decimal(10,2)
);


select count(*) from superstore_raw;

select * from superstore_raw limit 10;



create table customers as
select distinct
    customerid,
    customername,
    segment,
    country,
    city,
    state,
    postalcode,
    region
from superstore_raw;

create table products as
select distinct
    productid,
    productname,
    category,
    subcategory
from superstore_raw;

create table orders as
select distinct
    orderid,
    orderdate,
    shipdate,
    shipmode,
    customerid
from superstore_raw;

create table order_items as
select
    rowid,
    orderid,
    productid,
    sales,
    quantity,
    discount,
    profit
from superstore_raw;


select count(*) from customers;

select count(*) from products;

select count(*) from orders;

select count(*) from order_items;


show tables;


-- This section covers:
-- Scalar Subqueries
-- Correlated Subqueries
-- IN Subqueries
-- Aggregate Subqueries
-- Nested Subqueries