/*	
	IS6030 Homework 4a 
*/


/*--------------------------------------------------------------------------------------
Instructions:

You will be using the StudentDinner database we created in class to answer the following questions.

Please download the StudentDinner.sql and execute the file to create the StudentDinner database
if you have not done so in class.

Answer each question as best as possible.  
Show your work if you need to take multiple steps to answer a problem. 
Partial answers will count.
--------------------------------------------------------------------------------------*/
use Week5Exercise001

create proc showDinner
as
begin
select *
from dbo.Dinner
end

create proc showMajor
as
begin
select *
from dbo.Major
end

create proc showRestaurant
as
begin
select * 
from dbo.Restaurant
end

create proc showStudent
as
begin
select *
from dbo.Student
end


execute showStudent

/*Q1. (0.5 point)
	List the restaurant according to their average ratings, from the highest to the lowest.*/
/* Q1. Query */
execute showDinner
execute showRestaurant

select R.RName, AVG(Rating) as AverageRating   --RName, AVG(D.Rating) as AverageRating
from dbo.Restaurant as R
Full outer join dbo.Dinner as D
on R.RID = D.RID
group by R.RName
order by AverageRating DESC


/*Q2. (0.5 point)
	List the names of student who eat out every single day of the week.*/
/* Q2. Query */

execute showStudent
execute showDinner

with Sunday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where DinnerDay = 'Sunday'),
Monday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Monday'
group by S.SName
),
Tuesday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Tuesday'
group by S.SName
),
Wednesday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Wednesday'
group by S.SName
),
 Thursday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Thursday'
group by S.SName
),
Friday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Friday'
group by S.SName
),
Saturday as(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where D.DinnerDay = 'Saturday'
group by S.SName
)
select *
from Sunday as S
inner join Monday as M
on S.SName = M.SName
inner join Tuesday as T
on S.SName = T.SName
inner join Wednesday as W
on S.SName = W.SName
inner join Thursday as Th
on S.SName = Th.SName
inner join Friday as F
on S.SName = F.SName
inner join Saturday as Sa
on S.SName = Sa.SName



/*
select S.SName, D.DinnerDay
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
where S.SName in
(
select S.SName
from dbo.Student as S
Full outer join dbo.Dinner as D
on S.SID = D.SID
group by S.SName
having count(DinnerDay) >= 7
)
order by S.SName
--=> We found that Robert and Allison eat out everyday of the week
*/
/*Q3. (1 point)
	List the restaurant whose total earning is greater than $100 and does not have a phone number, with the highest earning restaurant at the top.*/
/* Q3. Query */

execute showDinner
execute showRestaurant

select R.RName, sum(Cost) as TotalEarnings   
from dbo.Restaurant as R
Full outer join dbo.Dinner as D
on R.RID = D.RID
where R.Phone is null
group by R.RName
having sum(Cost)>100
order by sum(Cost) DESC



/*Q4. (1 point)
	List the student according to the total distance they travel for dinner.*/
/* Q4. Query */
execute showDinner
execute showRestaurant
execute showStudent

select S.SName, sum(LCBDistance) as TotalDistance
from dbo.Dinner as D
Full outer join dbo.Student as S
on S.SID = D.SID
Full outer join dbo.Restaurant as R
on R.RID = D.RID
group by S.SName
--having count(DinnerDay) >= 7



/*Q5. (1 point)
	List the names of student who do not like to eat out on Thursdays.*/
/* Q5. Query */
execute showDinner
execute showRestaurant
execute showStudent


select S.SName as PeoplewhohateThursday
from dbo.Dinner as D
Full outer join dbo.Student as S
on S.SID = D.SID
Full outer join dbo.Restaurant as R
on R.RID = D.RID
where S.SName not in
(
select S.SName
from dbo.Dinner as D
Full outer join dbo.Student as S
on S.SID = D.SID
Full outer join dbo.Restaurant as R
on R.RID = D.RID
where D.DinnerDay = 'Thursday'
)
group by S.SName

/*Q6. (1 point)
	For each major, list the total amount of money students spent on dinner 
	and their number of visits to restaurants 
	during the weekends (Saturdays and Sundays).*/	
/* Q6. Query */

select M.Major, sum(Cost) as TotalSpending, count(M.Major) as NumberofVisits
from dbo.Dinner as D
Full outer join dbo.Student as S
on S.SID = D.SID
Full outer join dbo.Restaurant as R
on R.RID = D.RID
Full outer join dbo.Major as M
on S.MID = M.MID
where M.Major is not Null
group by M.Major