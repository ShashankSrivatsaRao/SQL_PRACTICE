--CREATE DATABASE PRACTICE
--USE PRACTICE

/*employee_id	name	   salary	department_id	manager_id
1	Emma Thompson	    3800	1					6
2	Daniel Rodriguez	2230	1					7
3	Olivia Smith	    7000	1					8
4	Noah Johnson	    6800	2					9
5	Sophia Martinez	    1750	1					11
6	Liam Brown	        13000	3					NULL
7	Ava Garcia	        12500	3					NULL
8	William Davis	    6800	2					NULL*/


--1.List each dept total salary ,count of employees having fewer than 5 employees
select 
	department_id,
	concat('Rs ',sum(salary)) as total_salary,
	COUNT(*) as total_employees
from employee2
group by department_id
having count(*) < 5

--2.FETCH THE 3 EMPLOYEES WHO EARN THE HIGHEST SALARY 
select employee_id,name,salary
from employee2
order by salary
offset (select count(*) from employee2)-3 rows
fetch next 3 row only

--3.FETCH THE EMPLOYEE WHO IS NOT A MANAGER AND EARNS THE HIGHEST SALARY

select top 1 employee_id,name,salary 
from employee2
where manager_id IS NOT NULL
order by salary desc

--4.FETCH THE MANAGER  WHO IS A MANAGER AND EARNS THE HIGHEST SALARY
select top 1 m.employee_id,m.name,m.department_id ,m.salary
from employee2 e join 
employee2 m on e.manager_id=m.employee_id
order by m.salary desc

--5.Extract first letter of every name and give initials to employees

select employee_id,
	name,
	upper(concat(left(name,1),substring(name,charindex(' ',name)+1,1))) as Initials
from employee2

--2nd highest salary 
select max(salary) as second_highest 
from employee2 
where salary <>(select max(salary) from employee2)

--RECURSIVE CTE

SELECT name from employee2
--REVERSING PRACTICE USING RECURSIVE query
WITH CTEA AS (
	SELECT name ,CAST( SUBSTRING(name,LEN(name),1) AS VARCHAR(30)) as Reversed,LEN(name)-1 as pos
	FROM employee2

	UNION ALL

	SELECT name,CAST((Reversed + SUBSTRING(name,pos,1)) AS VARCHAR(30)),pos -1 
	FROM CTEA
	WHERE pos>0
)
SELECT * from CTEA where pos =0


--recursive cte to reverse a string
with RCB as(
	select skill,
		   CAST(substring(skill,LEN(skill),1) AS VARCHAR(MAX)) as Rev,
		   LEN(skill) -1 as P
	from candidates

	UNION ALL

	select skill,
		   Rev + CAST(substring(skill,P,1) as VARCHAR(MAX)) ,
		   P-1
	FROM RCB
	WHERE P>0
	)
SELECT c.skill,R.Rev
FROM candidates c JOIN RCB R  
on c.skill=R.skill 
WHERE R.P=0

/*-->> Problem Statement:
Suppose you have a car travelling certain distance and the data is presented as follows -
Day 1 - 50 km
Day 2 - 100 km
Day 3 - 200 km

Now the distance is a cumulative sum as in
    row2 = (kms travelled on that day + row1 kms).

How should I get the table in the form of kms travelled by the car on a given day and not the sum of the total distance?*/
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);


insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);



--ANSWER:

SELECT  *,--take lag, add coalesce to handle null and subtract the current value from lag
		cumulative_distance - coalesce(lag(cumulative_distance) over (partition by cars order by days) ,0) as distance
FROM  car_travels 

--TRICKY Q with NTILE AND STRING_AGG

create table emp_input
(
id      int,
name    varchar(40)
);
insert into emp_input values (1, 'Emp1');
insert into emp_input values (2, 'Emp2');
insert into emp_input values (3, 'Emp3');
insert into emp_input values (4, 'Emp4');
insert into emp_input values (5, 'Emp5');
insert into emp_input values (6, 'Emp6');
insert into emp_input values (7, 'Emp7');
insert into emp_input values (8, 'Emp8');

select * from emp_input;

--AGGREGATE 2 records together.
select STRING_AGG(' '+CAST(id as varchar(2))+' '+name , ',')as value 
from (select *,ntile(4) over(order by id ) as D from emp_input)as x
group by D

/*Expected output
 value
 1 Emp1, 2 Emp2
 3 Emp3, 4 Emp4
 5 Emp5, 6 Emp6
 7 Emp7, 8 Emp8*/

 DROP TABLE IF EXISTS LIFT
 CREATE TABLE LIFT(
 ID INT PRIMARY KEY,
 CAPACITY INTEGER NOT NULL)

 DROP TABLE LP
 CREATE TABLE LP(
 PID INT PRIMARY KEY,
 NAME VARCHAR (10) ,
 WEIGHT INT NOT NULL,
 LID INT REFERENCES LIFT(ID) on delete cascade)

 insert into LIFT values(1,600)
 insert into LIFT values(2,700)

 insert into LP values(1,'Shashank',76,1)
 insert into LP values(2,'Ashwin',66,1)
 insert into LP values(3,'Vishwas',90,1)
 insert into LP values(4,'Nitin',59,1)
 insert into LP values(5,'Appu',96,2)
 insert into LP values(6,'Darshan',89,2)
 insert into LP values(7,'Nayana',70,2)
 insert into LP values(8,'Sandeep',80,2)
 insert into LP values(9,'Purvik',55,2)
 insert into LP values(10,'PAYAL',300,1)
  insert into LP values(11,'Shine',30,1)
  insert into LP values(12,'Mangala',400,2)
 
--GET A LIST OF NAMES OF PEOPLE WHO FIT IN THE LIST

/*LIFT_ID	PASSENGERS
1	     Shine,Nitin,Ashwin,Shashank,Vishwas
2	     Purvik,Nayana,Sandeep,Darshan,Appu*/
 SELECT LIFT_ID,STRING_AGG( PASSENGERS,',') as PASSENGERS
 FROM
 (
 select P.PID ,
		L.ID as LIFT_ID,
		P.NAME AS PASSENGERS,
		P.WEIGHT,
		SUM(P.WEIGHT) OVER (PARTITION BY P.LID ORDER BY WEIGHT) AS S,
		L.CAPACITY 
 from LP P
 join LIFT L
 ON P.LID=L.ID
 ) x
 where S < CAPACITY
 GROUP BY LIFT_ID
