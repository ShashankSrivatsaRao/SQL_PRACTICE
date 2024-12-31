
--List All the tables in database
select name from sys.tables;




--1.INSERT DUPLICATE RECORDS INTO THE TABLE

INSERT INTO student(student_id,name,age,gender,grade) values ( 14,'Nora',21,'F','B'),(15,'Chandana',19,'F','A-');


--2.Insert all the original student records into a new table

select * into backup_table
from student 
where 
student_id not in
(select s.student_id
from student s
join student e on s.name=e.name and s.age=e.age
where s.student_id > e.student_id and s.enrollment_date >e.enrollment_date)

--3.Now Check whether the records are present in the table

select * from backup_table order by student_id;

--4.Drop the BackUp Table
drop table if exists backup_table;

--5.Using Window Functions to push original data into backup_table

select  x.student_id,x.name,x.age,x.gender,x.grade,x.enrollment_date into backup_table
from (	select *,
		row_number() over(partition by name,age order by student_id asc ) as rn 
        from student) as x
where x.rn=1;


--Stored procedure is a peace of sql code that can be written and stored and  used many times.
--It can take in arguments like function and provide output

CREATE PROCEDURE DEEP 
AS
select * from sales
go;

exec DEEP;

--Stored Procedure with the arguments

CREATE PROCEDURE DEE @id int,@quantity int
AS
BEGIN
SELECT *
FROM sales
WHERE store_id=@id and quantity=@quantity
END


--Inorder to call the procedure we use EXECUTE OR exec

EXECUTE DEE  3 ,2

--We can Delete a procedure using the following statement
DROP PROCEDURE IF EXISTS DEE

--We can backup an existing database to the disk using BackUp database

BACKUP DATABASE [sql-tut] 
TO DISK = 'C:\backups\database_backup\sql-tutbackup.bak'



/*IN ALTER TABLE WE CAN ADD ,delete or rename a column*/
-- TO add a column 
alter table dt add  a int;
--To drop : 
alter table DT drop column a
--to rename a column we use the stored procedure sp_rename 'table.col','col2','COLUMN'

EXEC sp_rename 'DT.DOB',  'EDATE', 'COLUMN';
EXEC sp_rename 'DT.DayOFReg',  'CD', 'COLUMN';

--To Rename a table we use we can again use the sp_rename

EXEC sp_rename 'DATEEXAMPLE','DT';

--INTRODUCTION TO CONSTRAINTS -We can easily create a CONSTRAINT with a name while creating a Table
--IMPROVES THE READABILITY OF THE TABLE AND HELPS USE REMOVE ADD OR ALTER A CONTRAINT EASILY WITHOUT ALTERING THE ROWS
CREATE TABLE BRIKS(
	ID INT ,
	SUDEEP VARCHAR , 
	CONSTRAINT HUUMM PRIMARY KEY(ID,SUDEEP))
	
--ADD A CONSTRAINT
ALTER TABLE BRIKS
ADD DARSHAN VARCHAR UNIQUE

SELECT * from BRIKS

--DROP A CONSTRAINT
ALTER TABLE BRIKS
DROP CONSTRAINT UQ__BRIKS__DB029BE07CE7E9A4;

--DROP COLUMN
ALTER TABLE BRIKS
DROP COLUMN DARSHAN

--INDEXES-HELP TO RETRIVE DATA QUICKLY FROM A LARGE DATASET.2 TYPES CLUSTERED AND NON-CLUSTERED
--COMMANDS TO CREATE AND DROP AN INDEX IN THE TABLE TEACHERS USING ON KEYWORD.
--WHEN WE USE INDEXES E HAVE INCREASE IN THE WRITING,UPDATION TIME AS WE HAVE TO UPDATE THE INDEXES ALSO


--WE CAN CREATE INDEX USING THE FOLLOWING
CREATE INDEX teach_ind
ON teachers(teacher_id,email);

--to drop this index we can use multiple methods
DROP INDEX teach_ind ON teachers;

--OR 

DROP INDEX teachers.teach_ind


--AUTO_INCREMENT IS USED TO ADD A UNIQE VALUE TO THE TABLE WHEN A NEW RECORD IS INSERTED AUTOMATICALLY.
--IT IS GENERALLY USED FOR THE PRIMARY KEY FIELD AS THE VALUES SHOULD BE UNIQUE EVRYTIME A NEW RECORD IS ADDED 
--MYSQL AUTO_INCREMENT CONSTRAINT IS USED TO DEFINE THE AUTO_INCREMENT
--BUT IN MS SQL SERVER THE IDENTITY KEYWORD IS USED TO GIVE AUTOINCREMENT
--IDENTITY(1,1) -MEANS THE RECORDS START FROM 1 AND 1 IS INCREMENTED EVERYTIME
--(2,5) MEANS THE RECORDS STARTS FROM 2 AND 5 IS INCREMENTED EVERYTIME SOMETHING IS ADDED.

CREATE TABLE AI_EX(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	F_NAME VARCHAR(255) NOT NULL,
	DOB DATE );

INSERT INTO AI_EX(F_NAME,DOB)
VALUES ('SURABHI S','2003-02-19'),('SRUJAN R','2003-01-30')


SELECT * FROM AI_EX;

--VIEWS IN THE DATABASE:VIRTUAL TABLE WHCIH CAN REFER TO MORE THAN ONE TABLE AND IT APPEARS TO BE A SINGLE TABLE

CREATE VIEW LS AS
SELECT * 
FROM AI_EX
WHERE DATEDIFF(YEAR,DOB,GETDATE())=21

SELECT * FROM LS;

--TO UPDATE A VIEW WE HAVE TO USE ALTER VIEW LS AS 
ALTER VIEW LS AS
SELECT * 
FROM AI_EX
WHERE DATEDIFF(YEAR,DOB,GETDATE())=21

SELECT * FROM LS;

--NOW IF WENT TO DELETE A VIEW WE DO DROP VIEW
DROP VIEW LS

--NOW LETS CHECK WHAT HAPPENS WHEN WE UPDATE THE TABLE ,WILL IT BE REFLECTED IN THE VIEW OR NOT.

ALTER VIEW LS AS
SELECT * FROM AI_EX 
WHERE ID>2;

SELECT * FROM LS;

--SO WE CAN SEE THAT THE VIEW IS UPDATED WHEN THE TABLES ARE UPDATES 

--TO UPDATE THE TABLE FROM THE UNDERLYING VIEW WE HAVE TO FOLLOW SOME CONDITIONS
--1>NO GROUP BY,UNIQUE,DISTINCT,JOINS OR ANYTHING ON THE TABLES
--2> THE VIEW SHOULD HAVE A SINGLE TTABLE REFERENCE AND WE CAN CHANGE THE DATABSE TABLES IN THE COLUMNS PRESENT IN THE VIEWS

UPDATE LS
SET F_NAME='DARSHAN S'
WHERE ID=11;

SELECT * FROM LS;

--THE BASE TABLE AI_EX HAS TO BE CHANGED

SELECT * FROM  AI_EX;

INSERT INTO AI_EX VALUES ('VAITHY','1971-03-24')

STRING FUNCTIONS
/*String Functions:
ASCII - SELECT ASCII('A') -ASCII CODE  OF THE CHARACTER 'A' 
CHAR-SELECT CHAR(65) -CHAR EQUIVALENT OF THE INTEGER
CHARINDEX - (FIRST)INDEX OF A CHARACTER IN A STRING SELECT CHARINDEX('A','SHASHANK')
CONCAT-ADD 2 OR MORE STRINGS SELECT  SELECT CONCAT ('SHASHANK ',ID,' ',DOB) FROM AI_EX
Concat with + - USING + INSTEAD OF CONCAT SELECT 'SHASHANK' + ' '+ F_NAME + ' ' FROM AI_EX AS E --HERE THE DATATYPE OF ALL THE ELEMENTS HAVE TO BE SAME
CONCAT_WS ADDS STRINGS WITH SEPERATOR SELECT CONCAT_WS('-','ADDED ',ID,' ',DOB) FROM AI_EX
DATALENGTH - RETURNS THE LENGTH OF THE DATA SELECT DATALENGTH(12.23 ) AS S
DIFFERENCE - COMPARES TWO STRINGS AND RETURN 4 IF SIMILAR OR 0 IF NOT SIMILAR SELECT DIFFERENCE('ASDER','ASSURS') AS SIMILARITY
FORMAT-IT HELPS IN FORMATTING THE STRING 
LEFT-SELECT LEFT('ASSDER',2)
LEN-SELECT LEN('QWERTHFGRT')
LOWER -SELECT LOWER('ASERTYUGUT')
LTRIM -SELECT LTRIM( '   KJU')
NCHAR-SELECT NCHAR (67) IT RETURNS THE UNICODE EQUIVALENT CHARACTER OF THE  STRING
PATINDEX -RETURNS THE INDEX OF A PATTERN FROM THE STRING SELECT PATINDEX('___%h%','shashank')
QUOTENAMEThe QUOTENAME() function returns a Unicode string with delimiters added to make the string a valid SQL Server delimited identifier.
select quotename('asdff') select quotename('asdff','()')
REPLACE select replace('adddvf','d','h')
REPLICATE select replicate('shashank ',4)
REVERSE select reverse('sshashank')
RIGHT select right('shashank',3)
RTRIM select rtrim('shashank   ')
SOUNDEX select soundex('shashank'),soundex('sanajana')
SPACE add spaces 
STR convert the arg to string select str(67.542,4,1)
STUFF-the STUFF() function deletes a part of a string and then inserts another part into the string, starting at a specified position.
select stuff('shashank',2,5,'sder')
SUBSTRING select substring('shashank',1,3)
TRANSLATE The TRANSLATE() function returns the string from the first argument after the characters specified in the second argument are translated into the characters specified in the third argument.
select translate('shashank','sha','bom')
TRIM
UNICODE -Used to return the unicode equivalent of the first character of the string  select unicode('shasankk')

Numeric Functions:
ABS- select abs(-233)
ACOS arc cosine
ASIN arc sine
ATAN arc tan
ATN2 arc tan of 2 numbers
AVG avg of all the numbers
CEILING higher round of value select ceiling(-3.2212332312)
COUNT returns count of something
COS returns cosine of something
COT returns cotangent of something
DEGREES returns degree val of radians
EXP return e to power of that val select exp(3.2)
FLOOR returns lesser round off value
LOG select log(2)
LOG10 select log10(2)
MAX 
MIN
PI select pi()
POWER select power(4,3)
RADIANS return radians val of degrees select radians(180)
RAND returns random value between 0 and 1 select rand()  select rand(3)
ROUND rounds off the decimal to the required number of decimals
SIGN returns the sign of the number select sign(-1000)
SIN 
SQRT returns square root select sqrt(49)
SQUARE returns the square of a number select square(30)
SUM reurns the sum of values in a column select sum(30+40)
TAN

select current_user

iif iif(condition,expr if true,expr if false)
select *,iif(gender='M','male','female') from student

select session_user
select system_user
select user_name()*/
