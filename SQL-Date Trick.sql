--SQL TRICK TO FIND THE START DATE AND END DATE FOR A TASK 
USE PRACTICE
create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

SELECT * from tasks 
order by date_value

--1st THOUGHT IS GROUP BY THE STATE AND FIND MIN MAX OF DATE_VALUE BUT IT DOES NOT COUNT IN CONTINUOUS INTERVALS
select state,max(date_value) as sd,min(date_value)as ed
from tasks
group by state

--SO first find a date common to continuous asks by subtracting the date from rownumber

select *,row_number() over(partition by state order by date_value) as rn,
		DATEADD(DAY,-1* row_number() over(partition by state order by date_value),date_value) as GD
from tasks
order by date_value

--make this a cte and extract min and max from each group of gd
with cte as (
        select *,row_number() over(partition by state order by date_value) as rn,
		DATEADD(DAY,-1* row_number() over(partition by state order by date_value),date_value) as GD
        from tasks
)
SELECT state,min(date_value) as start_date,max(date_value) as end_date
from cte
group by state,GD