--https://datalemur.com/questions/teams-power-users
/*--Teams Power Users
Microsoft SQL Interview Question
Question
Solution
Discussion
Submissions
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption:

No two users have sent the same number of messages in August 2022.*/

create table messages(
message_id	int,
sender_id	int,
receiver_id	int,
content	varchar,
sent_date	datetime);

ALTER TABLE messages
ALTER COLUMN content VARCHAR(255); -- Adjust size as needed

INSERT INTO messages (message_id, sender_id, receiver_id, content, sent_date)
VALUES
(901, 3601, 4500, 'You up?', '2022-08-03 00:00:00'),
(902, 4500, 3601, 'Only if you''re buying', '2022-08-03 00:00:00'),
(743, 3601, 8752, 'Let''s take this offline', '2022-06-14 00:00:00'),
(922, 3601, 4500, 'Get on the call', '2022-08-10 00:00:00');

select * from messages;

--Select the messages from theceach user and count it and add the where condition where the month and year are compared 

SELECT sender_id,
	   count(*) as message_count
from messages
where year(sent_date)='2022' and month(sent_date)='8' 
group by sender_id
order by count(*) desc
