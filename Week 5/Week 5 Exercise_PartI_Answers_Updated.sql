8
/*	IS6030 Week 5 
	In Class Exercise
	PART I.
*/

USE Week5Exercise


/*1. List student id, student names, and majors. Order your output by student names (First Name A->Z).

*/

SELECT s.SName, m.Major
FROM Student s
	INNER JOIN Major m
	ON s.MID = m.MID
ORDER BY s.SName;

/*2. List  student names, the day they went to that restaurant, the restaurant they went to, and
the rating they gave to their restaurant. Order it by student name (ASC) and rating (DESC).

*/

SELECT  s.SName, d.DinnerDay, r.RName, d.Rating
FROM Student s
	
	INNER JOIN Dinner d
	ON s.SID=d.SID
	
	INNER JOIN Restaurant r
	ON	r.RID=d.RID

ORDER BY s.SName, d.Rating DESC;

/*3. List the major and the number of student enrolled in each major 
     in a descending order of the number of students in each major.
*/

SELECT m.Major, COUNT (s.SName) AS NumStu
FROM Student s
	INNER JOIN Major m
	ON s.MID = m.MID
GROUP BY m.Major
ORDER BY COUNT(s.SName) DESC;


/*4. List the names of restaurant where nobody eats.*/
SELECT RName 
FROM Restaurant
WHERE RID NOT IN 
	(SELECT DISTINCT RID 
	 FROM Dinner);

--OR
SELECT RName 
FROM Restaurant r
LEFT OUTER JOIN Dinner d
ON r.RID = d.RID
WHERE d.RID IS NULL ;

/*5. List the restaurant whose distance to Lindner Hall is less than 2 miles and average cost per visit is lower than 15
 with the lowest average cost restaurant at the top.*/
SELECT r.RName
		, AVG(d.Cost) AS AvgCost
FROM Restaurant r
	INNER JOIN Dinner d
	ON r.RID = d.RID
WHERE LCBDistance < 2
GROUP BY r.RName
HAVING AVG(d.Cost)<15
ORDER BY AVG(d.Cost);

--OR
SELECT *
FROM
(
	SELECT DISTINCT r.RName
			, LCBDistance
			, AVG(d.Cost) OVER (PARTITION BY r.RName) AS AvgCost
	FROM Restaurant r
		INNER JOIN Dinner d
		ON r.RID = d.RID
	WHERE LCBDistance < 2
) AS aggr
WHERE aggr.AvgCost<15
ORDER BY AvgCost; 


/*6. List the restaurant according to their popularity (i.e., most visited restaurant showing at the top)*/
SELECT r.RName, COUNT(d.RID) AS NumVisits
FROM Restaurant r
	INNER JOIN Dinner d
	ON r.RID=d.RID
GROUP BY r.RName
ORDER BY COUNT(d.RID) DESC;


/*7. List the student according to the total amount of money they spent eating out. */
SELECT s.SName, SUM(d.Cost) as SumCost
FROM Student s
	INNER JOIN Dinner d
	ON s.SID=d.SID
GROUP BY s.SID, s.SName
ORDER BY SUM(d.Cost) DESC;



/*8. List the major that spend more than average amount of money (across all major) on dinner.*/

SELECT m.Major, AVG(d.Cost) as MoneySpent
FROM Major m
	INNER JOIN Student s
	ON m.MID=s.MID
	INNER JOIN Dinner d
	ON s.SID=d.SID 
GROUP BY m.Major         --List the major according to the average money spent on dinner
HAVING AVG(d.Cost) > 
		(
		 SELECT AVG(Cost) 
		 FROM Dinner
		 )
ORDER BY MoneySpent DESC;



/*9. List the student who spend more money on dinner on Saturday than they do on Friday.*/
SELECT  s.SName, d1.Cost as SaturdayCost, d2.Cost as FridayCost
FROM Student s
	INNER JOIN Dinner d1
	ON s.SID=d1.SID 
	INNER JOIN Dinner d2
	ON s.SID=d2.SID
WHERE 
      d1.DinnerDay='Saturday' AND
      d2.DinnerDay='Friday' AND
      d1.Cost>d2.Cost;
	  

--OR

SELECT  s.SName, SAT.Cost as SaturdayCost, FRI.Cost as FridayCost
FROM 
	(
	Select d.SID, d.Cost 
	FROM Dinner d
	WHERE d.DinnerDay= 'Saturday'
	) SAT

	INNER JOIN 
	(
	Select d.SID, d.Cost 
	FROM Dinner d
	WHERE d.DinnerDay= 'Friday'
	)FRI
	ON SAT.SID=FRI.SID

	INNER JOIN Student s
	ON s.SID=SAT.SID

WHERE SAT.Cost>FRI.Cost;
	  
/*10. Write a query to show the name and the rating of the highest rated restaurant.*/
SELECT r.RName, AVG (CAST (d.Rating AS DECIMAL (3,2))) AS AvgRating
FROM Restaurant r
	INNER JOIN Dinner d
	ON r.RID=d.RID
GROUP BY r.RName
HAVING AVG(CAST (d.Rating AS DECIMAL (3,2)))>= ALL  
	(	SELECT AVG(CAST (Rating AS DECIMAL (3,2))) 
		FROM Dinner 
		GROUP BY RID
	)
ORDER BY AvgRating DESC;
