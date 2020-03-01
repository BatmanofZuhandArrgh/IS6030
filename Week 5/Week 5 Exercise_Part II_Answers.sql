/*	
	IS6030 Week 5
	In-Class Exercise 
	PART II. 
*/


/* 1. Common Table Expression (CTE): 

	   Using A CTE as part of your answer, query only those records with the amount of ViolFine less than $100.
	   Use the referencing query to display the average Viol Fine amount by Make. Output the average in 2 decimal places.
*/


WITH SmallViolFine (Make, ViolFine)
AS
-- Define the CTE query.
(
    SELECT Make, ViolFine
    FROM dbo.ParkingCitations
    WHERE ViolFine < 100
)
-- Define the outer query referencing the CTE
SELECT 
	 Make 
--	, COUNT(*) as [NumberOfRecords]
	, CAST(AVG(ViolFine) as DECIMAL(19,2)) as AverageViolFine 
 FROM SmallViolFine
GROUP BY Make 
ORDER BY Make



/* 2.  Dynamic SQL:

		 Write a dynamic statement using the dbo.ParkingCitation table.
		 You'll need to create a variable to store a column name. 
		 The column name will be used in the dynamic statement. 
		 The dynamic code will display all the unique values based on that column name. 
		 Order the column values in descending order.
		 Test your query by choosing one Column name from the dbo.ParkingCitation table 
		 --You do not need to loop through all the columns
*/

SELECT * FROM dbo.ParkingCitations

DECLARE @sql varchar(max) 
DECLARE @ColumnName varchar(100) 
SET @ColumnName = 'Make' 

SET @sql = 'SELECT DISTINCT(' + @ColumnName + ') 
			 FROM dbo.ParkingCitations 
			ORDER BY ' + @ColumnName + ' DESC' 
PRINT @sql
EXEC(@sql)
			


/* 3. WHILE & Variables:

	   Add a new column to the dbo.ParkingCitations table called "TestGroup"
	   Using a WHILE loop to populate the column with Y or N 
	   Y = Every 5th Record in the table based on ParkingCitationID; Otherwise, N

	   FYI this query might take a few minutes to run.
*/



ALTER TABLE dbo.ParkingCitations  
ADD TestGroup char(1) 
GO 

DECLARE @i int --counter 
SET @i = 1
DECLARE @ParkingCitationID int 

WHILE @i <= (SELECT COUNT(*) FROM dbo.ParkingCitations)
BEGIN 

	SELECT @ParkingCitationID = ParkingCitationID 
	FROM dbo.ParkingCitations 
	WHERE ParkingCitationID = @i 

	IF ((@ParkingCitationID%5) = 0) 
		BEGIN
			UPDATE dbo.ParkingCitations 
			SET TestGroup = 'Y'
			WHERE ParkingCitationID = @i
		END
	ELSE 
		BEGIN
			UPDATE dbo.ParkingCitations 
			SET TestGroup = 'N'
			WHERE ParkingCitationID = @i
		END 

	SET @i = @i + 1
END 

SELECT * FROM dbo.ParkingCitations 


--------
alter table uc.dbo.ParkingCitations
alter column ParkingCitationID int

UPDATE dbo.ParkingCitations 
SET TestGroup = 'Y' 
WHERE (ParkingCitationID%5) = 0

UPDATE dbo.ParkingCitations 
SET TestGroup = 'N' 
WHERE TestGroup is null


/* 4. Stored Procedure 
Create a stored procedure using the dbo.ParkingCitations table. 
The stored procedure will take the parameters of 'Tag'.
The SP is going to compare data for the provided Tag to all the tags that have the same Make 
(don’t worry about fixing makes with different names, look at only those records with the exact same make as the provided tag).

Display the following as the output 
For the Tag:
Tag, Make, Average amount of Viol Fine , and Average number of days of Viol Date from Current Date 

For the Make: 
Make, Number of Records of the Make in the entire table, Average amount of Viol Fine,
 Average Number of Days of Viol Date from Current Date

Call the stored procedure dbo.sp_TagCompare, 
include execution examples in the comments and correctly fill out the comment area.

*/


CREATE PROCEDURE dbo.sp_TagCompare 


--Begin Input Parameters 
--None
@Tag varchar(50)
--End Input Parameters
  
AS
BEGIN 
 
	SELECT TagDetails.Tag -- not in question
		, TagDetails.AvgViolFine 
		, TagDetails.AvgFineDays 
		, MakeDetails.Make
		, MakeDetails.NumberOfMakes 
		, MakeDetails.MakeAvgViolFine 
		, MakeDetails.AvgFineDays
	FROM
		(
			SELECT Tag 
				, Make 
				,Avg(ViolFine) as AvgViolFine 
				,AVG(DATEDIFF(Day, ViolDate, getdate())) as AvgFineDays
			FROM dbo.ParkingCitations
			WHERE Tag = '4AE0952'
			GROUP BY Tag, Make
		) TagDetails
	INNER JOIN 
		(
			SELECT Make
				, COUNT(*) as NumberOfMakes
				, AVG(ViolFine) as MakeAvgViolFine 
				, AVG(DATEDIFF(Day, ViolDate, getdate())) as AvgFineDays
			FROM dbo.ParkingCitations
			WHERE Make IN 
				(	SELECT Make 
					FROM dbo.ParkingCitations 
					WHERE Tag = '4AE0952'
				)
			GROUP BY Make
		) MakeDetails 
	ON TagDetails.Make = MakeDetails.Make

END 

GO


--Execution Example(s):  EXEC UC.dbo.sp_TagCompare @Tag = '4AE0952' 
						
