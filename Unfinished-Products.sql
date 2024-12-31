--https://datalemur.com/questions/tesla-unfinished-parts
/*Unfinished Parts
Tesla SQL Interview Question

Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.

Assumptions:

parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
An unfinished part is one that lacks a finish_date.
This question is straightforward, so let's approach it with simplicity in both thinking and solution.

Effective April 11th 2023, the problem statement and assumptions were updated to enhance clarity.*/

-- Create the parts_assembly table
CREATE TABLE parts_assembly (
    part VARCHAR(255),
    finish_date DATETIME,
    assembly_step INTEGER
);

-- Insert example data into the parts_assembly table
INSERT INTO parts_assembly (part, finish_date, assembly_step) VALUES
('battery', '2022-01-22 00:00:00', 1),
('battery', '2022-02-22 00:00:00', 2),
('battery', '2022-03-22 00:00:00', 3),
('bumper', '2022-01-22 00:00:00', 1),
('bumper', '2022-02-22 00:00:00', 2),
('bumper', NULL, 3),
('bumper', NULL, 4);

SELECT * from parts_assembly;
--STRAIGHTFORWARD QUESTION
SELECT part,assembly_step
FROM parts_assembly
WHERE finish_date IS NULL

