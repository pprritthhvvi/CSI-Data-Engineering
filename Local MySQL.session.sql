show databases;

create database bookstore;

use bookstore;

create table book_orders (
    order_id int,
    customer_name varchar(100),
    customer_email varchar(100),
    customer_address varchar(255),
    book_isbn varchar(20),
    book_title varchar(200),
    book_author varchar(100),
    book_price decimal(10,2),
    order_date date,
    quantity int,
    total_price decimal(10,2)
);

show tables;

insert into book_orders values
(1,'John Smith','john@example.com','123 Main St','978-0141439518','Pride and Prejudice','Jane Austen',9.99,'2023-01-15',2,19.98),
(2,'John Smith','john@example.com','123 Main St','978-0451524935','1984','George Orwell',12.99,'2023-01-15',2,25.98),
(3,'Mary Johnson','mary@example.com','456 Oak Ave','978-0612008484','To Kill a Mockingbird','Harper Lee',14.99,'2023-01-20',1,14.99),
(4,'Robert Brown','robert@example.com','789 Pine Rd','978-0141439518','Pride and Prejudice','Jane Austen',9.99,'2023-01-25',1,9.99);


select * from book_orders;


-- First Normal Form requires that
-- 1. Each column contains atomic (indivisible) values
-- 2. Each column contains values of the same type
-- 3. Each row is unique (typically ensured by a primary key)
-- 4. No repeating groups of columns


CREATE TABLE book_orders_1nf (
    order_id INT,
    book_isbn VARCHAR(20),
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address VARCHAR(255),
    book_title VARCHAR(200),
    book_author VARCHAR(100),
    book_price DECIMAL(10, 2),
    order_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    PRIMARY KEY (order_id,book_isbn)
);

insert into book_orders_1nf values
(1,'John Smith','john@example.com','123 Main St','978-0141439518','Pride and Prejudice','Jane Austen',9.99,'2023-01-15',2,19.98),
(2,'John Smith','john@example.com','123 Main St','978-0451524935','1984','George Orwell',12.99,'2023-01-15',2,25.98),
(3,'Mary Johnson','mary@example.com','456 Oak Ave','978-0612008484','To Kill a Mockingbird','Harper Lee',14.99,'2023-01-20',1,14.99),
(4,'Robert Brown','robert@example.com','789 Pine Rd','978-0141439518','Pride and Prejudice','Jane Austen',9.99,'2023-01-25',1,9.99);

select * from book_orders_1nf;



-- For a table to be in 2NF:
-- 1. It must be in 1NF
-- 2. All non-key attributes must be fully functionally dependent on the entire primary key
-- means no non-key column should depend on only part of the primary key
-- no partial dependencies on primary key

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_address VARCHAR(255),
    order_date DATE
);

CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE order_items (
    order_id INT,
    book_isbn VARCHAR(20),
    quantity INT,
    total_price DECIMAL(10, 2),
    PRIMARY KEY (order_id, book_isbn),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_isbn) REFERENCES books (isbn)
);

INSERT INTO orders VALUES
(1, 'John Smith', 'john@example.com', '123 Main St, Anytown', '2023-01-15'),
(2, 'Mary Johnson', 'mary@example.com', '456 Oak Ave, Somewhere', '2023-01-20'),
(3, 'Robert Brown', 'robert@example.com', '789 Pine Rd, Nowhere', '2023-01-25');

INSERT INTO books VALUES
('978-0141439518', 'Pride and Prejudice', 'Jane Austen', 9.99),
('978-0451524935', '1984', 'George Orwell', 12.99),
('978-0061120084', 'To Kill a Mockingbird', 'Harper Lee', 14.99);

INSERT INTO order_items VALUES
(1, '978-0141439518', 1, 9.99),
(1, '978-0451524935', 2, 25.98),
(2, '978-0061120084', 1, 14.99),
(3, '978-0141439518', 1, 9.99);

select * from orders;
select * from books;
select * from order_items;

-- What is 3NF?
-- 1. 2NF
-- 2. It must not have transitive dependencies
-- A transitive dependency occurs when a non-key attribute depends on another non-key attribute, rather than depending directly on the primary key.

CREATE TABLE customers_3nf (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
address VARCHAR(255)
);

CREATE TABLE orders_3nf (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers_3nf(customer_id)
);

CREATE TABLE books_3nf (
isbn VARCHAR(20) PRIMARY KEY,
title VARCHAR(200),
author VARCHAR(100),
price DECIMAL(10, 2)
);

CREATE TABLE order_items_3nf (
order_id INT,
book_1sbn VARCHAR(20),
quantity INT,
PRIMARY KEY (order_id, book_isbn),
FOREIGN KEY (order_id) REFERENCES orders_3nf(order_id),
FOREIGN KEY (book_isbn) REFERENCES books_3nf(isbn)
);