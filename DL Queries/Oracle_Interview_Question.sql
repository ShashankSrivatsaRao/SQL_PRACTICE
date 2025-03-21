--Query asked at Oracle Interview 

TRUNCATE TABLE Oracle
CREATE TABLE Oracle (
	AccNo VARCHAR(10) NOT NULL ,
	TranDate DATE ,
	TType CHAR CHECK (TType in ('D','C')),
	Amt INT ) 

INSERT INTO Oracle 
VALUES('A123','2025-03-11','D',1000),
	  ('A123','2025-03-11','C',5000),
	  ('A123','2025-05-11','D',3000),
	  ('A123','2025-06-11','C',9000),
	  ('A123','2025-06-11','D',8000)


SELECT * FROM Oracle 

--Now get me the sum of debit and credit of this account in one query?

SELECT 
	SUM(CASE WHEN TType = 'C' THEN Amt END ) as Total_Credit ,
	SUM(CASE WHEN TType = 'D' THEN Amt END ) as Total_Dedit 
FROM Oracle 

--Now Get me the total amount of Credit and Debit in each date , let it be zero if no transactions .

SELECT 
	TranDate ,
	SUM(CASE WHEN TType = 'C' THEN Amt ELSE 0 END ) as Total_Credit ,
	SUM(CASE WHEN TType = 'D' THEN Amt ELSE 0 END ) as Total_Dedit 
FROM Oracle 
GROUP BY TranDate