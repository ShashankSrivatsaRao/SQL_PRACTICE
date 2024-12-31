--https://datalemur.com/questions/duplicate-job-listings
/* Duplicate job listings

Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.*/

CREATE TABLE job_listings (
    job_id INT PRIMARY KEY,
    company_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);
ALTER TABLE job_listings
ALTER COLUMN description VARCHAR(MAX);

INSERT INTO job_listings (job_id, company_id, title, description)
VALUES
(248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
(149, 845, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
(945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
(164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
(172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.');

select * from job_listings

--Step 1 :using sub query I determined all the duplicate jobs and companies and counted the companies in the outer query

select count( distinct a.cid) as duplicate_companies
from(
	select company_id as cid,title,description
	from job_listings
	group by company_id,title,description
	having count(*)>1) a