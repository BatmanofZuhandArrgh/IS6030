 /* IS6030 Week 5 Advanced Query 

 	Demo Part II.
 
 */

 USE Movies


/*----------1. Variable----------*/

/*a. Why need a variable?*/
SELECT 
		ActorName AS Name
		,ActorDOB AS DOB
		,'Actor' AS Role
FROM	tblActor
WHERE	ActorDOB >= '1975-09-01'

UNION ALL

SELECT 
		DirectorName
		,DirectorDOB
		,'Director'
FROM	tblDirector
WHERE	DirectorDOB >= '1975-09-01'

--What if I want to change the date I am using? 

DECLARE @MyDate DATE --step1
SET @MyDate='1975-01-08' --step2

--Very simple if you want to modify the date

SELECT 	ActorName AS Name
		,ActorDOB AS DOB
		,'Actor' AS Role
FROM	tblActor
WHERE	ActorDOB >= @MyDate  --step 3

UNION ALL

SELECT 	DirectorName
		,DirectorDOB
		,'Director'
FROM	tblDirector
WHERE	DirectorDOB >= @MyDate  --step 3


/*b. Three Steps Approach */ 
--Step 1: DECLARE a variable.
DECLARE @MyDate DATE 
DECLARE @NumFilms INT

--Step 2: SET a value to the variable. 
SET @MyDate='1970-01-01'
SET @NumFilms = (	SELECT Count (*) 
					FROM tblFilm 
					WHERE FilmReleaseDate >= @MyDate
				)
--You can also combine DECLARE and SET by writing: DECLARE @MyDate DATE ='1970-01-01'
--Step 3: Use the variable in queries 
SELECT Count (*) as NumFilm 
FROM tblFilm 
WHERE FilmReleaseDate >= @MyDate

SELECT @NumFilms
SELECT 'Number of films'+ CAST (@NumFilms AS CHAR(5))

--Tip: Always put DECLARE together, then SET...
--You need to run all code under b together, otherwise the variable will not be recognized.


/*c. Global Variables*/

PRINT @@SERVERNAME
SELECT @@VERSION
SELECT @@ROWCOUNT

SELECT * FROM tblActor
SELECT @@ROWCOUNT


/*----------2A. IF: Test Conditions in SQL----------*/

/*a. IF */
DECLARE @NumFilms INT
SET @NumFilms = (SELECT COUNT (*) FROM tblFilm)

IF @NumFilms > 5 
	Print 'There are more than five films in the database'

/*b. IF ELSE */
DECLARE @NumFilms INT
SET @NumFilms = (SELECT COUNT (*) FROM tblFilm)

IF @NumFilms > 5 
	Print 'There are more than five films in the database'
ELSE
	Print 'There are fewer than five films in the database'

--Be careful if you want to perform more than one actions, need to enclose all actions between BEGIN and END 

DECLARE @NumFilms INT
SET @NumFilms = (SELECT COUNT (*) FROM tblFilm)

IF @NumFilms > 5 
	BEGIN
		Print 'Information:'
		Print 'There are more than five films in the database'
	END
ELSE
	BEGIN
		Print 'Warning:'
		Print 'There are too few films in the database'
	END


/*----------2B. WHILE Loops----------*/

/*a. Basic Syntax*/
DECLARE @Counter INT
SET @COUNTER = 0

WHILE @Counter < = 10
	BEGIN
		Print @Counter
		SET @COUNTER=@COUNTER+1
	END

/*b. SELECT Statements in A Loop*/

--Count the number of films which 
-- have won each number of Oscars 

DECLARE @Counter INT
DECLARE @MaxOscars INT --What is the highset number of Oscar wins of all films 
DECLARE @NumFilms INT

SET @COUNTER = 0
SET @MaxOscars = (SELECT MAX (FilmOscarWins) FROM tblFilm)
SET @NumFilms=1

WHILE @Counter < = @MaxOscars
	BEGIN
		SET @NumFilms=
		(SELECT Count(*) from tblFilm WHERE FilmOscarWins=@Counter)
				
		PRINT CAST (@NumFilms AS VARCHAR (3)) + ' films have won ' 
		+ CAST (@Counter AS VARCHAR (2))+ ' Oscars'
		
		SET @COUNTER=@COUNTER+1
	END

/*c. Endless Loops*/
DECLARE @Counter INT
DECLARE @MaxOscars INT
DECLARE @NumFilms INT

SET @COUNTER = 0
SET @MaxOscars = (SELECT MAX (FilmOscarWins) FROM tblFilm)
SET @NumFilms=1

WHILE @Counter < =@MaxOscars
	BEGIN
		SET @NumFilms=
		(SELECT Count(*) from tblFilm WHERE FilmOscarWins=@Counter)
		
		PRINT CAST (@NumFilms AS VARCHAR (3)) + ' films have won ' 
		+ CAST (@Counter AS VARCHAR (2))+ ' Oscars'
		
	--	SET @COUNTER=@COUNTER+1
	END


/*----------3. Stored Procedure----------*/

/*a. Why do we need SP?*/
SELECT
	FilmName
	,FilmReleaseDate
	,FilmRunTimeMinutes
FROM 
	tblFilm
ORDER BY
	FilmName ASC
	
--What if you need to run this query many times on regular times?

--SP: speed and efficiency; similar as methods/functions in other programming languages.

/*b. Creat a SP*/

GO --begins a new batch

CREATE PROC spFilmList --the CREATE statement must be the first statement in a batch.
AS
BEGIN
	SELECT
		FilmName
		,FilmReleaseDate
		,FilmRunTimeMinutes
	FROM 
		tblFilm
	ORDER BY
		FilmName ASC
END

--good practice: begin and end to block multiple statements

/*c. Execute the SP*/

--Select the SP name and run
--Execute in a new query.

EXECUTE spFilmList

/*d. Change a SP*/
ALTER PROC spFilmList -- Notice the change here
AS
BEGIN
	SELECT
		FilmName
		,FilmReleaseDate
		,FilmRunTimeMinutes
	FROM 
		tblFilm
	ORDER BY
		FilmName DESC
END

/*e. Drop a SP*/
DROP PROC spFilmList


/*f. SP with One Parameter*/

GO

ALTER PROC spFilmFilter (@MinLength AS INT) --Creating Parameters in SP
-- add parameter to the procedures, appear in set of parapheses, immediately after the procedures name; 
-- all paremeter names must begin with a @ symbol;
-- specify what kind of data that parameter will be allowed to contain.
AS
BEGIN 
		SELECT
			FilmName
			,FilmReleaseDate
			,FilmRunTimeMinutes
		FROM 
			tblFilm
		WHERE 
			FilmRunTimeMinutes > @MinLength -- Greater than the value being passed in through this parameter 
											
		ORDER BY
			FilmName DESC
END

EXEC spFilmFilter 100 --Executing SP with Parameters: 



/*g. SP with Multiple Prameters*/
GO

ALTER PROC spFilmFilter 
 (
 	  @MinLength AS INT
	, @MaxLength AS INT
 ) -- formatting is important to make your code readable
 AS
BEGIN 
		SELECT
			FilmName
			,FilmReleaseDate
			,FilmRunTimeMinutes
		FROM 
			tblFilm
		WHERE 
			FilmRunTimeMinutes > @MinLength AND
			FilmRunTimeMinutes < @MaxLength
			
		ORDER BY
			FilmRunTimeMinutes ASC
END

EXEC spFilmFilter 130,180

--better practice is to name the parameter explicitely, readability 
EXEC spFilmFilter  @MaxLength=200, @MinLength=150

/*h. SP with String Parameters*/
GO

ALTER PROC spFilmFilter 
 (
 	  @MinLength AS INT
	, @MaxLength AS INT
	, @Title AS VARCHAR (MAX)
 ) 
 AS
BEGIN 
		SELECT
			FilmName
			,FilmReleaseDate
			,FilmRunTimeMinutes
		FROM 
			tblFilm
		WHERE 
			FilmRunTimeMinutes > @MinLength AND
			FilmRunTimeMinutes < @MaxLength AND
			--FilmName LIKE '%harry%'
			FilmName LIKE '%' + @Title + '%'
		ORDER BY
			FilmRunTimeMinutes ASC
END


EXEC spFilmFilter @MinLength=150, @MaxLength=180, @Title='harry potter'

EXEC spFilmFilter @MaxLength=180, @Title='harry potter' --what's the error message?



/*i. Optional Parameters and Default Values*/

GO

ALTER PROC spFilmFilter 
 (
 	  @MinLength AS INT = 0 -- Give a Default Value
	, @MaxLength AS INT
	, @Title AS VARCHAR (MAX)
 ) 
 AS
BEGIN 
		SELECT
			FilmName
			,FilmReleaseDate
			,FilmRunTimeMinutes
		FROM 
			tblFilm
		WHERE 
			FilmRunTimeMinutes > @MinLength AND
			FilmRunTimeMinutes < @MaxLength AND

			FilmName LIKE '%' + @Title + '%'
		ORDER BY
			FilmRunTimeMinutes ASC
END


EXEC spFilmFilter @MaxLength=180, @Title='star'


/*----------4. Dynamic SQL----------*/

/*a. Two Techniques for Executing Dynamic SQL*/

-- EXECUTE
EXEC ('SELECT * FROM tblFilm')


-- System Stored Procedure
--have to use unicode string
EXEC sp_executesql N'SELECT * FROM tblFilm'


/*b. Building a Dynamic SQL String*/

--Concatenating a dynamic SQL string
DECLARE @TableName NVARCHAR (150)
DECLARE @SQLString NVARCHAR (MAX)

SET @TableName=N'tblDirector'
SET @SQLString = N'SELECT * FROM ' + @TableName
EXEC sp_executesql @SQLString

--Concatenating with numbers
DECLARE @Number INT
DECLARE @SQLString NVARCHAR (MAX)

SET @Number =100
SET @SQLString = N'SELECT TOP ' + CAST (@Number AS NVARCHAR (10)) 
+ N' * FROM tblFilm ORDER BY FilmReleaseDate ' 
EXEC sp_executesql @SQLString

--Advantages of Dynamic SQL: you can easily modify the name of the table or SQL string

/*c. Parameters of sp_executesql*/
EXEC sp_executesql 
	N'SELECT FilmName, FilmReleaseDate, FilmRunTimeMinutes
	FROM tblFilm
	WHERE FilmRunTimeMinutes > @Length
		AND FilmReleaseDate >@Date
	ORDER BY FilmRunTimeMinutes'
	 ,N'@Length INT, @Date DATETIME' --definition of any parameter in my SQL string
	, @Length =20       --set a value for a parameter
	, @Date='2005-03-01' --set a value for a parameter
	
/*d. Using Dynamic SQL to Create Stored Procedures*/
GO 

CREATE PROC spVariableTable
(
	@TableName NVARCHAR (150)
)
AS
BEGIN
	DECLARE @SQLString NVARCHAR (MAX)
	
	SET @SQLString = N'SELECT * FROM ' + @TableName 

	EXEC sp_executesql @SQLString
END

EXEC spVariableTable 'tblFilm' --you can easily change the name of the tables



/*e. The Danger of SQL Injection*/

CREATE TABLE tblTest
(
	ID INT 
)


EXEC spVariableTable 'tblFilm' --Dynamic SQL sit behind the search function of websites, run SP, and return results from the server

EXEC spVariableTable 'tblFilm; DROP TABLE tblTest' --What's the consequence?


/*----------5. Common Table Expression (CTE)----------*/

/*a. What are CTEs?*/
-- CTE creates temporate set of records and you can use immediately in another select statements
SELECT 
	FilmName
	,FilmReleaseDate
	,FilmRunTimeMinutes
FROM tblFilm
WHERE FilmReleaseDate < '2000-01-01'

/*b. Creating a Basic CTE*/
GO

WITH EarlyFilms AS
(
	SELECT 
		FilmName
		,FilmReleaseDate
		,FilmRunTimeMinutes
	FROM tblFilm
	WHERE FilmReleaseDate < '2000-01-01'
)
SELECT *
FROM EarlyFilms
WHERE FilmRunTimeMinutes>150

/*c. Creating Multiple CTEs*/
GO

WITH EarlyFilms AS
(
	SELECT 
		FilmName
		,FilmReleaseDate
		,FilmRunTimeMinutes
	FROM tblFilm
	WHERE FilmReleaseDate < '2000-01-01'
),
RecentFilms AS
(
	SELECT 
		FilmName
		,FilmReleaseDate
		,FilmRunTimeMinutes
	FROM tblFilm
	WHERE FilmReleaseDate >= '2000-01-01'
)

SELECT 
	*
FROM	
	EarlyFilms  e
	INNER JOIN RecentFilms  r
	ON e.FilmName=r.FilmName;

/*----------6. VIEW----------*/
GO

CREATE VIEW dbo.vw_FilmTable
AS
	SELECT FilmName
			,FilmReleaseDate
			,FilmRunTimeMinutes 
	 FROM dbo.tblFilm;
	
SELECT * FROM dbo.vw_FilmTable;