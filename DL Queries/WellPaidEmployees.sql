--https://datalemur.com/questions/sql-well-paid-employees
/*Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees earning more than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.*/

CREATE TABLE employee2 (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    salary INTEGER,
    department_id INTEGER,
    manager_id INTEGER
);

INSERT INTO employee2 (employee_id, name, salary, department_id, manager_id) VALUES
(1, 'Emma Thompson', 3800, 1, 6),
(2, 'Daniel Rodriguez', 2230, 1, 7),
(3, 'Olivia Smith', 7000, 1, 8),
(4, 'Noah Johnson', 6800, 2, 9),
(5, 'Sophia Martinez', 1750, 1, 11),
(6, 'Liam Brown', 13000, 3, NULL),
(7, 'Ava Garcia', 12500, 3, NULL),
(8, 'William Davis', 6800, 2, NULL);

--Calculate the employees receiving more salary than their managers
SELECT e.employee_id,e.name as employee_name
FROM employee2 e 
JOIN employee2 f ON e.manager_id=f.employee_id
WHERE e.salary>f.salary;
