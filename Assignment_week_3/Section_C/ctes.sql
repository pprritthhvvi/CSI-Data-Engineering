
with customer_sales as (
    select customername,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customername
)
select *
from customer_sales
order by total_sales desc;



with customer_avg_sales as (
    select customername,
           avg(sales) as average_sales
    from superstore_analytics.superstore_raw
    group by customername
)
select *
from customer_avg_sales
order by average_sales desc;



with region_sales as (
    select region,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by region
)
select *
from region_sales
order by total_sales desc;



with category_sales as (
    select category,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by category
)
select *
from category_sales
order by total_sales desc;



with customer_sales as (
    select customername,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customername
)
select *
from customer_sales
order by total_sales desc
limit 10;



with customer_orders as (
    select customername,
           count(distinct orderid) as total_orders
    from superstore_analytics.superstore_raw
    group by customername
)
select *
from customer_orders
order by total_orders desc;



with category_profit as (
    select category,
           sum(profit) as total_profit
    from superstore_analytics.superstore_raw
    group by category
)
select *
from category_profit
order by total_profit desc;



with sales_cte as (
    select category,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by category
),
profit_cte as (
    select category,
           sum(profit) as total_profit
    from superstore_analytics.superstore_raw
    group by category
)
select
    s.category,
    s.total_sales,
    p.total_profit
from sales_cte s
join profit_cte p
on s.category = p.category;



with customer_sales as (
    select customername,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by customername
),
average_sales as (
    select avg(total_sales) as avg_sales
    from customer_sales
)
select *
from customer_sales
where total_sales >
(
    select avg_sales
    from average_sales
);



with region_category_sales as (
    select region,
           category,
           sum(sales) as total_sales
    from superstore_analytics.superstore_raw
    group by region, category
)
select *
from region_category_sales
order by region, total_sales desc;




-- This section demonstrates
-- WITH clause
-- Single CTE
-- Multiple CTEs
-- Intermediate aggregations
-- Reusing CTEs
-- Business-oriented reporting

-- These cover the CTE concepts