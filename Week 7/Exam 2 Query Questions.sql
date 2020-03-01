/* Exam 2 Query Questions */

/*
24.  Create a new table dbo.WineRating by following these steps:
A. Check if the table exists and drop the table;
B. Create Table: The first column of the table should be WineID which is an auto incrementing integer and is set as the PRIMARY KEY;
C. Insert Data: INSERT your data from the imported table "dbo.ImportWineRating" into the dbo.WineRating table.
*/





/*	   
25. ALTER the WineRating table in the following TWO steps. 
A. Add a column OverallRating to the table. 
B. Populate the OverallRating Column. The OverallRating is the sum of TasteRating and ValueRating.
*/







/*
26. List the name, variety, and overall rating for red wines at Costco in an ascending order of cost.
*/





/*
27. What is the minimum and maximum price for red wines produced in 2013? 
[hint: wine production year is the number embedded WineName.]
*/





/*
28. Which store has the most variety of wine?
*/





/*
29. List the number of wines and the average value rating (rounded up with no decimal places)
 	for each type of wine. Sort your results by average cost in a descending order.
*/





/*
30. Display the unique varieties of red wine that have more than 10 reviews.
*/





/*
31. Using a subquery to display the red wine(s) with the lowest taste rating.
*/





/*
32. Display a one column output by formatting the data into the following format: 
2010 Colomé Torrontés: Type- Red / Torrontés - Price $11.99 - Skip It
Please apply this format to all red wines that have a review of "Skip It".
*/





/*
33. Please do the following steps to normalize the data in the dbo.WineRating table. 
A. Write the syntax to DROP and CREATE three tables in the following order: 
   dbo.Store, dbo.Type, dbo.Variety. 
   The columns in each table are described in the attached relational schema. 
   Please set primary keys as identity columns.

B. Populate data to these three tables from the dbo.WineRating table.
*/





/*
33. 
C. Execute the following syntax to create and populate the dbo.Wine table.
The relationships among the four new tables are described in the attached relational schema. 

SELECT DISTINCT IDENTITY(INT, 1, 1) WineID,
							StoreID,
							VarietyID,
							TypeID, 
                            WineName as Wine,
							Cost, 
							Review, 
							ReviewDate, 
							TasteRating, 
							ValueRating,
							OverallRating
INTO dbo.Wine
FROM dbo.WineRating A
INNER JOIN dbo.Store B ON A.Store = B.Store
INNER JOIN dbo.Variety C on A.Variety = C.Variety
INNER JOIN dbo.Type D on A.Type = D.Type;
*/



/*
34. Using the new tables and JOINs to display all information in the dbo.WineRating table. 
*/





/*   
35. Using the new tables and JOINs to show the name, type and value rating for wines cheaper than $7.
*/





/*
36. Using the new tables and JOINs to answer the following question:
	Display the number of wines, highest and lowest cost, and average overall rating 
	for each type and variety of wines. Sort the output by type and variety in ascending orders.
*/





/*
37. Using the new tables and JOINs to answer the following question:
	List the number of wines and the number of varieties in each store.
*/





/*
38. Using the new tables, JOINs and subqueries to answer the following question:
    List the stores where the average Taste Rating of wines is greater than the average Taste Rating of all wines.
*/





/*
39. Using the dbo.Wine table and CASE to answer the following question:
  	Bucket the Cost of wines into these buckets: 
	Cost < 5.00							"01. Lower than $5" 
	Cost >= 5.00 and Cost <= 9.99		"02. Between $5-$10"
	Cost>= 10.00						"03. Higher than $10"
	Display the average Cost and average Overall Rating for each bucket, order by the Cost bucket.
*/





/*
Bonus Question: 

List your favorite Cincinnati area restaurant and your favorite dish from there. 
Also name your favorite dish that you make or your parents/family makes. 
*/

