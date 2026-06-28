-- Superstore dataset is a single table. To demonstrate SQL joins, we'll create a few small normalized tables from the existing data. This is to shows you understand joins.

These are proper joins using your normalized tables.
They demonstrate: INNER JOIN, LEFT JOIN, Multiple-table JOIN, Aggregation with JOIN
This is much stronger than a self-join and matches what your assignment expects.


create table customers as select distinct customerid, customername, segment, country, city, state, postalcode, region from superstore;

create table products as select distinct productid, productname, category, subcategfrom superstore;  

create table orders as select distinct orderid, orderdate, shipdate, shipmode, customerid from superstore;

create table order_items as select rowid, orderid, productid, sales, quantity, discount, profit from superstore;

--1
select o.orderid, c.customername, o.orderdate, o.shipmode from orders o inner join customers c on o.customerid = c.customerid limit 10;

--2
select oi.orderid, p.productname, oi.quantity, oi.sales from order_items oi inner join products p on oi.productid = p.productid limit 10;

--3
select c.customername, p.productname, oi.sales from order_items oi inner join orders o on oi.orderid = o.orderid inner join customers c on o.customerid = c.customerid inner join products p on oi.productid = p.productid limit 10;

--4
select c.customername, o.orderid from customers c left join orders o on c.customerid = o.customerid limit 10;

--5
select p.category, sum(oi.sales) as total_sales from order_items oi inner join products p on oi.productid = p.productid group by p.category;