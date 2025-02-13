--https://datalemur.com/questions/cards-issued-difference
/*Cards Issued Difference
JP Morgan SQL Interview Question Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards 
and the lowest issuance. Arrange the results based on the largest disparity.*/
-- Create the 'monthly_cards_issued' table
CREATE TABLE monthly_cards_issued (
    card_name VARCHAR(255),
    issued_amount INTEGER,
    issue_month INTEGER,
    issue_year INTEGER
);

-- Insert records into the 'monthly_cards_issued' table
INSERT INTO monthly_cards_issued (card_name, issued_amount, issue_month, issue_year) VALUES
('Chase Freedom Flex', 55000, 1, 2021),
('Chase Freedom Flex', 60000, 2, 2021),
('Chase Freedom Flex', 65000, 3, 2021),
('Chase Freedom Flex', 70000, 4, 2021),
('Chase Sapphire Reserve', 170000, 1, 2021),
('Chase Sapphire Reserve', 175000, 2, 2021),
('Chase Sapphire Reserve', 180000, 3, 2021),
('Chase Sapphire Reserve', 185000, 4, 2021),
('Capital One Venture', 45000, 1, 2021),
('Capital One Venture', 47000, 2, 2021),
('Capital One Venture', 50000, 3, 2021),
('Capital One Venture', 55000, 4, 2021),
('Discover It Cash Back', 30000, 1, 2021),
('Discover It Cash Back', 32000, 2, 2021)


--Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards 
--and the lowest issuance. Arrange the results based on the largest disparity.*/
--SELECT * FROM monthly_cards_issued

WITH JP AS (	
	    SELECT card_name,
			   FIRST_VALUE(issued_amount) OVER (PARTITION BY card_name --using fv() and lv() window functions o get the max and min value of each window
			   ORDER BY issued_amount DESC ) as H,
			   LAST_VALUE(issued_amount) OVER (PARTITION BY card_name
			   ORDER BY issued_amount DESC RANGE BETWEEN
			   UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as L--using a frame function to get the lowest value in each card_name window
		FROM monthly_cards_issued 
		)
SELECT card_name,
	   (H-L) as difference --to find the difference between the highest and lowest value in a window
FROM JP --use cte to get the highest and the lowest issuance amount for every card
GROUP BY card_name,H,L --group by all the rows to shrink the table
ORDER BY difference DESC -- TO Arrange the results based on the largest disparity;
