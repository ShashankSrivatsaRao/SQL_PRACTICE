USE PRACTICE;

create table strings (name varchar(50));
delete from strings;
insert into strings values ('Ankit Bansal'),('Ram Kumar Verma'),('Akshay Kumar Ak k'),('Rahul');

select * from strings
--Number of words in a string
select name,
		replace(name,' ','') as a,
		LEN(name)-LEN(replace(name,' ',''))+1 as [number of words]
from strings

select name,
		replace(name,'Ra','') as a,
		(LEN(name)-LEN(replace(name,'Ra','')))/ LEN('Ra') as [number of Ra's]
from strings

--RECURSIVE CTE TO FIND ORGANIZATION HIERARCHY
USE [sql-tut]


Create table Employees
(
 EmployeeID int primary key identity,
 EmployeeName nvarchar(50),
 ManagerID int foreign key references Employees(EmployeeID)
)


Insert into Employees values ('John', NULL)
Insert into Employees values ('Mark', NULL)
Insert into Employees values ('Steve', NULL)
Insert into Employees values ('Tom', NULL)
Insert into Employees values ('Lara', NULL)
Insert into Employees values ('Simon', NULL)
Insert into Employees values ('David', NULL)
Insert into Employees values ('Ben', NULL)
Insert into Employees values ('Stacy', NULL)
Insert into Employees values ('Sam', NULL)


Update Employees Set ManagerID = 8 Where EmployeeName IN ('Mark', 'Steve', 'Lara')
Update Employees Set ManagerID = 2 Where EmployeeName IN ('Stacy', 'Simon')
Update Employees Set ManagerID = 3 Where EmployeeName IN ('Tom')
Update Employees Set ManagerID = 5 Where EmployeeName IN ('John', 'Sam')
Update Employees Set ManagerID = 4 Where EmployeeName IN ('David')


--ORGANIZATIONAL HIERARCHY OF A GIVEN EMPID
SELECT * FROM Employees

--SIMPLE QUERY TO FIND THE EMPLOYEE AND THEIR MANAGERS
SELECT E.EmployeeName,COALESCE(M.EmployeeName,'No BOSS') 
FROM Employees E 
LEFT JOIN Employees M
ON E.ManagerID=M.EmployeeID

--NOW FIND  THE HIERARCHY FOR A PARTICULAR EMPLOYEE
DECLARE @i int = 4;
WITH EMP AS(
		--anchor
		SELECT EmployeeID,EmployeeName,ManagerID
		FROM Employees
		WHERE EmployeeID=@i

		UNION ALL
		--recursion
		SELECT E.EmployeeID,E.EmployeeName,E.ManagerID
		FROM Employees E
		JOIN EMP 
		ON E.EmployeeID=EMP.ManagerID
		)
SELECT E.EmployeeName,COALESCE(M.EmployeeName,'NO BOSS')
FROM EMP E
LEFT JOIN EMP M
ON E.ManagerID=M.EmployeeID