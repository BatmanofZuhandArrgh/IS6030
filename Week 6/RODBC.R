#Check the version
version

#Update if needed
update.packages()


#Install package
install.packages("RODBC")

#Use library
library(RODBC)

#List all your ODBC connections
odbcDataSources(type = c("all", "user", "system"))

#Create connection - Note if you leave uid and pwd blank it works with your existing Windows credentials
Local <- odbcConnect("Example", uid = "", pwd = "")

#Query a database (select statement)
ChicagoSalary <- sqlQuery(Local, "SELECT * FROM UC.dbo.ChicagoSalary")
Films <- sqlQuery(Local, "SELECT * FROM Movies.dbo.tblFilm")
Directors <- sqlQuery(Local, "SELECT * FROM Movies.dbo.tblDirector")


#View data
View (ChicagoSalary)
View (Films)
head(Films,3)

#Check the structure of the data
class(Films)
str(Films)


#Quick summary to describe the data
dim(Films)
summary (Films)  
colnames(Films)

Films [3,]
Films[,"FilmName"]

FilmName<-Films$FilmName
str(FilmName)

#Basic queries
sqlBasic <- sqlQuery(Local, "SELECT 
              	                     FilmName
                                     ,FilmReleaseDate
                                     ,FilmOscarWins
                                     ,FilmOscarNominations
                                     ,FilmOscarWins
                                     ,FilmBudgetDollars
                                     ,FilmBoxOfficeDollars
                               FROM
                                      Movies.dbo.tblFilm
                              ")      


#Group By

sqlGroup<- sqlQuery(Local, "SELECT 
            	                   FilmCountryID
                                 , Year (FilmReleaseDate) as FilmYear
                                 , Count (*) as NumberofFilms
                                 , AVG (FilmRunTimeMinutes) as AvgRunTime
                                 , SUM (FilmRunTimeMinutes) as TotalRunTime
                                 , AVG (FilmRunTimeMinutes) as AverageRunTime
                                 , MAX (FilmRunTimeMinutes) as LongestRunTime
                                 , MIN (FilmRunTimeMinutes) as ShortestRunTime
                             FROM 
                                Movies.dbo.tblFilm
                             GROUP BY 
                                FilmCountryID
                                , Year (FilmReleaseDate)
                             HAVING  Year (FilmReleaseDate)>2000
                             ORDER BY Year (FilmReleaseDate)") 

#Cast/Date

sqlCastNUM <- sqlQuery(Local, "SELECT CAST(FilmBoxOfficeDollars as DECIMAL(19,2)) FROM Movies.dbo.tblFilm")
sqlCastINT <- sqlQuery(Local, "SELECT CAST(FilmBoxOfficeDollars as INT) FROM Movies.dbo.tblFilm")
sqlCastDate <- sqlQuery(Local, "SELECT CAST(FilmReleaseDate as DATE) FROM Movies.dbo.tblFilm")
sqlDate <- sqlQuery(Local, "SELECT getdate()")
sqlDate <- sqlQuery(Local, "SELECT CAST(getdate() as DATE)")

#Some more complex queries

#Temp # Tables


#CREATE: Variable to store the Query
sqlString <- "CREATE TABLE Movies.dbo.#Director (
                      DirectorID int NULL
                      , DirectorName nvarchar (255) NULL
                      , DirectorDOB datetime NULL
                      , DirectorGender nvarchar (255) NULL
                      )"

sqlCreate <- sqlQuery(Local, sqlString)


#INSERT
sqlInsert <- sqlQuery(Local, "INSERT INTO Movies.dbo.#Director (DirectorID, DirectorName, DirectorDOB, DirectorGender)
                     SELECT * FROM Movies.dbo.tblDirector")
Director <- sqlQuery(Local, "SELECT * FROM Movie.dbo.#Director ")

#UPDATE DELETE ALTER
sqlALTER <- sqlQuery(Local, "ALTER TABLE Movie.dbo.#Director ADD MiddleName varchar(20)")
sqlUpdate <- sqlQuery(Local, "UPDATE Movie.dbo.#Director SET MiddleName = 'Unknown'")
sqlSelect <- sqlQuery(Local, "SELECT * FROM Movie.dbo.#Director")

#DROP
sqlQuery <- sqlQuery(Local, "DROP TABLE #Director")

#String Functions
q1 <- sqlQuery(Local, "SELECT ISNUMERIC(DirectorDOB), DirectorDOB FROM Movies.dbo.tblDirector") 
q2 <- sqlQuery(Local, "SELECT ISNUMERIC(DirectorName), DirectorName FROM Movies.dbo.tblDirector") 
q3 <- sqlQuery(Local, "SELECT ISDATE(DirectorDOB), DirectorDOB FROM Movies.dbo.tblDirector") 
q4 <- sqlQuery(Local, "SELECT ISDATE(DirectorName), DirectorName FROM Movies.dbo.tblDirector")

#JOIN
JoinQuery <- sqlQuery(Local, "SELECT * 
                       FROM Movies.dbo.tblFilm f
                       INNER JOIN Movies.dbo.tblDirector d
                       ON f.FilmDirectorID=d.DirectorID
                       ")      

#OVER PARTITION
sqlOver<- sqlQuery(Local, "SELECT
                                	DISTINCT FilmCountryID
                                	, COUNT (FilmCountryID) OVER (PARTITION BY FilmCountryID) AS NumFilmCtry
                           FROM Movies.dbo.tblFilm
                           ORDER BY FilmCountryID")

#Call a stored procedure

sqlSP <- sqlQuery(Local, "EXEC Movies.dbo.spFilmFilter @MinLength=120, @MaxLength=180, @Title='star'")


#Dynamic SQL
sqlDynamic <- sqlQuery(Local, " DECLARE @TableName NVARCHAR (150)
                                DECLARE @SQLString NVARCHAR (MAX)
                       
                               SET @TableName=N'tblFilm'
                               SET @SQLString = N'SELECT * FROM Movies.dbo.' + @TableName
                               EXEC sp_executesql @SQLString")

sqlDynamic2 <- sqlQuery(Local, " EXEC sp_executesql 
                                    N'SELECT FilmName, FilmReleaseDate, FilmRunTimeMinutes
                                      FROM Movies.dbo.tblFilm
                                      WHERE FilmRunTimeMinutes > @Length
                                      AND FilmReleaseDate >@Date
                                      ORDER BY FilmRunTimeMinutes'
                                  , N'@Length INT, @Date DATETIME' 
                                  , @Length = 150     
                                  , @Date='2004-01-01' ")


#Common table expression
sqlCTE <- sqlQuery(Local,"WITH EarlyFilms AS (
                        SELECT 
                            FilmName
                            ,FilmReleaseDate
                            ,FilmRunTimeMinutes
                        FROM Movies.dbo.tblFilm
                        WHERE FilmReleaseDate < '2000-01-01'
                       )
                      SELECT *
                      FROM EarlyFilms
                      WHERE FilmRunTimeMinutes>150")



#Best practice - don't leave the connection open and ensures you get the latest data
odbcCloseAll()
