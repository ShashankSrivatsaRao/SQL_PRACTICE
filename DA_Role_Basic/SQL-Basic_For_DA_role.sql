--Basic retrival of all the records from the database
--1. Instead of selecting * we must select the specific rows we wantin the output
--2. Also using the top keyword to fetch only the imp rows in the database
SELECT TOP 10 order_id,order_date,profit  FROM [dbo].[orders_data];

--Order of execution : from-> select-> top 10 
--We can sort the data using order by

select  *
from orders_data
order by order_date,profit 

--3.WHEN THERE IS A TIE BETWEEN 2 columns in the select caluse we have to order by the second column 
--If he order_date is same we have to sort by order_date first and then in case of tie we sort the two tied dates in terms of profit
/*select  *
from orders_data
order by order_date desc ,profit  desc */

--4.When we want the top 5 sales : order is from -> select *-> order by -> top 5 
SELECT TOP 5 *
FROM orders_data
order by sales desc

--5.When we want the profit percentage in the report but not the table we can add new column 
SELECT  *, profit/sales as profit_ratio--sales-profit as diff
from orders_data
ORDER BY profit_ratio

--we can conclude that the order by executes after the select statement

--Bunch of where clauses : we can use and ,or ,not & >,<,<=,>=,<>,!= ,IN, IS(for null) ,LIKE for wildcards

SELECT  *
FROM orders_data
--WHERE order_date between  '2020-01-01' and '2021-01-01'
--WHERE sales>300
--WHERE quantity in (4,5,6)
--WHERE profit IS NOT NULL
--WHERE (sales >100 and quantity>4) and not profit < 0
WHERE customer_name LIKE '_[aeiou]%s%'

--Basic Aggregate functions using distinct

SELECT count(distinct customer_name) as dc,
		sum(sales) as tot,
		avg(profit) as pro,
		count('aa') as act,
		sum(sales)/count('aa') as der,
		max(sales) as maxi,
		min(quantity) as mini
from orders_data


--GROUPING BY
select category,region,sum(sales) as tot,sum(profit) as topp
from orders_data
group by category,region
having sum(sales) > 1500

--second query: get the city wise sales in west region
--ORDER: FROM-> WHERE->GROUP BY-> HAVING-> SELECT
select city,sum(sales) as city_sales 
from orders_data
where region = 'West'
GROUP BY city
HAVING sum(sales) > 1000
ORDER BY city_sales desc

select * from orders_data
select * from returns_data

--Now we have to get the orders which were returned

select o.*,r.return_reason 
from orders_data o
left join returns_data r
on o.order_id=r.order_id
where r.return_reason is not null

--CASE STATEMENTS
select *,
	  (case when profit<0 then 'loss' else 'profit' end) as result
from orders_data

--more bucket
select *,
	  (case when profit<0 then 'loss' 
		when profit <50 then 'low profit' 
		when profit <100 then 'high profit'
		else 'very high profit' end) as result
from orders_data


--TOP TO BOTTOM EXECUTTION
select *,
	  (case when profit<0 then 'loss' 
		when profit between 1 and 50 then 'low profit' 
		when profit between 51 and 100 then 'high profit'
		else 'very high profit' end) as result
from orders_data


--String functions

select *,len(customer_name) as l,left(city,3) as L,right(order_id,6) as id
from orders_data

select *,replace(city,'L','Z') D
from orders_data


--date :get sales during years ,quarters datepart for numerical data

select DATEPART(YEAR,order_date) as year_data, DATEPART(MONTH,order_date) as month_data,sum(sales) as tot
from orders_data
group by  DATEPART(YEAR,order_date),DATEPART(MONTH,order_date)

--datename for theoritical data

select DATENAME(YEAR,order_date) as year_data,
		DATENAME(MONTH,order_date) as month_data,
		sum(sales) as tot
from orders_data
group by  DATENAME(YEAR,order_date),
		 DATENAME(MONTH,order_date)

--DATE ADD AND DATE DIFF FUNCTION

select order_id,datediff(day,order_date,ship_date) as dd
from orders_data
where datediff(day,order_date,ship_date) <=2

select order_id,datediff(day,order_date,ship_date) as dd,
		dateadd(day,2,ship_date) as estimated_delivary
from orders_data
where datediff(day,order_date,ship_date) <=2