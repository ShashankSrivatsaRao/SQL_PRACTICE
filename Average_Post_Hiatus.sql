--https://datalemur.com/questions/sql-average-post-hiatus-1

/*Average Post Hiatus (Part 1)
Facebook SQL Interview Question

Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021.
Output the user and number of the days between each user's first and last post.*/

-- Create the posts table
CREATE TABLE posts (
    user_id INTEGER,
    post_id INTEGER,
    post_content TEXT,
    post_date DATETIME
);

-- Insert example data into the posts table
INSERT INTO posts (user_id, post_id, post_content, post_date) VALUES
(151652, 599415, 'Need a hug', '2021-07-10 12:00:00'),
(661093, 624356, 'Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that''s gonna fly by. I miss my girlfriend', '2021-07-29 13:00:00'),
(004239, 784254, 'Happy 4th of July!', '2021-07-04 11:00:00'),
(661093, 442560, 'Just going to cry myself to sleep after watching Marley and Me.', '2021-07-08 14:00:00'),
(151652, 111766, 'I''m so done with covid - need travelling ASAP!', '2021-07-12 19:00:00');


select * from posts

--Find users who have posted twice in a year

select user_id
from posts
where year(post_date)='2021'
group by user_id
having count(*) >=2

--Now that I have the users I have to order by the date of the post and find the first date and last date

select user_id as uid , first_value(post_date) over ( partition by user_id order by post_date) as a, last_value(post_date) over ( partition by user_id order by post_date range between unbounded preceding and unbounded following) as b
from posts 

--now combine both of them using a Common Table Expression
with cd as (
select user_id as uid, 
first_value(post_date) over ( partition by user_id order by post_date) as a, 
last_value(post_date) over ( partition by user_id order by post_date range between unbounded preceding and unbounded following) as b
from posts )
select p.user_id,
	   datediff(day, c.a,c.b) as days_between
from posts p join cd c on p.user_id=c.uid
where year(post_date)='2021'
group by user_id,c.a,c.b
having count(*) >=2