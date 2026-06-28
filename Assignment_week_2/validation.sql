use superstore_db;
--1
select count(*) as total_rows from superstore;

--2
select count(*) as total_customers from customers;

--3
select count(*) as total_products from products;

--4
select count(*) as total_orders from orders;

--5
select count(*) as total_order_items from order_items;

--6
select count(*) as null_customername
from superstore
where customername is null;

--7
select count(*) as null_productname
from superstore
where productname is null;

--8
select count(*) as duplicate_orders
from (
    select orderid
    from superstore
    group by orderid
    having count(*) > 1
) as duplicates;