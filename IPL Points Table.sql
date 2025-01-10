-- Create a table to store match results
/*CREATE TABLE IPL (
  Team1 VARCHAR(3) NOT NULL,  -- Abbreviation for the first team
  Team2 VARCHAR(3) NOT NULL,  -- Abbreviation for the second team
  MatchResult INTEGER         -- Result of the match
);

-- Insert match results into the EMPLOYEE table
INSERT INTO IPL VALUES ('RR', 'KKR', 2);   -- Team2 (KKR) wins
INSERT INTO IPL VALUES ('MI', 'CSK', 2);   -- Team2 (CSK) wins
INSERT INTO IPL VALUES ('RCB', 'KXP', 1);  -- Team1 (RCB) wins
INSERT INTO IPL VALUES ('DD', 'RR', 0);    -- Match is a draw
INSERT INTO IPL VALUES ('KKR', 'RR', 1);   -- Team1 (KKR) wins
INSERT INTO IPL VALUES ('CSK', 'RCB', 2);  -- Team2 (RCB) wins
INSERT INTO IPL VALUES ('KXP', 'DD', 2);   -- Team2 (DD) wins*/ 

-- Description of MatchResult:
-- 1 means Team1 won the match
-- 2 means Team2 won the match
-- 0 means the match was a draw

-- Task - Calculate the total matches played, won, lost, and drawn for each team.
-- Goal: Write a query to produce the following result:
-- | Team | Played | Won | Lost | Draw |
-- | RR   | 3      | 0   | 2    | 1    |
-- | CSK  | 2      | 1   | 1    | 0    |
-- | RCB  | 2      | 2   | 0    | 0    |

WITH POINTS_TABLE AS
		(SELECT
			 Team1 as Team,
			 (CASE WHEN MatchResult =1 THEN 1 ELSE 0 END) AS Won,
			 (CASE WHEN MatchResult =2 THEN 1 ELSE 0 END) AS Lost,
			 (CASE WHEN MatchResult =0 THEN 1 ELSE 0 END) AS Draw
		FROM IPL 
		UNION ALL
		SELECT 
			 Team2 as Team,
			 (CASE WHEN MatchResult =2 THEN 1 ELSE 0 END) AS Won,
			 (CASE WHEN MatchResult =1 THEN 1 ELSE 0 END) AS Lost,
			 (CASE WHEN MatchResult =0 THEN 1 ELSE 0 END) AS Draw
		FROM IPL)
SELECT 
	Team,
	COUNT(*) AS Matches_Played,
	SUM(Won) AS Won ,
	SUM(Lost) AS Lost,
	SUM(Draw) AS Draw
FROM 
	POINTS_TABLE
GROUP BY Team
ORDER BY Matches_Played DESC