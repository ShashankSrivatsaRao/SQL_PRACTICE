--https://datalemur.com/questions/second-day-confirmation
/*Second Day Confirmation
TikTok SQL Interview Question

Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

Definition:

action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.*/

CREATE TABLE emails (
    email_id INT,
    user_id INT,
    signup_date DATETIME
);
INSERT INTO emails (email_id, user_id, signup_date) VALUES 
(125, 7771, '2022-06-14 00:00:00'),
(433, 1052, '2022-07-09 00:00:00');

CREATE TABLE texts (
    text_id INT,
    email_id INT,
    signup_action NVARCHAR(50),
    action_date DATETIME
);
INSERT INTO texts (text_id, email_id, signup_action, action_date) VALUES 
(6878, 125, 'Confirmed', '2022-06-14 00:00:00'),
(6997, 433, 'Not Confirmed', '2022-07-09 00:00:00'),
(7000, 433, 'Confirmed', '2022-07-10 00:00:00');


INSERT INTO emails (email_id, user_id, signup_date) VALUES 
(236, 6950, '2022-07-01 00:00:00'),
(450, 8963, '2022-08-02 00:00:00'),
(555, 8963, '2022-08-09 00:00:00'),
(741, 1235, '2022-07-25 00:00:00');


INSERT INTO texts (text_id, email_id, signup_action, action_date) VALUES 
(9841, 236, 'Confirmed', '2022-07-01 00:00:00'),
(2800, 555, 'Confirmed', '2022-08-11 00:00:00'),
(1568, 741, 'Confirmed', '2022-07-26 00:00:00'),
(1255, 555, 'Not confirmed', '2022-08-09 00:00:00'),
(1522, 741, 'Not confirmed', '2022-07-25 00:00:00'),
(6800, 450, 'Not confirmed', '2022-08-02 00:00:00'),
(2660, 555, 'Not confirmed', '2022-08-09 00:00:00');


SELECT * FROM emails
SELECT * FROM texts;

--Correct Query Join the tables and checkn the date by adding 1 day.

SELECT DISTINCT e.user_id
FROM emails e
JOIN texts t 
ON e.email_id=t.email_id
WHERE DATEADD(DAY,1,e.signup_date) = t.action_date
AND t.signup_action='Confirmed'

