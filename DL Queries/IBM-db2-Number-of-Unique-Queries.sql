--https://datalemur.com/questions/sql-ibm-db2-product-analytics
/*IBM db2 Product Analytics
BM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.
*/

-- Create the 'queries' table
CREATE TABLE queries (
    employee_id INT,
    query_id INT PRIMARY KEY,
    query_starttime DATETIME,
    execution_time INT
);

-- Insert data into the 'queries' table
INSERT INTO queries (employee_id, query_id, query_starttime, execution_time) VALUES 
(226, 856987, '2023-07-01 01:04:43', 2698),
(132, 286115, '2023-07-01 03:25:12', 2705),
(221, 33683, '2023-07-01 04:34:38', 91),
(240, 17745, '2023-07-01 14:33:47', 2093),
(110, 413477, '2023-07-02 10:55:14', 470);

-- Create the 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    full_name NVARCHAR(100),
    gender NVARCHAR(10)
);

-- Insert data into the 'employees' table
INSERT INTO employees (employee_id, full_name, gender) VALUES 
(1, 'Judas Beardon', 'Male'),
(2, 'Lainey Franciotti', 'Female'),
(3, 'Ashbey Strahan', 'Male');

--INSERT MANY VALUES INTO THIS TABLE AND TRY PLEASE
INSERT INTO queries (employee_id, query_id, query_starttime, execution_time) VALUES 
(1, 85687, '2023-07-01 01:04:43', 2698),
(3, 28615, '2023-07-01 03:25:12', 2705),
(2, 3383, '2023-07-01 04:34:38', 91),
(2, 1745, '2023-07-01 14:33:47', 2093),
(1, 41347, '2023-07-02 10:55:14', 470);

INSERT INTO employees (employee_id, full_name, gender) VALUES 
(4, 'Judd', 'Male'),
(5, 'Sandeep', 'Female'),
(6, 'Ashray', 'Male');


--CALCULATE THE NUMBER OF UNIQUE QUERIES BY EACH EMPLOYEE DURING THE THIRD QUARTER.IF THE EMP HAS NO QUERIES THEN WE DISPLAY 0
WITH ASS AS(
		SELECT e.employee_id as e,
		COALESCE(COUNT(DISTINCT q.query_id),0) as unique_queries--sets the count to 0 when the null is encountered
		FROM employees e 
		LEFT JOIN queries q 
		ON e.employee_id=q.employee_id
		AND query_starttime >= '2023-07-01T00:00:00Z'
		AND query_starttime<'2023-10-01T00:00:00Z'
		GROUP BY e.employee_id
		)
SELECT unique_queries ,
       count(e) as employee_count
FROM ASS 
GROUP BY unique_queries --group by the number of queries
ORDER BY unique_queries;--order by the number of queries



