RETURN;

--Homework #3a Querying Multiple Tables
--Your Name: Anh Nguyen

/*--------------------------------------------------------------------------------------
Instructions:

If you haven't done so in class, please download and run the entire syntax in the MovieDatabase.sql file to establish a Movies database.
Answer the following questions as best as possible.
Show your work if you need to take multiple steps to answer a problem. 
Partial answers will count.
--------------------------------------------------------------------------------------*/
USE Movies

select *
from dbo.tblFilm
/*Q1. (0.5 point)
List Film Name, Director Name, Studio Name, and Country Name of all films.*/

/*Q1. Syntax*/
--Show INNER JOIN of three tables
SELECT
	FilmName
	,DirectorName
	,StudioName
	,CountryName
FROM
	tblFilm AS f
	INNER JOIN tblDirector AS d
	ON f.FilmDirectorID=d.DirectorID
	INNER JOIN tblStudio as s
	on f.FilmStudioID = s.StudioID
	INNER JOIN tblCountry as c
	on f.FilmCountryID = c.CountryID

/*Q2. (0.5 point)
List people who have been actors but not directors.*/

/*Q2. Syntax*/


SELECT ActorName
FROM
tblActor AS a
LEFT OUTER JOIN tblDirector AS d
ON a.ActorName=d.DirectorName
where d.DirectorName is null


/*Q3. (1 point)
List actors that have never been directors and directors that have never been actors.*/

/*Q3. Syntax*/

SELECT ActorName, DirectorName
FROM
tblActor AS a
FULL OUTER JOIN tblDirector AS d
ON a.ActorName=d.DirectorName
where d.DirectorName is null or a.ActorName is null



/*Q4. (1 point)
List all films that are released in the same year when the film Casino is released.*/

/*Q4. Syntax*/


Select FilmName
from tblFilm
where YEAR(FilmReleaseDate) = 
	(select YEAR(FilmReleaseDate)
	from tblFilm
	WHERE FilmName ='Casino')


/*Q5. (0.5 point)
Using JOIN to list films whose directors were born between '1946-01-01' AND '1946-12-31'. */

/*Q5. Syntax*/

select FilmName
from 
tblDirector as d
inner join tblFilm as f
on d.DirectorID = f.FilmDirectorID
where d.DirectorDOB >= '1946-01-01' and d.DirectorDOB <= '1946-12-31'

/*Q6. (0.5 point)
Using subquery to list films whose directors were born between '1946-01-01' AND '1946-12-31'. */

/*Q6. Syntax*/


select FilmName
from tblFilm 
where FilmDirectorID in 
	(select DirectorID
	from tblDirector
	where DirectorDOB >= '1946-01-01' and DirectorDOB <= '1946-12-31')

