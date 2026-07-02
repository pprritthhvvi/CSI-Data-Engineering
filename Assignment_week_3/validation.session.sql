use superstore_analytics;

select count(*) as total_rows from superstore_raw;

select count(*) as total_customers from customers;

select count(*) as total_products from products;

select count(*) as total_orders from orders;

select count(*) as total_order_items from order_items;

select count(*) as duplicate_orders
from
(
    select orderid
    from superstore_raw
    group by orderid
    having count(*) > 1
) as duplicates;

select count(*) as null_customer_name
from superstore_raw
where customername is null;

select count(*) as null_product_name
from superstore_raw
where productname is null;

select count(*) as null_sales
from superstore_raw
where sales is null;

select
    min(sales) as minimum_sales,
    max(sales) as maximum_sales,
    avg(sales) as average_sales
from superstore_raw;