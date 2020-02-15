RETURN;
--Homework #3b Querying Multiple Tables
--Your Name:

/*--------------------------------------------------------------------------------------
Instructions:

You will be using the Chicago Salary table but you will following the questions 
to normalize the data in order to provide a table structure to test your JOIN abilities. 

You can use the original summary table to double check any answers.

Answer each question as best as possible.  
Show your work if you need to take multiple steps to answer a problem. 
Partial answers will count.
--------------------------------------------------------------------------------------*/
USE HW3

/* 
Q1. (0.5 point)
	Write the syntax to drop and build a table called dbo.Employee. 
	Create an EmployeeID field (IDENTITY PK), a Name field and a Salary field for the Employee table.
	Populate the Employee table with unique Name and Salary information from the dbo.ChicagoSalary table.
*/


/* Q1. Syntax*/
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL DROP TABLE dbo.Employee;

Create Table dbo.Employee
(EmployeeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
Name VARCHAR (50) NOT NULL,
Salary DECIMAL (19,2) NULL,
);

select *
from dbo.Employee

select *
from dbo.ChicagoSalary

INSERT dbo.Employee (Name, Salary)
select distinct Name, Salary
from dbo.ChicagoSalary

/* Q2. (0.5 point)
	Write the syntax to drop and build a table called dbo.Department.
	Create an DepartmentID field (IDENTITY PK), and a Name field for the Department Table.
	Populate the Department table with unique Department Names.
*/

/* Q2. Syntax */

IF OBJECT_ID('dbo.Department', 'U') IS NOT NULL DROP TABLE dbo.Department;

Create Table dbo.Department
(DeptID INT IDENTITY(1,1) Primary Key NOT NULL,
Name VARCHAR (50) NOT NULL,
);

select *
from dbo.Department

select *
from dbo.ChicagoSalary

INSERT dbo.Department(Name)
select distinct Department
from dbo.ChicagoSalary

/* Q3. (0.5 point)
	Write the syntax to drop and build a table called dbo.Position.
	Create an PositionID field (IDENTITY PK), and a Name field for the Position table.
	Populate the Position table with unique PositionTitles (call the field Title).
*/

/* Q3. Syntax */

IF OBJECT_ID('dbo.Position', 'U') IS NOT NULL DROP TABLE dbo.Department;

Create Table dbo.Position
(PositionID INT IDENTITY(1,1) Primary Key NOT NULL,
Name VARCHAR (50) NOT NULL,
);

select *
from dbo.Position

select *
from dbo.ChicagoSalary

INSERT dbo.Position (Name)
select distinct PositionTitle
from dbo.ChicagoSalary


/* Run the following query to populate a Employment table to help build the relationship between the above three tables. */


IF OBJECT_ID('dbo.Employment','U') IS NOT NULL DROP TABLE dbo.Employment;

SELECT DISTINCT IDENTITY(INT,1,1)  EmploymentID
		, EmployeeID
		, PositionID
		, DeptID
 INTO dbo.Employment
FROM dbo.ChicagoSalary as CS
INNER JOIN dbo.Employee as E on CS.Name = E.Name and CS.Salary = E.Salary 
INNER JOIN dbo.Position as P on P.Name = CS.PositionTitle  
INNER JOIN dbo.Department as D on D.Name = CS.Department;

select *
from dbo.Employment



/* Q4. (0.5 point)
	Display the same output as the dbo.ChicagoSalary table but use the new 4 tables you created.
*/

/* Q4. Syntax*/

SELECT s.Name, s.Salary, p.Name as Position, d.Name as Department
FROM
	dbo.Employment AS e
	FULL OUTER JOIN dbo.Employee AS s
	ON e.EmployeeID = s.EmployeeID
	FULL OUTER JOIN dbo.Position as p
	on p.PositionID = e.PositionID
	FULL OUTER JOIN dbo.Department as d
	on e.DeptID = d.DeptID



/* Q5. (1 point)
	Using the new tables and JOINs to display Number of Employees and Average Salary in the Police department.
*/

/*Q5. Syntax*/

SELECT count(s.Name) as NumberofEmployees, AVG(s.Salary) as AverageSalary
FROM
	dbo.Employment AS e
	FULL OUTER JOIN dbo.Employee AS s
	ON e.EmployeeID = s.EmployeeID
	FULL OUTER JOIN dbo.Position as p
	on p.PositionID = e.PositionID
	FULL OUTER JOIN dbo.Department as d
	on e.DeptID = d.DeptID
Where d.Name = 'Police'

/* Q6. (1 point)
	Using the new tables and JOINs to provide the Number of Employees and Total Salary of Each Department.
	Sort the output by Department A->Z.
*/

/*Q6. Syntax*/


SELECT d.Name as Department, count(s.Name) as NumberofEmployees, sum(s.Salary) as TotalSalary
FROM
	dbo.Employment AS e
	FULL OUTER JOIN dbo.Employee AS s
	ON e.EmployeeID = s.EmployeeID
	FULL OUTER JOIN dbo.Position as p
	on p.PositionID = e.PositionID
	FULL OUTER JOIN dbo.Department as d
	on e.DeptID = d.DeptID
GROUP BY d.Name
order by d.Name ASC




/* Q7. (1 point)
	Using the new table(s) and subqueries to list the name(s) and salary of employee(s) whose last name is Aaron and work for the POLICE department. 
*/ 

/*Q7. Syntax*/

SELECT s.Name, s.Salary
FROM
	dbo.Employment AS e
	FULL OUTER JOIN dbo.Employee AS s
	ON e.EmployeeID = s.EmployeeID
	FULL OUTER JOIN dbo.Position as p
	on p.PositionID = e.PositionID
	FULL OUTER JOIN dbo.Department as d
	on e.DeptID = d.DeptID
where d.Name = 'Police' and s.Name like 'Aaron%'




/*Q7. Answer:
Name= Jeffery M Aaron
Salary= $75,372
*/

 

/* Q8. (1 point)
	Display the name(s) of the people who have the longest name(s) 
*/

/* Q8. Syntax */

select Name
from dbo.Employee
where LEN(Name) = 
(Select max(len(Name))
from dbo.Employee)


/* Q8.Answer: 
They're Michael Anthony C Sams Clemons and Annabella M WR...
*/


					 
/*Q9. (Bonus: 0.1 point)
	You may share any challenge(s) you face while finishing the assignment and how you overcome the challenge.
*/

 /* Q9.Answer: 
 Mostly I got error from SQL not being able to load the excel sheet. I restart the entire VM, and it works
*/
