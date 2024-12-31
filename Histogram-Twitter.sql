/*Histogram of Tweets
Twitter SQL Interview Question
Question
Solution
Discussion
Submissions
This is the same question as problem #6 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.*/
--https://datalemur.com/questions/sql-histogram-tweets

CREATE DATABASE PRACTICE;

USE  PRACTICE


CREATE TABLE tweets (
    tweet_id INT PRIMARY KEY,
    user_id INT,
    msg NVARCHAR(MAX),
    tweet_date DATETIME
);

INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
(214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
(739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
(846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
(241425, 254, 'If the salary is so competitive why won’t you tell me what it is?', '2022-03-01 00:00:00'),
(231574, 148, 'I no longer have a manager. I cant be managed', '2022-03-23 00:00:00');

select * from tweets


select
	d.number_of_tweets as tweet_bucket, 
	count(d.uid) as users_num
from
	(select 
		count(*) as number_of_tweets,user_id as uid
	 from 
		tweets
	 where 
		year(tweet_date)=2022
	 group by 
		user_id) as d
group by 
	d.number_of_tweets --using subquerry

--USING CTE

WITH CTE AS (
     select 
		count(*) as number_of_tweets,
		user_id as uid
	 from 
		tweets
	 where 
		year(tweet_date)=2022
	 group by 
		user_id)
SELECT 
	number_of_tweets as tweet_bucket,
	count(uid) as users_num
FROM 
	CTE
GROUP BY 
	number_of_tweets




	