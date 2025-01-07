---------------------------------SUMMER CAMP TASK-------------------------------------

/*You have joined a development team in an organization that organizes summer youth
camps for children & teenagers. A youth summer camp is a supervised program
designed for children and teenagers during the summer months when school is not in
session. These camps offer a variety of activities that aim to educate, entertain, and
engage young people in a safe and structured environment. The duration of these
camps can range from a few days to several weeks.*/

/*Task 1: Your job is to create a database model for this situation. The model must
contain three tables. a) The first two tables will contain the columns that are in the
orange bubble. Each column can exist in exactly one table! b) The third table will
contain columns of your choice, but we must be able to tell how many times a
teenager Lakshmi visited the camp in last 3 years.*/

/*First Name,Last Name,Middle Name,DateOfBirth,Email,CampTitle,Gender,Start Date,PersonalPhone,EndDate,Price,Capacity These are the fields

==========================TASK 1==============================

--2 Tables 
--1.Students- Table Containing all the students attending the Summer Camp
--2.Camp- Table containing all the details of the camp
--3.Student_Camp_Details- Table containing the list of students and the corrosponding camps they enrolled in.
    -- Related to Students and Camp Table Modelling a Many-to-Many RelationShip

--1.Student( StudentID,FirstName,MiddleName,LastName,DateOdBirth,Email,Gender,PersonalPhone) - StudentID as Primary Key
--AS the camp should only have teenagers as student I have addeda check constraint in the DOB field so that the age is less than 20 so that 
--the kid is a teenager*/
GO
DROP TABLE IF EXISTS CAMP_DETAILS--THIS IS DROPPED BECAUSE CAMP_DETAILS HAS A FOREIGN KEY OF STUDENT
DROP TABLE IF EXISTS STUDENT
CREATE TABLE STUDENT(
	StudentID int PRIMARY KEY,
	FirstName varchar(20) NOT NULL,
	MiddleName varchar(20),
    LastName varchar(20),
	DateOfBirth date NOT NULL CHECK(DATEDIFF(YEAR,DateOfBirth,GETDATE()) <20),
	Email varchar(50)NOT NULL,
	Gender varchar(10) CHECK (Gender IN ('Male','Female')) NOT NULL,
	PersonalPhone bigint NOT NULL );
--2.Camp(CampTitle,StartDate,EndDate,Price,Capacity)

DROP TABLE IF EXISTS CAMP
CREATE TABLE CAMP(
	CampID int PRIMARY KEY,
	CampTitle varchar(20) NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	Price int NOT NULL,
	Capacity int NOT NULL )
--3.Student_Camp_Details (Reg_No,studentid,campid) where Reg_No is the PrimaryKey it is Registration Number which is uniquely assigned to each registration

DROP TABLE IF EXISTS CAMP_DETAILS
CREATE TABLE CAMP_DETAILS(
	RegNo int PRIMARY KEY,
	StudentID int references STUDENT(StudentID) on delete cascade ,
	CampID int references CAMP(CampID)
	)
/*USING THE FOREIGN KEY CONSTRAINT
	CREATE TABLE CAM_DETAILS(
		RegNo int PRIMARY KEY,
		StudentID  int ,
		CampID int ,
		FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
		FOREIGN KEY (CampID) REFERENCES CAMP(CampID)
)*/

/*We must be able to tell how many times a
teenager Lakshmi visited the camp in last 3 years.
INSERT LAKSHI AS A STUDENT INTO THE TABLE */

INSERT INTO STUDENT(StudentID,FirstName,MiddleName,LastName,DateOfBirth,Email,Gender,PersonalPhone)
VALUES (1,'Lakshmi','Veena','Malai','2008-09-15','lak@yahoo.com','Female',8727876542),
	   (2,'Karthik','G','Y','2007-09-08','jaff@gmai.com','Male',8213456784);

INSERT INTO CAMP(CampID,CampTitle,StartDate,EndDate,Price,Capacity)
VALUES (1,'Python','2024-09-25','2024-10-05',1000,10),
       (2,'Robotics','2022-03-25','2022-04-05',1200,5),
	   (3,'Python','2023-09-25','2023-10-05',1000,10),
	   (4,'Python','2020-09-25','2020-10-05',1000,10)

INSERT INTO CAMP_DETAILS(RegNo,StudentID,CampID)
VALUES(1,1,1),(2,1,3),(3,1,2) 

SELECT 'STUDENT' AS TAB
SELECT * FROM STUDENT
SELECT 'CAMP' AS TAB
SELECT * FROM CAMP
SELECT 'CAMP_DETAILS' AS TAB
SELECT * FROM CAMP_DETAILS


--Calculate the number of times Lakshmi visited the camp in the last 3 years
SELECT 
	COUNT(S.StudentID) AS NUMBER_OF_TIMES_LAKSHMI_VISITED_CAMP_IN_LAST_THREE_YEARS
FROM STUDENT S
JOIN CAMP_DETAILS C ON S.StudentID= C.StudentID
JOIN CAMP CA ON C.CampID=CA.CampID
AND DATEDIFF(YEAR,CA.StartDate,GETDATE()) <=3 --the datedifference between the current date and the start date should be 3
		
/* Learnings:
1.Adding a constraint to enter the student with age less that 19
2.Creating foreign keys and establishing relationships between tables
3.Calculating the difference between the dates.
-----------------------------------TASK 1 COMPLETED------------------------------------
==================================TASK2===========================================
/*Create a script that will populate one of your tables with a random 5000 people.
Out of these 5000, 65% should be girls and 35% should be boys. 
Out of these 5000, 18% should be between 7 and 12 years old, 27% should be 13 to 14,
20% should be 15-17 and the rest could be any age up to 19 years old.
SOLUTION
I SHOULD CONVERT THE PERCENTAGES TO WHOLE NUMBERS TO KEEP TRACK OF THE NUMBERS 
USING RAND() FUNCTION TO GENERATE values and insert them into the tables. 
APPROACH:
1.CREATE A TEMPORARY TABLE DECLARE VARIABLES WHICH WILL BE INSERTED INTO THE TABLE AND A TABLE VARIABLE WITH RANDOM NAMES
2.ADD COUNT VARIABLE TO LOOP THROUGH THE INSERTIONS 
3.INSERT THE RANDOMIZED VALUES INTO THE TABLE*/

--STEP 1: DELETE ALL THE RECORDS IN THE STUDENT TABLE AND BY RETAINING THE TABLE*/

DROP TABLE IF EXISTS CAMP_DETAILS
DROP TABLE STUDENT

--CREATE A TABLE VARIABLE STUDENT
		DECLARE @STUDENT TABLE  (
			StudentID INT PRIMARY KEY,
			FirstName VARCHAR(20) ,
			MiddleName VARCHAR(20),
			LastName VARCHAR(20),
			DateOfBirth DATE NOT NULL CHECK(DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 7 AND 19),
			Email VARCHAR(50),
			Gender VARCHAR(10) CHECK (Gender IN ('Male','Female')) NOT NULL,
			PersonalPhone BIGINT
		);


--STEP 2:DECLARE SAMPLE TABLE VARIABLES AND INSERT RANDOM NAMES INTO THE VARIABLES

		DECLARE @MaleNames TABLE(Name varchar(20))
		DECLARE @FemaleNames TABLE(Name varchar(20))
		DECLARE @LastNames TABLE(Name varchar(20))
		DECLARE @MiddleNames TABLE (Name VARCHAR(20));

		INSERT INTO  @MaleNames (Name) VALUES ('Meghana'),('Sandeep'),('Darshan'),('Sudeep'),('Yash'),('Harry'),('Deepika'),('Sanjana');
		INSERT INTO  @FemaleNames (Name) VALUES ('Srivatsa'),('Mangala'),('Sanjiv'),('Sumit'),('Dayal'),('Gowthami'),('Vaishnavi'),('Hanumantha');
		INSERT INTO  @LastNames (Name) VALUES ('Shetty'),('Gowda'),('Rao'),('Padukone'),('Kamath'),('Kapoor'),('Gupta'),('Upadhyaya');
		INSERT INTO @MiddleNames (Name) VALUES ('Grace'), ('Lee'), ('Marie'), ('James'), ('Elizabeth');

--STEP 3 :DECLARE VARIABLES WITH THE ACTUAL NUMBER OF STUDENTS FOR DIFFERENT CONDITIONS 
		DECLARE @FemaleCount INT = 3250;  -- 65% of 5000
		DECLARE @MaleCount INT = 1750;    -- 35% of 5000
		DECLARE @Age7to12 INT = 900;     -- 18% of 5000
		DECLARE @Age13to14 INT = 1350;   -- 27% of 5000
		DECLARE @Age15to17 INT = 1000;   -- 20% of 5000
		DECLARE @Age18to19 INT = 1750;    -- 12% of 5000
--STEP 4:DECLARE A COUNT VARIABLE INITIALIZED TO 0
		DECLARE @count INT = 0
       --LOOP THROUGH FOR 5000 times
		WHILE @count<5000
--STEP 5:NOW DECLARE ALL THE VARIABLES THAT HAS TO BE INSERTED INTO THE TABLE
		BEGIN 
			--Declare all the columns as variables in the student table
			DECLARE @FirstName varchar(20) ;
			DECLARE @MiddleName varchar(20);
			DECLARE @LastName varchar(20);
			DECLARE @DateOfBirth date ;
			DECLARE @Email varchar(50);
			DECLARE @Gender varchar(10);
			DECLARE @PersonalPhone bigint ;
	 
			--STEP 6:ASSIGN A GENDER BY TAKING A RANDOM VALUE FROM THE VIRTUAL TABLE WHICH CONSISTS OF THE GENDERS AND ITS CORROSPONDING COUNT
			SELECT TOP 1 @Gender = Gender
			FROM (VALUES ('Female', @FemaleCount), ('Male', @MaleCount)) AS GenderTable(Gender, Count)--declare virtual table within a from clause
			WHERE (Gender = 'Female' AND @FemaleCount > 0) --check the condidtion to make sure the count>0
			   OR (Gender = 'Male' AND @MaleCount > 0)
			ORDER BY NEWID();--SELECT A RANDOM ID
			IF @Gender = 'Female'
			  BEGIN
			   SET @FemaleCount = @FemaleCount - 1;
			  END
			ELSE IF @Gender='Male'
			  BEGIN
				SET @MaleCount = @MaleCount - 1;
			  END
		   --STEP 7:Assign age groups on remaining counts
				DECLARE @Age INT
				-- Assign age group based on remaining counts
				IF @Age7to12 > 0
				BEGIN
					SELECT TOP 1 @Age = Age
					FROM (VALUES (7), (8), (9), (10), (11), (12)) AS AgeRange(Age)
					ORDER BY NEWID();  -- Randomly pick an age in the 7–12 range
					SET @Age7to12 = @Age7to12 - 1;
				END
				ELSE IF @Age13to14 > 0
				BEGIN
					SELECT TOP 1 @Age = Age
					FROM (VALUES (13), (14)) AS AgeRange(Age)
					ORDER BY NEWID();  -- Randomly pick an age in the 13–14 range
					SET @Age13to14 = @Age13to14 - 1;
				END
				ELSE IF @Age15to17 > 0
				BEGIN
					SELECT TOP 1 @Age = Age
					FROM (VALUES (15), (16), (17)) AS AgeRange(Age)
					ORDER BY NEWID();  -- Randomly pick an age in the 15–17 range
					SET @Age15to17 = @Age15to17 - 1;
				END
				ELSE IF @Age18to19 > 0
				BEGIN
					SELECT TOP 1 @Age = Age
					FROM (VALUES (18), (19)) AS AgeRange(Age)
					ORDER BY NEWID();  -- Randomly pick an age in the 18–19 range
					SET @Age18to19 = @Age18to19 - 1;
				END
            --STEP 8: Calculate DateOfBirth based on age
				DECLARE @StartDate  DATE;
				DECLARE @EndDate DATE;
				SET @StartDate=DATEADD(YEAR, -@Age, GETDATE());
				SET @EndDate=DATEADD(YEAR,-@Age  ,GETDATE());
				
				SET @DateOfBirth= DATEADD(DAY,-FLOOR(RAND()*DATEDIFF(DAY,@StartDate,@EndDate)+1),@StartDate)

			--STEP 9: SELECT THE NAMES FROM THE LIST OF NAMES 
				IF @Gender='Female'
					SELECT TOP 1 @FirstName=Name FROM @FemaleNames ORDER BY NEWID();
				ELSE 
					SELECT TOP 1 @FirstName = Name FROM @MaleNames ORDER BY NEWID();

				-- Get random middle name
				SELECT TOP 1 @MiddleName = Name FROM @MiddleNames ORDER BY NEWID();

				-- Get random last name
				SELECT TOP 1 @LastName = Name FROM @LastNames ORDER BY NEWID();

			--STEP 10:SET THE EMAIL FIELD
  				SET @Email = LOWER(@FirstName + '.' + @LastName + '@gmail.com');

            --STEP 11: Generate random phone number
                SET @PersonalPhone = CAST(FLOOR(RAND() * 10000000000)  AS BIGINT);

		    --STEP 12 :Insert all the calculated values into the temporary table
			INSERT INTO @STUDENT (
				StudentID, FirstName, MiddleName, LastName, DateOfBirth, Email, Gender, PersonalPhone
			)
			VALUES (
				@Count + 1,
				@FirstName,
				@MiddleName,
				@LastName,
				@DateOfBirth,
				@Email,
				@Gender,
				@PersonalPhone
			);

	      SET @count=@count+1;
        END;
--STEP 13: NOW INSERT ALL THE VALUES IN THE TEMPORARY TABLE INTO THE STUDENT TABLE
SELECT 'STUDENTS ' AS TAB
SELECT * FROM @STUDENT;

/*SELECT * FROM #TempStudentData*/


----------------------------------END OF THE TASK 2----------------------------------------------
/* COMPLETED: 
LEARNINGS: 1. generating a random value inside a set of values:
			EX: SELECT TOP 1 NAME 
			    FROM( VALUES('SHASHANK'),('ADITITI')) AS TABLENAME(NAME) ORDER BY NEWID() NEWID() Orders the records in arandom manner
		2.Declaring ,set and use variables using @
		3.WHILE loop ,if else if and else condition,begin,end. 
=================================================TASK 2 COMPLETED ===============================================

------------------------------------------------TASK 3-----------------------------------------------------------
Task 3: Write a query that can output data in a format so that following chart can be drawn. The
number in the chart are indicative.

--CALCULATING THE PERCENTAGE OF MALE AND FEMALE IN EACH GENARATION*/

--STEP 1 : SELECT ALL THE APPROPRIATE ROWS REQUIRED FOR THE QUERY
 --SELECT StudentID,FirstName,DateOfBirth,Gender 
 --FROM STUDENT

--STEP 2: CALCULATE THE AGE OF EACH STUDENT BY TAKING THE DIFFERENCE BETWEEN THE CURRENT DATE AND THE DOB OF THE STUDENT AND ALSO ASSIGN EACH KID THE GENERATION IT BELONGS TO
	/*SELECT
		StudentID
		,FirstName
		,DateOfBirth,
		Gender
		,DATEDIFF(YEAR,DateOfBirth,GETDATE()) AS AGE,
		(CASE 
		WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 7 AND 12 THEN 'GenX' 
		WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 13 AND 14 THEN 'Millenials'
		WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 15 AND 17 THEN 'GenZ'
		WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) <= 19 THEN 'Gen Alpha'
		END) AS GENERATION
	FROM 
		STUDENT*/

--STEP 3: NOW CREATE A VIEW WITH THE AGE AND GENERATIONS BECAUSE IT WILL BE USED IN THE NEXT STEP

	/*CREATE VIEW  GEN AS(
		SELECT
			StudentID
			,FirstName,
			DateOfBirth,
			Gender,
			DATEDIFF(YEAR,DateOfBirth,GETDATE()) AS AGE,
			(CASE 
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 7 AND 12 THEN 'GenX' 
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 13 AND 14 THEN 'Millenials'
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 15 AND 17 THEN 'GenZ'
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 18 AND 19 THEN 'Gen Alpha'
			END) AS GENERATION
		FROM 
			STUDENT)*/
--STEP 4: NOW GROUP BY THE GENERATION ASSIGNED IN THE VIEW AND COUNT THE NUMBER OF MALES AND FEMALES USING SUM
 /*SELECT 
	GENERATION,
	SUM( CASE WHEN Gender='Female' THEN 1 ELSE 0 END) AS FEMALE_COUNT,
	SUM( CASE WHEN Gender='Male' THEN 1 ELSE 0 END ) AS MALE_COUNT ,
	COUNT(*) AS TOTAL_COUNT
FROM GEN 
	GROUP BY GENERATION*/

--STEP 5: USING THE COUNT CALCULATE THE PERCENTAGE BY USING THE '/' OPERATOR WITH CAST,ROUND AND CONCAT FUNCTIONS
     SELECT 'REPORT DATA' AS RESULT;
	 WITH ATS AS(
		SELECT
			StudentID
			,FirstName
			,DateOfBirth
			,Gender
			,DATEDIFF(YEAR,DateOfBirth,GETDATE()) AS AGE,
			(CASE 
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 7 AND 12 THEN 'GenX' 
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 13 AND 14 THEN 'Millenials'
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 15 AND 17 THEN 'GenZ'
			WHEN DATEDIFF(YEAR,DateOfBirth,GETDATE()) BETWEEN 18 AND 19 THEN 'Gen Alpha'
			END) AS GENERATION
		FROM 
			@STUDENT)
SELECT 
	x.GENERATION,--Name of the generation
	CONCAT(ROUND(CAST(x.FEMALE_COUNT AS FLOAT)/x.TOTAL_COUNT * 100,0),'%') AS FEMALE_PERCENTAGE,--Cast to convert int to float,round to round off the decimal places,concat to add '%' symbol
	CONCAT(ROUND(CAST(x.MALE_COUNT AS FLOAT)/x.TOTAL_COUNT * 100,0),'%') AS MALE_PERCENTAGE
FROM ( --SUB QUERY METHOD TO TAKE THE MALE_COUNT AND FEMALE_COUNT     
        SELECT 
		GENERATION,
		SUM( CASE WHEN Gender='Female' THEN 1 ELSE 0 END) AS FEMALE_COUNT,
		SUM( CASE WHEN Gender='Male' THEN 1 ELSE 0 END ) AS MALE_COUNT ,
		COUNT(*) AS TOTAL_COUNT
		FROM ATS 
		GROUP BY GENERATION)x


/*SELECT Gender,COUNT(*) as COUNT FROM STUDENT GROUP BY Gender*/
-----------------------------------END OF TASK 3-----------------------------------------
/*LEARNINGS:
1.DEALING WITH TABLE VARIABLES, COMMON TABLE EXPRESSIONS AND SUBQUERIES.
USE OF AGGREGATE FUNCTIONS,GROUP BY CLAUSE.*/
