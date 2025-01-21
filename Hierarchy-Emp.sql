-----TO KNOW WHICH DB I AM IN CURRENTLY----
--select DB_NAME()
-------------------------------------

/*USING  employee2 table get the ierarchy of employees*/

--CONCEPTS : SELF JOIN , CTE , RECURSIVE CTE
--STEP 1 : DECLARE A VARIABLE THAT STORES THE EMP ID
DECLARE @q int;
SET @q =7;
--Now I should get the hoerarchy of the employee i.e from emp to the ceo. bottom up
--I use recursive cte for this.
with cte as (
	--anchor query
	select EmployeeID,EmployeeName,ManagerID
	from Employees
	where EmployeeID=@q
	
	UNION ALL

	--recursive query
	select e.EmployeeID,e.EmployeeName,e.ManagerID
	from Employees e 
	join cte c
	on e.EmployeeID=c.ManagerID
	where e.EmployeeID IS NOT NULL)
--Now self join the cte and extract the names.
SELECT a.EmployeeName,b.EmployeeName
FROM cte a
left join cte b
on a.ManagerID=b.EmployeeID