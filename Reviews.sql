--https://datalemur.com/questions/sql-avg-review-ratings
/*Average Review Ratings
Amazon SQL Interview Question

Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.

P.S. If you've read the Ace the Data Science Interview, and liked it, consider writing us a review?*/

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    submit_date DATETIME,
    product_id INT,
    stars INT CHECK (stars >= 1 AND stars <= 5)
);

INSERT INTO reviews (review_id, user_id, submit_date, product_id, stars)
VALUES
(6171, 123, '2022-06-08 00:00:00', 50001, 4),
(7802, 265, '2022-06-10 00:00:00', 69852, 4),
(5293, 362, '2022-06-18 00:00:00', 50001, 3),
(6352, 192, '2022-07-26 00:00:00', 69852, 3),
(4517, 981, '2022-07-05 00:00:00', 69852, 2);

select * from reviews;

--calculate the average in each month

SELECT MONTH(submit_date) as mth,
	   product_id as product,
	   ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY  MONTH(submit_date),product_id
ORDER BY MONTH(submit_date) , product
