-- TESTING HARNESSES
EXECUTE AS USER = 'Editor_in_chief'
GO

PRINT N'Should work, we grant SELECT access to this editor'
SELECT * FROM DC_COMICS.comic_issue
GO

REVERT
GO

EXECUTE AS USER = 'Artist_in_chief'
GO

PRINT N'Should work'
SELECT * FROM DC_COMICS.artist
GO

--Shouldn't work
PRINT N'Shouldnt work, since we do not grant access for Artist-in-chief for comic_issue table'
SELECT * FROM DC_COMICS.comic_issue
GO

REVERT
GO
