--https://datalemur.com/questions/click-through-rate
/*App Click-through Rate (CTR)
Facebook SQL Interview Question
Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:

Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.*/


CREATE TABLE events (
    app_id INT,
    event_type NVARCHAR(50),
    timestamp DATETIME
);

INSERT INTO events (app_id, event_type, timestamp) VALUES 
(123, 'impression', '2022-07-18 11:36:12'),
(123, 'impression', '2022-07-18 11:37:12'),
(123, 'click', '2022-07-18 11:37:42'),
(234, 'impression', '2022-07-18 14:15:12'),
(234, 'click', '2022-07-18 14:16:12');

--Calculate the impressions within 2022
SELECT app_id,
	   sum(case when event_type='click' then 1 else 0 end) as NC,
	   sum(case when event_type='impression' then 1 else 0 end) as NI
FROM events
GROUP BY app_id
--WHERE year(timestamp)=2022 OR
--WHERE timestamp>='2022-01-01' and timestamp<'2023-01-01'

--NOW USE CTE OR SUBQUERY
SELECT X.app_id,
	   ROUND((100.0 * X.NC /X.NI), 2 ) as CTR
FROM ( SELECT app_id ,
	   sum(case when event_type='click' then 1 else 0 end) as NC,
 	   sum(case when event_type='impression' then 1 else 0 end) as NI
       FROM events	   
       WHERE year(timestamp)=2022
       GROUP BY app_id ) as X



--USING CTE


WITH CTR AS (
			SELECT  app_id,
					sum(case when event_type='click' then 1 else 0 end) as cc,
					sum(case when event_type='impression' then 1 else 0 end) as ic
			FROM events
			WHERE year(timestamp)=2022
			GROUP BY app_id
			)
SELECT app_id,
       ROUND((100.0*cc/ic),2) as CTR 
FROM CTR  

