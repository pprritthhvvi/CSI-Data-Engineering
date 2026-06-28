DROP DATABASE IF EXISTS bankdb;

CREATE DATABASE bankdb;

USE bankdb;

CREATE TABLE accounts(
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO accounts VALUES
(101,'John',5000),
(102,'Maria',8000),
(103,'Peter',3000),
(104,'Emma',10000),
(105,'David',1500);

SELECT * FROM accounts;

SELECT
account_id,
customer_name,
balance,
CASE
    WHEN balance>=10000 THEN 'Platinum'
    WHEN balance>=7000 THEN 'Gold'
    WHEN balance>=3000 THEN 'Silver'
    ELSE 'Bronze'
END AS AccountType
FROM accounts;

SELECT
customer_name,
balance,
CASE
    WHEN balance>=5000 THEN 'Eligible for Loan'
    ELSE 'Not Eligible'
END AS LoanStatus
FROM accounts;

START TRANSACTION;

UPDATE accounts
SET balance=balance-1000
WHERE account_id=101;

UPDATE accounts
SET balance=balance+1000
WHERE account_id=103;

SELECT * FROM accounts;

ROLLBACK;

SELECT * FROM accounts;

START TRANSACTION;

UPDATE accounts
SET balance=balance-500
WHERE account_id=102;

UPDATE accounts
SET balance=balance+500
WHERE account_id=105;

COMMIT;

SELECT * FROM accounts;

START TRANSACTION;

INSERT INTO accounts VALUES
(106,'Sophia',7000);

SAVEPOINT sp1;

UPDATE accounts
SET balance=9000
WHERE account_id=106;

ROLLBACK TO sp1;

COMMIT;

SELECT * FROM accounts;