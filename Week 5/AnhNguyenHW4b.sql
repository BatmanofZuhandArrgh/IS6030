/*	
	IS6030 Homework 4b 
*/


/*--------------------------------------------------------------------------------------
Instructions:

You will be using the Baltimore Parking Citations data set (14,705 rows)
(this is only a snapshot of all citations for Baltimore).

The name of your table should be called dbo.ParkingCitations.

Answer each question as best as possible.  
Show your work if you need to take multiple steps to answer a problem. 
Partial answers will count.
--------------------------------------------------------------------------------------*/

/* 
	You can run this query to check your table, if it does not run or you do not get 14,705 rows,
    you should revisit your import/table.  Before you do anything, make sure your data/table is correct!
	
	Reminder: Please check which database you imported data into and which database you are working with.
*/

	SELECT *
	FROM dbo.ParkingCitations; 

/* Q1. (1 point)
		Show the number of Citations, Total Fine amount, by Make and Violation Date. 
        Sort your results in a descending order of Violation Date and in an ascending order of Make.
		Hint: Check the data type for ViolDate and see whether any transformation is needed.
*/

/* Q1. Query */
	SELECT *
	FROM dbo.ParkingCitations; 

	select Make,  day(ViolDate) as Dateoftheviolation, count(Citation) as NumberofCitation, sum(ViolFine) as TotalFineAmount
	from dbo.ParkingCitations
	group by Make, day(ViolDate)
	order by Make ASC, day(ViolDate)  DESC 



/* Q2. (0.5 point)
	Display just the State (2 character abbreviation) that has the most number of violations.

*/

/* Q2. Query */

with MaximumNumberofViolations as(
select top 1 state, count(citation) as NumberofViolations
from dbo.ParkingCitations
group by state
order by count(citation) DESC
)

select State
from MaximumNumberofViolations


/* Q3. (1 point)
	   Display the number of violations and the tag, for any tag that is registered at Maryland (MD) and has 6 or more violations. 
	   Order your results in a descending order of number of violations.
*/

/* Q3. Query */
	SELECT *
	FROM dbo.ParkingCitations; 

	Select tag, count(Citation) as NumberofCitation
	from dbo.ParkingCitations
	where state = 'MD'
	group by Tag
	having count(Citation)>=6
	order by count(Citation) DESC

/* Q4. (0.5 point)
	Generate a one column output by formatting the data into this format 
	(I'll use the first record as an example of the format, you'll need to apply this to all records with State of MD):	
			15TLR401 - Citation: 98348840 - OTH - Violation Fine: $502.00 
*/

/* Q4. Query */
SELECT *
FROM dbo.ParkingCitations; 

DECLARE @Counter INT
DECLARE @NumberofViolations INT
DECLARE @Tag Varchar(15)
DECLARE @Citation Varchar(Max)
DECLARE @Make Varchar(6)
DECLARE @ViolFine Varchar(10)

SET @COUNTER = 1
SET @NumberofViolations = (select count(ParkingCitationID) from dbo.ParkingCitations)

WHILE @Counter <= @NumberofViolations
	BEGIN
		SET @Tag = (Select Tag from dbo.ParkingCitations where State = 'MD' and ParkingCitationID = @Counter)
		SET @Citation = (Select Citation from dbo.ParkingCitations where State = 'MD'and ParkingCitationID = @Counter)
		SET @Make = (Select Make from dbo.ParkingCitations where State = 'MD'and ParkingCitationID = @Counter)
		SET @ViolFine = (Select ViolFine from dbo.ParkingCitations where State = 'MD'and ParkingCitationID = @Counter)
						
		Print @Tag + ' - Citation: ' + @Citation + ' - ' + @Make + ' - Violation Fine: ' + @ViolFine
		--from dbo.ParkingCitations
		
		SET @COUNTER=@COUNTER+1
	END

/* Q5. (0.5 point)
	   Write a query to calculate which states MAX ViolFine differ more than 200 from MIN VioFine 
	   Display the State Name and the Difference.  Sort your output by State A->Z.
*/

/* Q5. Query */

Select State, (Max(ViolFine) - Min(ViolFine)) as DifferenceinFines
from dbo.ParkingCitations
group by state
having (Max(ViolFine) - Min(ViolFine)) > 200
order by State ASC

/* Q6. (1 point)
	   You will need to bucket the entire ParkingCitations database into three segments by ViolFine. 
	   Your first segment will include records with ViolFine between $0.00 and $50.00 and will be labled as "01. $0.00 - $50.00".
	   The second segment will include records with ViolFine between $50.01 and $100.00 and will be labled as "02. $50.01 - $100.00".
	   The final segment will include records with ViolFine larger than $100.00 and will be labled as"03. larger than $100.00". 

	   Display Citation, Make, VioCode, VioDate, VioFine, and the Segment information in an descending order of ViolDate. 	    
*/ 

/* Q6. Query */
SELECT *
FROM dbo.ParkingCitations; 

SELECT
	Citation, Make,ViolCode, ViolDate, ViolFine,
	 CASE 
		WHEN ViolFine<=50 THEN '01. $0.00 - $50.00'
		WHEN ViolFine<=100 THEN '02. $50.01 - $100.00'
		ELSE '03. larger than $100.00'
	  END AS Segment
FROM
	dbo.ParkingCitations
	order by ViolDate DESC
--WHERE CASE 
	--	WHEN ViolFine<=50 THEN '01. $0.00 - $50.00'
		--WHEN ViolFine<=100 THEN '02. $50.01 - $100.00'
--		ELSE '03. larger than $100.00'
	--  END ='Short';




/* Q7. (0.5 point)
	   Based on the three segments you created in Q6, display the AVG ViolFine and number of records for each segment. 
	   Order your output by the lowest -> highest segments.   
*/ 

/* Q7. Query */
WITH SEGMENTS AS(
SELECT
	Citation, Make,ViolCode, ViolDate, ViolFine,
	 CASE 
		WHEN ViolFine<=50 THEN '01. $0.00 - $50.00'
		WHEN ViolFine<=100 THEN '02. $50.01 - $100.00'
		ELSE '03. larger than $100.00'
	  END AS Segment
FROM
	dbo.ParkingCitations)

Select Segment, AVG(ViolFine) as AverageFines, count(Citation) as NumberofRecords
from SEGMENTS
group by Segment
Order by Segment ASC

	






/* Q8. Bonus Question (0.1 point):
	   You may share any challenge(s) you face while finishing the assignment and how you overcome the challenge.
*/

/* Q8. Answer */