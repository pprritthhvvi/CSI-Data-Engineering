
select
    orderid,
    customername,
    sales,
    row_number() over(order by sales desc) as row_num
from superstore_analytics.superstore_raw;



select
    customername,
    sales,
    rank() over(order by sales desc) as sales_rank
from superstore_analytics.superstore_raw;



select
    customername,
    sales,
    dense_rank() over(order by sales desc) as dense_sales_rank
from superstore_analytics.superstore_raw;



select
    category,
    productname,
    sales,
    row_number() over(partition by category order by sales desc) as row_num
from superstore_analytics.superstore_raw;



select
    region,
    orderid,
    sales,
    rank() over(partition by region order by sales desc) as region_rank
from superstore_analytics.superstore_raw;



select
    orderdate,
    sales,
    sum(sales) over(order by str_to_date(orderdate,'%m/%d/%Y')) as running_total
from superstore_analytics.superstore_raw;



select
    orderdate,
    sales,
    avg(sales) over(order by str_to_date(orderdate,'%m/%d/%Y')) as running_average
from superstore_analytics.superstore_raw;



select
    orderid,
    sales,
    lag(sales) over(order by sales desc) as previous_sales
from superstore_analytics.superstore_raw;



select
    orderid,
    sales,
    lead(sales) over(order by sales desc) as next_sales
from superstore_analytics.superstore_raw;



select
    orderid,
    sales,
    sales - lag(sales) over(order by sales desc) as sales_difference
from superstore_analytics.superstore_raw;



select *
from
(
    select
        category,
        productname,
        sales,
        row_number() over(partition by category order by sales desc) as rn
    from superstore_analytics.superstore_raw
) t
where rn = 1;



select *
from
(
    select
        region,
        customername,
        sum(sales) as total_sales,
        dense_rank() over(partition by region order by sum(sales) desc) as region_rank
    from superstore_analytics.superstore_raw
    group by region, customername
) t
where region_rank <= 3;



select
    customername,
    sales,
    sum(sales) over(partition by customername) as customer_total_sales
from superstore_analytics.superstore_raw;



select
    category,
    productname,
    sales,
    avg(sales) over(partition by category) as category_average
from superstore_analytics.superstore_raw;


select
    orderid,
    sales,
    round((sales / sum(sales) over()) * 100, 2) as sales_percentage
from superstore_analytics.superstore_raw;


-- This section demonstrates all the major window function features commonly expected:

-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()
-- PARTITION BY
-- SUM() OVER()
-- AVG() OVER()
-- LAG()
-- LEAD()
-- Running totals
-- Top-N per group
-- Percentage contribution