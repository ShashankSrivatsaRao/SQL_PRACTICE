--https://datalemur.com/questions/sql-page-with-no-likes
/* Page With No Likes
Facebook SQL Interview Question

Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.
*/
-- Create the pages table
CREATE TABLE pages (
    page_id INTEGER,
    page_name VARCHAR(255)
);

-- Insert example data into the pages table
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Create the page_likes table
CREATE TABLE page_likes (
    user_id INTEGER,
    page_id INTEGER,
    liked_date DATETIME
);



-- Insert example data into the page_likes table
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');

select * from pages 
select * from page_likes

--USING SUBQUERY

SELECT page_id 
FROM pages 
WHERE page_id NOT IN (
	SELECT page_id from page_likes )
ORDER BY page_id

--USING LEFT OUTER JOIN
SELECT p.page_id
from pages p
left outer join page_likes pl
on p.page_id=pl.page_id
where pl.liked_date is null;
