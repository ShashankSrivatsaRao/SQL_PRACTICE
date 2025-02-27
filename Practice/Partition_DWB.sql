SELECT TOP (1000) [CurrencyRateID]
      ,[CurrencyRateDate]
      ,[FromCurrencyCode]
      ,[ToCurrencyCode]
      ,[AverageRate]
      ,[EndOfDayRate]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[CurrencyRate]
--Partition function - Divide the table into parts based ona column 
--Order date in my case .

--Define a partion boundry last day of the month ( Boundry of our functions)
-- All rows within May in P1 , June P2, July P3 , Augest P4

--bOUNDRY BELONGS TO LEFT 

CREATE PARTITION FUNCTION PartitionByMonth (DATE)
AS RANGE LEFT FOR VALUES ('2011-05-31','2011-06-30','2011-07-31','2011-08-15')

SELECT * FROM sys.partition_functions

ALTER DATABASE [AdventureWorks2022] ADD FILEGROUP FG_MAY
ALTER DATABASE [AdventureWorks2022] ADD FILEGROUP FG_JUNE
ALTER DATABASE [AdventureWorks2022] ADD FILEGROUP FG_JULY
ALTER DATABASE [AdventureWorks2022] ADD FILEGROUP FG_AUGUST

SELECT * from sys.filegroups where type ='FG'

--create files 
ALTER DATABASE [AdventureWorks2022] ADD FILE 
(
	NAME=P_MAY, 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_MAY.ndf'
) TO FILEGROUP FG_MAY;

ALTER DATABASE [AdventureWorks2022] ADD FILE 
(
	NAME=P_JUNE, 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_JUNE.ndf'
) TO FILEGROUP FG_JUNE;

ALTER DATABASE [AdventureWorks2022] ADD FILE 
(
	NAME=P_JULY, 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_JULY.ndf'
) TO FILEGROUP FG_JULY;

ALTER DATABASE [AdventureWorks2022] ADD FILE 
(
	NAME=P_AUGUST, 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_AUGUST.ndf'
) TO FILEGROUP FG_AUGUST;

--DEFINE THE FUNCTION SCHEME

--DEFINE WHICH PARTITION BELONGS TO WHICH FILE GROUP

CREATE PARTITION SCHEME SchemePartitionByMonth 
AS PARTITION PartitionByMonth 
TO( FG_MAY, FG_JUNE , FG_JULY, FG_AUGUST)