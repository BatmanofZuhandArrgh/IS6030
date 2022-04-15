--3. DML scripts to load the data.

USE nguye2aq_dbo
GO

--4. Test Scripts to unit test the database.
--EXEC tSQLt.NewTestClass 'nguye2aq_dbo_test'
--GO

--5. Queries that show all the data.
SELECT * from DC_COMICS.artist
SELECT * from DC_COMICS.colorist
SELECT * from DC_COMICS.writer
SELECT * from DC_COMICS.comic_issue
SELECT * from DC_COMICS.graphic_novel
SELECT * from DC_COMICS.issue_collected_in_novel

--6. Queries that show all the relations.

