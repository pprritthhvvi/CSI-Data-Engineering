
select customername, sales
from superstore_raw
where sales >
(
    select avg(sales)
    from superstore_raw
);



select orderid, customername, sales
from superstore_raw
where sales =
(
    select max(sales)
    from superstore_raw
);



select productname, quantity
from superstore_raw
where quantity >
(
    select avg(quantity)
    from superstore_raw
);



select customername
from superstore_raw
where customerid in
(
    select customerid
    from superstore_raw
    group by customerid
    having count(orderid) > 1
);



select orderid, customerid, sales
from superstore_raw s1
where sales >
(
    select avg(sales)
    from superstore_raw s2
    where s1.customerid = s2.customerid
);



select productname, profit
from superstore_raw
where profit =
(
    select max(profit)
    from superstore_raw
);



select customername,
       sum(sales) as total_sales
from superstore_raw
group by customername
having total_sales >
(
    select avg(total_sales)
    from
    (
        select sum(sales) as total_sales
        from superstore_raw
        group by customername
    ) as customer_sales
);



select *
from superstore_raw
where sales in
(
    select sales
    from
    (
        select sales
        from superstore_raw
        order by sales desc
        limit 10
    ) as top_sales
)
order by sales desc;



select distinct customername
from superstore_raw
where productid in
(
    select productid
    from superstore_raw
    where category = 'Technology'
);



select orderid
from superstore_raw
where orderid in
(
    select orderid
    from superstore_raw
    group by orderid
    having count(*) > 1
);