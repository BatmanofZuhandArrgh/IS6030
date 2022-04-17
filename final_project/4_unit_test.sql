-- I'm not sure what to test, so I test the views.
-- Please run this after file 7,8
EXEC tSQLt.NewTestClass 'testDC_COMICS'
GO

CREATE PROCEDURE testDC_COMICS.TestViewExtractHardbackReleaseDate
AS
BEGIN
	IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	--FAKE table;
	--EXEC tSQLt.FakeTable 'DC_COMICS', 'ReleaseDate'
	--INSERT INTO DC_COMICS.ReleaseDate (novel_release_date)
		--VALUES('2022-04-13')

	--INSERT INTO DC_COMICS.ReleaseDate (novel_release_date)
		--VALUES('2022-04-13')
	
	SELECT novel_release_date
	INTO actual
	FROM dbo.HARDBACK_NOVELS_RELEASED_2022_04_13

	CREATE TABLE expected(novel_release_date DATE)
	INSERT INTO expected (novel_release_date) SELECT '2022-04-13'
	INSERT INTO expected (novel_release_date) SELECT '2022-04-13'

	EXEC tSQLt.AssertEqualsTable 'expected', 'actual', 'Date extracted was correct for both entries'
END;
GO

EXEC tSQLt.Run 'testDC_COMICS.TestViewExtractHardbackReleaseDate'
