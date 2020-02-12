USE master
go

-- drop database if exists
BEGIN TRY
	DROP Database MidtermTest
END TRY

BEGIN CATCH
	-- database can't exist
END CATCH

-- create new database
CREATE DATABASE MidtermTest
go

Use MidtermTest
--11. Creating the table
IF OBJECT_ID('dbo.Country', 'U') IS NOT NULL DROP TABLE dbo.Country;

CREATE TABLE dbo.Country (Ccode int PRIMARY KEY
						,Cname VARCHAR (20)	
						,Continent CHAR(2)	
						,Language CHAR(2)
						,Population INT
						,Land INT
						,Water INT
);

select * from dbo.Country
--12. Inserting the first row
INSERT INTO dbo.Country VALUES (1,'Afghanistan','AS','fa', 30419928, 652230, NULL);
INSERT INTO dbo.Country VALUES (2,'Albania','EU','sq', 3002859, 27398, 1350);
INSERT INTO dbo.Country VALUES (3,'Algeria','AF','ar', 35406303, 23381741, NULL);


--13. Updating water to 30% of its landsize if water==NULL
UPDATE dbo.Country
set Water = (0.3 * Land)
where Water = NULL


--14.
Select Cname, Continent, Language, Population, Land, Water
from dbo.Country

--15. 
Select Sum(Water) as TotalWaterinAfrica
from dbo.Country
where Continent = 'AF'


--16.
Select AVG(Population) as AveragePopulationofEnglishSpeakingCountries
from dbo.Country
where Language = 'en' and Cname like 'A%' and Cname like '%a'

--17. 
Select COUNT(distinct Language) as NumberofUniqueLanguages
from dbo.Country

--18.
Select Count(Cname) as NumberofCountries, Language
from dbo.Country
group by Language

--19.
Select Continent, CONVERT(real,Population)/(CONVERT(real,Land) + CONVERT(real,Water)) as PopulationDensity
from dbo.Country
order by PopulationDensity DESC

--20
Select (Cname + ' is a country with a population of '+ CONVERT(varchar(20),Population)) as Output
from dbo.Country
