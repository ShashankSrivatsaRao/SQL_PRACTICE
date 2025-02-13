--https://datalemur.com/questions/alibaba-compressed-mean
/*Compressed Mean
Alibaba SQL Interview Question
You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information
on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).*/
-- Create the 'items_per_order' table
CREATE TABLE items_per_order (
    item_count INTEGER,
    order_occurrences INTEGER
);

-- Insert records into the 'items_per_order' table
INSERT INTO items_per_order (item_count, order_occurrences) VALUES
(1, 500),
(2, 1000),
(3, 800),
(4, 1000),
(5, 750),
(6, 600),
(7, 400),
(8, 300),
(9, 200),
(10, 100),
(11, 50),
(12, 25),
(13, 15),
(14, 10),
(15, 5),
(16, 3),
(17, 2),
(18, 1);

--CALCULATE THE AVERAGE OF ALL THE ORDERS 
SELECT
	ROUND(
	(CAST(SUM(order_occurrences*item_count) AS FLOAT) /CAST(SUM(order_occurrences) AS FLOAT)) --AS ROUND TAKES FLOAT VALUES IN THE FIRST ARGUMENT WE CAST THE VALUES AS FLOAT
	,2) as mean
FROM items_per_order

--SO WE CAST THE SUM OF ALL THE OCCURENCCES* ITEM_COUNT INTO FLOAT AND ALSO SUM OF ALL THE OCCURENCES INTO FLOAT AND DIVIDE THEM .
--THEN WE ROUND OF THE VALUE TO 2 DECIMAL PLACES
