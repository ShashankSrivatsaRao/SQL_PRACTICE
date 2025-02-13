--https://datalemur.com/questions/completed-trades
/*Cities With Completed Trades
Robinhood SQL Interview Question

This is the same question as problem #2 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.*/

-- Recreate the table without timestamp column
CREATE TABLE trades (
    order_id INT PRIMARY KEY,
    user_id INT,
    quantity INT,
    status VARCHAR(20) CHECK (status IN ('Completed', 'Cancelled')),
    date DATETIME NULL,  -- Use DATETIME instead of TIMESTAMP
    price DECIMAL(5, 2)
);
-- users table
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    city VARCHAR(50),
    email VARCHAR(100),
    signup_date DATETIME
);
-- Insert data with explicit datetime values
INSERT INTO trades (order_id, user_id, quantity, status, date, price)
VALUES
(100101, 111, 10, 'Cancelled', '2022-08-17 12:00:00', 9.80),
(100102, 111, 10, 'Completed', '2022-08-17 12:00:00', 10.00);

-- Insert data into users
INSERT INTO users (user_id, city, email, signup_date)
VALUES
(111, 'San Francisco', 'rrok10@gmail.com', '2021-08-03 12:00:00'),
(148, 'Boston', 'sailor9820@gmail.com', '2021-08-20 12:00:00');


INSERT INTO trades (order_id, user_id, quantity, status, date, price)
VALUES
(100259, 148, 35, 'Completed', '2022-08-25 12:00:00', 5.10),
(100264, 148, 40, 'Completed', '2022-08-26 12:00:00', 4.80),
(100305, 300, 15, 'Completed', '2022-09-05 12:00:00', 10.00),
(100400, 178, 32, 'Completed', '2022-09-17 12:00:00', 12.00),
(100565, 265, 2, 'Completed', '2022-09-27 12:00:00', 8.70);

INSERT INTO users (user_id, city, email, signup_date)
VALUES
(178, 'San Francisco', 'harrypotterfan182@gmail.com', '2022-01-05 12:00:00'),
(265, 'Denver', 'shadower_@hotmail.com', '2022-02-26 12:00:00'),
(300, 'San Francisco', 'houstoncowboy1122@hotmail.com', '2022-06-30 12:00:00');

select * from trades 
select * from users
--Calculate the toatal orders in each city which are completed
SELECT 
	*
FROM trades t 
JOIN users u ON t.user_id=u.user_id
WHERE status='Completed'


--Now calculate the names of the city with number of orders in descending order and extract the top 3


SELECT 
	TOP 3 u.city as CITY,
	count(*) as total_orders
FROM trades t 
JOIN users u ON t.user_id=u.user_id
WHERE status='Completed'
GROUP BY city
ORDER BY count(*) DESC



