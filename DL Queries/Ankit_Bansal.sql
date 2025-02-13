--CREATE PRACTICE
--USE PRACTICE;

SELECT NAME FROM sys.tables;

CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

SELECT * FROM students

-- GET ALL THE STUDENTS WHO SCORED MORE THAN AVG MARKS IN EACH SUBJECT
WITH CTE AS (SELECT subject,AVG(marks) as avg_mark
FROM students GROUP BY subject)
SELECT s.*,CTE.*
FROM CTE  JOIN
students  s ON s.subject=CTE.subject
WHERE s.marks > CTE.avg_mark


--GET PERCENTAGE OF STUDENTS SCORING MORE THAN 90
--WHAT I THOUGHT WAS THE ANSWER
SELECT CONCAT(ROUND((CAST(SUM(CASE WHEN marks>=90 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*))*100 , 2 ),'%') as percent
FROM students

-- THE ABOVE LOOKS FOR THE PERCENTAGE OF MARKS ABOVE 90 in all of the marks.But It has repeating students. I want percentage of students
-- who have higher than the 90 marks

SELECT  CONCAT(CAST(COUNT(DISTINCT studentname ) AS FLOAT)/(SELECT COUNT(DISTINCT studentname )FROM students) * 100 ,'%')
FROM students
where marks>=90

--FIND THE SECOND HIGHEST AND SECOND LOWEST IN EACH QUERy
SELECT subject,max(marks),min(marks)
--ROW_NUMBER() OVER (PARTITION BY subject ORDER BY marks DESC) as RN,
--COUNT(1) OVER (PARTITION BY subject) as COUNT 
FROM students s
WHERE marks <> (  SELECT max(marks) OVER(PARTITION BY subject ORDER BY marks DESC)
                      from students --where subject=s.subject
					  UNION ALL SELECT min(marks) OVER(PARTITION BY subject ORDER BY marks DESC)
                      from students --where subject=s.subject )
GROUP BY subject

--BUT THE ACTUAL ANSWER IS 
SELECT subject,
	   SUM(CASE WHEN md=2 THEN marks else 0 END) as Second_Highest,
	   SUM(CASE WHEN ma=2 THEN marks else 0 END) as Second_lowest
FROM(
SELECT subject,marks,rank() over (partition by subject order by marks desc ) as md,
         rank() over (partition by subject order by marks asc ) as ma
FROM students) A
GROUP BY subject


--FOR EACH STUDENT FIND IF THE MARKS INCREASED OR DECREASED FROM PREVIOUS TEST

SELECT [studentid],
	   [studentname],
	   [subject],
	   (case when marks>prev_marks then 'increase'
	   when marks<= prev_marks then 'decrease'
	   else 'No enough tests' end)as STATUS
FROM
(SELECT *, LAG(marks) OVER (PARTITION BY studentid ORDER BY testdate,subject ) as prev_marks
FROM students) a

--'2' will be same as 2 as it is implicit type conversion

SELECT * FROM students where studentid <> '2'

SELECT RIGHT(datename(month,'2025-01-14'),3)

SELECT RIGHT( REPLICATE('Hi ',3),3)

--nth record from the last
select * from students order by marks  desc offset 8 rows fetch next  3  row only;

select * from students order by NEWID()

select studentname,iif(marks > 40 ,'p','f') from students

use PRACTICE

--Number of emps Ben manages

with ASS as (
select e1.*,
	count(e1.EmployeeID) over (Partition by e1.EmployeeName order by e1.EmployeeID) as en
from Employees e1 join Employees e2 
ON e1.EmployeeID=e2.ManagerID )

SELECT EmployeeName as count_of_emp_managed,count(1) FROM ASS where en > 2 group by EmployeeName

select * from Employees e join Employees m on e.EmployeeID=m.ManagerID

