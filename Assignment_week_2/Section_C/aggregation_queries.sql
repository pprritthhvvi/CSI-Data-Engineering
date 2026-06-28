/*This section demonstrates:
COUNT()
SUM()
AVG()
MAX()
MIN()
GROUP BY
ORDER BY
DISTINCT
Business analysis*/


--1
select count(*) from superstore;

--2
select sum(sales) from superstore;


--3
select avg(sales) from superstore;

--4
select max(sales) from superstore;

--5
select min(sales) from superstore;

--6
select sum(quantity) from superstore;

--7
select avg(quantity) from superstore;

--8
select region, sum(sales) as totalsales from superstore group by region;

--9
select category, sum(sales) as totalsales from superstore group by category;


--10
select subcategory, sum(sales) as totalsales from superstore group by subcategory

--11
select category, avg(sales) as averagesales from superstore group by category;

--12
select region, avg(profit) as averageprofit from superstore group by region;

--13
select category, count(*) as totalproducts from superstore group by category;

--14
select customername, sum(sales) as totalsales from superstore group by customername order by totalsales desc limit 10;

--15
select state, sum(profit) as totalprofit from superstore group by state order by totalprofit desc;

--16
select shipmode, count(*) as totalorders from superstore group by shipmode;

--17
select segment, sum(sales) as totalsales from superstore group by segment;

--18
select region, max(sales) as highestsale from superstore group by region;

--19
select region, min(sales) as lowestsale from superstore group by region;

--20
select category, sum(quantity) as totalquantity from superstore group by category;
