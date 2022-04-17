USE nguye2aq_dbo
GO

--Create role
CREATE ROLE master_editor_role
GO

CREATE ROLE master_artist_role
GO

--Create user
CREATE USER Editor_in_chief WITHOUT LOGIN
GO

CREATE USER Artist_in_chief WITHOUT LOGIN
GO

--Granting roles to users
EXEC sp_addrolemember @rolename = 'master_editor_role', @membername = 'Editor_in_chief'
GO

EXEC sp_addrolemember @rolename = 'master_artist_role', @membername = 'Artist_in_chief'
GO

--Granting select access to users
GRANT SELECT ON OBJECT::DC_COMICS.artist TO master_editor_role
GRANT SELECT ON OBJECT::DC_COMICS.colorist TO master_editor_role
GRANT SELECT ON OBJECT::DC_COMICS.comic_issue TO master_editor_role
GRANT SELECT ON OBJECT::DC_COMICS.graphic_novel TO master_editor_role
GRANT SELECT ON OBJECT::DC_COMICS.issue_collected_in_novel TO master_editor_role
GRANT SELECT ON OBJECT::DC_COMICS.writer TO master_editor_role

GRANT SELECT ON OBJECT::DC_COMICS.artist TO master_artist_role
GRANT SELECT ON OBJECT::DC_COMICS.colorist TO master_artist_role
