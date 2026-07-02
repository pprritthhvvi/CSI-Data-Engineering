with customer_sales as (
    select
        customerid,
        customername,
        sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customerid, customername
)
select
    customerid,
    customername,
    total_sales,
    dense_rank() over(order by total_sales desc) as sales_rank
from customer_sales
order by sales_rank;


with customer_sales as (
    select
        customerid,
        customername,
        sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customerid, customername
)
select *
from customer_sales
order by total_sales desc
limit 10;


with customer_sales as (
    select
        customerid,
        customername,
        sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customerid, customername
)
select *
from customer_sales
order by total_sales
limit 10;


with customer_orders as (
    select
        customerid,
        customername,
        count(distinct orderid) as total_orders
    from superstore_analytics.superstore_raw
    group by customerid, customername
)
select *
from customer_orders
where total_orders = 1;



with customer_sales as (
    select
        customerid,
        customername,
        sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customerid, customername
)
select *
from customer_sales
where total_sales >
(
    select avg(total_sales)
    from customer_sales
);



select
    c.customername,
    c.region,
    sum(oi.sales) as total_sales
from superstore_analytics.customers c
join superstore_analytics.orders o
on c.customerid = o.customerid
join superstore_analytics.order_items oi
on o.orderid = oi.orderid
group by c.customername, c.region
order by total_sales desc;



select
    p.productname,
    sum(oi.sales) as total_sales
from superstore_analytics.products p
join superstore_analytics.order_items oi
on p.productid = oi.productid
group by p.productname
order by total_sales desc
limit 10;



select
    c.customername,
    count(distinct o.orderid) as total_orders,
    round(sum(oi.sales),2) as total_sales,
    round(avg(oi.sales),2) as average_sales
from superstore_analytics.customers c
join superstore_analytics.orders o
on c.customerid = o.customerid
join superstore_analytics.order_items oi
on o.orderid = oi.orderid
group by c.customername
order by total_sales desc;



with region_sales as (
    select
        c.region,
        c.customername,
        sum(oi.sales) as total_sales
    from superstore_analytics.customers c
    join superstore_analytics.orders o
    on c.customerid = o.customerid
    join superstore_analytics.order_items oi
    on o.orderid = oi.orderid
    group by c.region, c.customername
)
select
    region,
    customername,
    total_sales,
    rank() over(partition by region order by total_sales desc) as region_rank
from region_sales;



with customer_summary as (
    select
        c.customerid,
        c.customername,
        c.region,
        count(distinct o.orderid) as total_orders,
        round(sum(oi.sales),2) as total_sales,
        round(sum(oi.profit),2) as total_profit
    from superstore_analytics.customers c
    join superstore_analytics.orders o
    on c.customerid = o.customerid
    join superstore_analytics.order_items oi
    on o.orderid = oi.orderid
    group by c.customerid, c.customername, c.region
)
select
    customerid,
    customername,
    region,
    total_orders,
    total_sales,
    total_profit,
    dense_rank() over(order by total_sales desc) as sales_rank
from customer_summary
order by sales_rank;