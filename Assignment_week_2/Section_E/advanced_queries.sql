--1
select
    category,
    case
        when sales >= 1000 then 'High Sales'
        when sales >= 500 then 'Medium Sales'
        else 'Low Sales'
    end as sales_category
from superstore;

--2
select
    region,
    sum(sales) as total_sales
from superstore
group by region
having sum(sales) > 100000;

--3
select
    customername,
    sum(sales) as total_sales
from superstore
group by customername
order by total_sales desc
limit 10;

--4
select
    productname,
    sum(sales) as total_sales
from superstore
group by productname
order by total_sales desc
limit 10;

--5
select
    month(str_to_date(orderdate,'%m/%d/%Y')) as month_number,
    sum(sales) as monthly_sales
from superstore
group by month_number
order by month_number;

--6
select
    orderid,
    count(*) as total_products
from superstore
group by orderid
having count(*) > 1;

--7
select
    category,
    avg(profit) as average_profit
from superstore
group by category;

--8
select
    state,
    sum(profit) as total_profit
from superstore
group by state
order by total_profit desc
limit 10;

--9
select
    productname,
    sum(quantity) as total_quantity
from superstore
group by productname
order by total_quantity desc
limit 10;

--10
select
    region,
    category,
    sum(sales) as total_sales
from superstore
group by region, category
order by region, total_sales desc;

--11
select
    customername,
    sum(profit) as total_profit
from superstore
group by customername
order by total_profit desc
limit 10;

--12
select
    count(*) as duplicate_orders
from (
    select orderid
    from superstore
    group by orderid
    having count(*) > 1
) as duplicates;

--13
select
    count(*) as null_customername
from superstore
where customername is null;

--14
select
    count(*) as null_productname
from superstore
where productname is null;

--15
select
    count(*) as total_orders
from superstore;