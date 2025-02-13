--https://datalemur.com/questions/laptop-mobile-viewership
/*Laptop vs. Mobile Viewership
New York Times SQL Interview Question

This is the same question as problem #3 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.*/

-- Create the viewership table with DATETIME type
CREATE TABLE viewership (
    user_id INTEGER,
    device_type VARCHAR(50),
    view_time DATETIME
);
-- Insert example data into the viewership table
INSERT INTO viewership (user_id, device_type, view_time) VALUES
(123, 'tablet', '2022-01-02 00:00:00'),
(125, 'laptop', '2022-01-07 00:00:00'),
(128, 'laptop', '2022-02-09 00:00:00'),
(129, 'phone', '2022-02-09 00:00:00'),
(145, 'tablet', '2022-02-24 00:00:00');


select * from viewership

--first count the number of mobile views
select 
sum( case when device_type='laptop' then 1 else 0 end) as laptop_views,
sum(case when device_type IN ('tablet','phone') then 1 else 0 end) as mobile_views
from viewership

/* Challenges -I was confused and could extract only one view properly. So tried UNION did not work.Tried self join but did not work. So had to use the sum with case function*/
