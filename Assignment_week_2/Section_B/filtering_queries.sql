/* This section demonstrates:Filtering Queries
WHERE, AND, OR, BETWEEN, IN, LIKE, ORDER BY, LIMIT, Date handling using STR_TO_DATE() since your dates are stored as text */

select * from superstore where region = 'West';

select * from superstore where category = 'Furniture';

select * from superstore where sales > 500;

select * from superstore where discount > 0.20;

select * from superstore where region = 'West' and category = 'Furniture';

select * from superstore where region = 'East' or region = 'South';

select * from superstore where sales between 100 and 500;

select * from superstore where state in ('California', 'Texas');

select * from superstore where customername like 'A%';

select * from superstore where productname like '%Chair%';

select * from superstore order by sales desc limit 10;

select * from superstore order by sales asc limit 10;

select * from superstore order by str_to_date(orderdate, '%m/%d/%Y') desc limit 10;

select * from superstore order by profit asc limit 10;

select * from superstore where quantity >= 5;