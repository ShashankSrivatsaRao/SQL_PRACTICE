--https://datalemur.com/questions/sql-third-transaction
/*User's Third Transaction
Uber SQL Interview Question
Assume you are given the table below on Uber transactions made by users. 
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.*/

--Script to create tables
USE PRACTICE
DROP table if exists transactions
CREATE TABLE transactions(
user_id int ,
spend decimal(10,2) ,
transaction_date datetime )

INSERT INTO transactions (user_id, spend, transaction_date)
VALUES
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00'),
(121, 45.75, '2022-02-10 12:00:00'),
(145, 60.00, '2022-02-15 12:00:00'),
(111, 120.30, '2022-02-20 12:00:00'),
(121, 15.99, '2022-03-01 12:00:00'),
(145, 75.50, '2022-03-05 12:00:00'),
(111, 200.00, '2022-03-10 12:00:00'),
(121, 30.25, '2022-03-15 12:00:00'),
(145, 90.00, '2022-03-20 12:00:00'),
(111, 50.00, '2022-03-25 12:00:00'),
(121, 10.00, '2022-03-30 12:00:00');

select * from transactions

--FIND THE THIRD TRANSACTION OF EACH CUSTOMER

with cte as (
     SELECT *,row_number() over 
            (PARTITION By user_id order by transaction_date asc) as rn
     FROM transactions)
SELECT user_id,spend,transaction_date 
from cte 
where rn=3;
     