/*PREVIOUSLY SUBMITTED CODE 

 --------------------------SKIP--------------------------------

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
		SELECT * FROM IPL
		--TASK- TO REVERSE THE WORDS OF THE TEAMS IN THE TABLE		
		SELECT 
			 --(CASE WHEN LEN(Team) % 2 =0 THEN  RIGHT(Team,LEN(Team)/2)/*+SUBSTRING(Team,(LEN(Team)/2)+1,1)+*/+LEFT(Team,LEN(Team)/2)
			 ELSE  RIGHT(Team,LEN(Team)/2)+SUBSTRING(Team,(LEN(Team)/2)+1,1)++LEFT(Team,LEN(Team)/2) END) AS team,--FIRST I WILLL CHECK IF THE LENGTH IS ODD OR EVEN 
			 --IF IT IS EVEN THEN I REPLACE THE LEFT AND RIGHT HALVIES
			 --ELSE IF IT IS ODD I WILL REPLACE THE LEFT AND RIGHT VALUES AND EXTRACT THE 
			Team,
			COUNT(*) AS Matches_Played,
			SUM(Won) AS Won ,
			SUM(Lost) AS Lost,
			SUM(Draw) AS Draw
		FROM 
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
				FROM IPL)x
		GROUP BY Team
		ORDER BY Matches_Played DESC 
 ----PREVIOUSLY SUBMITTED CODE----
#############################################
CREATE FUNCTION S(@input varchar(20)) 
RETURNS varchar(20)
BEGIN
	DECLARE @w varchar(20) ;
	SET @w = '';
	DECLARE @i INT = 0;
	WHILE @i < LEN(@input)
		BEGIN
		SET @w=SUBSTRING(@input,@i+1,1)+@w;
		SET @i=@i+1
	    END
 RETURN @w;
 END
 ############################################
--------------------------------SKIP--------------------------------------*/

GO
-- NEW FUNCTION TO REVERSE

CREATE FUNCTION re(@input varchar(max)) 
RETURNS VARCHAR(max) AS
BEGIN
	--S1: Take an empty string to store result and 
	     -- A pointer to last character
	DECLARE @REVERSED varchar(max) = ' ';
	DECLARE @I INTEGER = LEN(@input)
	-- S2:run a loop until pointer is at 0 i.e start of the string
	WHILE @I > 0
	BEGIN
	--S3: Extract the letter where the pointer is and add it to reversed string 
	     --Decrement the poiinter by 1
	SET @REVERSED=@REVERSED + SUBSTRING(@input,@I,1);
	SET @I=@I -1;
	END
	--S4:RETURN THE REVERSED STRING
	RETURN @REVERSED
END

GO
--QUERY
SELECT Team,
	   dbo.re(Team) REVERSE_NAME,
	   COUNT(*) AS MATCHES_PLAYED,
	   SUM(WON) AS MATCHES_WON,
	   SUM(LOST) AS MATCHES_LOST,
	   SUM(DRAW) AS MATCHES_DRAWN
FROM	(
    SELECT 
		Team1 as Team,
		IIF(MatchResult=1,1,0) AS WON,
		IIF(MatchResult=2,1,0) AS LOST,
		IIF(MatchResult=0,1,0) AS DRAW
	FROM IPL
	UNION ALL
	SELECT 
		Team2 as Team,
		IIF(MatchResult=2,1,0) AS WON,
		IIF(MatchResult=1,1,0) AS LOST,
		IIF(MatchResult=0,1,0) AS DRAW
	FROM IPL) AS Y
GROUP BY Team
ORDER BY 2 DESC
GO
------------------------------------Interview 2 with Karthik----------------------
--1. Take your name as input and pass it to the function

--declare @input varchar(max) = 'shashank';
--select @input as name , dbo.re(@input) as revere_name


---2.Optimize this query to reverse a string

declare @input varchar(max) = 'shashank';
with cte as (
	--anchor query
	select @input as name,
	''+substring(@input,len(@input),1) as reversed,
	len(@input) -1 as pos 

	UNION ALL
	--recursive part
	select @input ,reversed + substring(@input,pos,1),
		pos -1
	from cte
	where pos>0

)
select name,reversed,pos 
from cte 
where pos =0;
GO
----------------To create a stored procedure to reverse a string

CREATE PROCEDURE ReversedString @name varchar(max) 
AS
BEGIN
	with cte as (
	--anchor query
	select @name as name,
	''+substring(@name,len(@name),1) as reversed,
	len(@name) -1 as pos 

	UNION ALL
	--recursive part
	select @name ,reversed + substring(@name,pos,1),
		pos -1
	from cte
	where pos>0

)
select name,reversed,pos 
from cte 
where pos =0;
END

GO
-----------------------------Execute this procedure-----------------
EXEC ReversedString @name= 'Shashank'

----
/*Parameters - SP can have parameters which is define in the definition of the stored procedure
 variables- These are used  within the stored procedure and are local scope. They are used by developers
 
 Variables:
 1. Declare variables
 2. Assign values to variables in select clause instead of aliases
 3. Use it in the print statement*/
GO

ALTER PROCEDURE ReversedString @name varchar(max) 
AS
BEGIN
	DECLARE @r varchar(max) ;
	with cte as (
	--anchor query
	select @name as name,
	''+substring(@name,len(@name),1) as reversed,
	len(@name) -1 as pos 

	UNION ALL
	--recursive part
	select @name ,reversed + substring(@name,pos,1),
		pos -1
	from cte
	where pos>0

)
select @r= reversed 
from cte 
where pos =0;

PRINT 'Original Name is ' + @name ;
PRINT 'Reverse Name is ' + @r;

	IF @name = @r 
	BEGIN
	 PRINT 'The given name '+@name+' is palindrome'
	END
	ELSE 
	 PRINT 'The given name ' + @name + ' is not palindrome'

END

/*=====================================================
---------------triggers---------------------------

AFTER , INSTEAD OF TRIGGERS ARE USED 
TRIGGERS ARE SPECIAL STORED PROCEDURES WHICH ARE FIRED WHEN AN EVENT OCCURS
DML,DDL and LOGGON TRIGGERS

USE PRACTICE --Using the practice databse
SELECT name from sys.tables

SELECT * FROM STRINGS
---------------------------------------
--CREATE A LOG FOR STRINGS TABLE*/
------------------------------------
DROP TABLE IF EXISTS LOG
CREATE TABLE LOG (
	LOGID INT IDENTITY(1,1) PRIMARY KEY,
	LOGDATE DATETIME,
	STRING varchar(max))

----------------------------------------------------------------
--CREATE A TRIGGER FOR EVERY INSERT INTO THE STRINGS TABLE----
---------------------------------------------------------------
GO
/*ALTER TRIGGER LOGON ON STRINGS
AFTER INSERT
AS
BEGIN
	INSERT INTO LOG(LOGDATE,STRING)
	SELECT GETDATE(),
		'New string added =  '+name
	FROM inserted
END*/
--------------------------------END OF TRIGGER----------------

---------------------------------------------------
--INSERT FEW RECORDS INTO THE TABLE TO CHECK THE TRIGGER-----
------------------------------------------------------
INSERT INTO strings(name)  VALUES('Sandy'),('Darshan'),('Ross'),('Rachael')

-----------------------------------------------------------------------
---------------BY SELECTING THE LOG TABLE CHECK IF THE TRIGGER PUT VALUES INTO THE TABLE-----
-----------------------------------------------------------------------
SELECT * FROM LOG

------------------------------YES IT HAS PUT --------------------------
--Optimized query--
SELECT 	    Team,
			COUNT(*) AS Matches_Played,
			SUM(CASE WHEN Result='Won' THEN 1 ELSE 0 END) AS Won ,
			SUM(CASE WHEN Result='Lost' THEN 1 ELSE 0 END) AS Lost,
			SUM(CASE WHEN Result='DRAW' THEN 1 ELSE 0 END) AS Draw
		FROM 
			(SELECT
					 Team1 as Team,
					( CASE WHEN MatchResult=1 THEN 'Won'
						  WHEN MatchResult=2 THEN 'Lost'
						  ELSE 'DRAW' END) as Result
				FROM IPL 
				UNION ALL
				SELECT 
					 Team2 as Team,
					 ( CASE WHEN MatchResult=2 THEN 'Won'
						  WHEN MatchResult=1 THEN 'Lost'
						  ELSE 'DRAW'END) as Result
				FROM IPL)x
		GROUP BY Team
		ORDER BY Matches_Played DESC 


-----
