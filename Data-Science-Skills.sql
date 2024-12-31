
/*Data Science Skills
LinkedIn SQL Interview Question

Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

Assumption:

There are no duplicates in the candidates table
--https://datalemur.com/questions/matching-skills*/

CREATE TABLE candidates (
    candidate_id INTEGER,
    skill VARCHAR(255)
);

-- Insert example data into the candidates table
INSERT INTO candidates (candidate_id, skill) VALUES
(123, 'Python'),
(123, 'Tableau'),
(123, 'PostgreSQL'),
(234, 'R'),
(234, 'PowerBI'),
(234, 'SQL Server'),
(345, 'Python'),
(345, 'Tableau');



SELECT * from candidates;

--Here is the query

--STEP ONE: FIND THE SKILL POSSESSED BY EACH CANDIDATE

SELECT candidate_id --select candidate id
FROM candidates --from candidates
WHERE skill IN ('Python','PostgreSQL','Tableau') --IN clause for comparing multiple things
GROUP BY candidate_id --now we have the records with skills .we have to group them 
having count(skill)=3 --add conditon to get the count of all the 3 skills
order by candidate_id --order by candidate id
--STEP TWO NOW TAKE THE DATA AND CHECK FOR ALL THE SKILLS FOR THAT CANDIDATE

