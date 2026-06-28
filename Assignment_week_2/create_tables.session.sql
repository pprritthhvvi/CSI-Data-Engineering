create database superstore_db;

use superstore_db;

-- Create Superstore table

create table superstore (
    rowid int primary key,
    orderid varchar(20),
    orderdate varchar(20),
    shipdate varchar(20),
    shipmode varchar(50),
    customerid varchar(20),
    customername varchar(100),
    segment varchar(50),
    country varchar(50),
    city varchar(100),
    state varchar(100),
    postalcode int,
    region varchar(50),
    productid varchar(30),
    category varchar(50),
    subcategory varchar(50),
    productname varchar(255),
    sales decimal(10,2),
    quantity int,
    discount decimal(5,2),
    profit decimal(10,2)
);

select count(*) from superstore;