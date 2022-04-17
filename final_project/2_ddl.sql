USE master;
GO

-- Drop database
IF DB_ID(N'nguye2aq_dbo') IS NOT NULL DROP DATABASE nguye2aq_dbo;

-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR(N'Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE nguye2aq_dbo
GO

USE nguye2aq_dbo
GO

-- Create schema DC Comics
CREATE SCHEMA DC_COMICS AUTHORIZATION dbo
GO

-- Create Tables
CREATE TABLE DC_COMICS.writer
(
  writer_id           INT    	   NOT NULL IDENTITY PRIMARY KEY,
  writer_name         NVARCHAR(50) NOT NULL,
  writer_DOB          DATE         NOT NULL
);

CREATE TABLE DC_COMICS.colorist
(
  colorist_id           INT    	   NOT NULL IDENTITY PRIMARY KEY,
  colorist_name         NVARCHAR(50) NOT NULL,
  colorist_DOB          DATE         NOT NULL,
);

CREATE TABLE DC_COMICS.artist
(
  artist_id           INT    	   NOT NULL IDENTITY PRIMARY KEY,
  artist_name         NVARCHAR(50) NOT NULL,
  artist_DOB          DATE         NOT NULL,
);

CREATE TABLE DC_COMICS.comic_issue
(
  issue_id            INT    	   NOT NULL IDENTITY PRIMARY KEY,
  issue_title         NVARCHAR(50) NOT NULL,
  issue_release_date  DATE         NOT NULL,
  issue_number        INT          NOT NULL,
    
  artist_id int FOREIGN KEY REFERENCES DC_COMICS.artist(artist_id),
  writer_id int FOREIGN KEY REFERENCES DC_COMICS.writer(writer_id),
  colorist_id int FOREIGN KEY REFERENCES DC_COMICS.colorist(colorist_id)
);

CREATE TABLE DC_COMICS.graphic_novel
(
  graphic_novel_id    INT    	     NOT NULL IDENTITY PRIMARY KEY,
  novel_title         NVARCHAR(50) NOT NULL,
  novel_release_date  DATE         NOT NULL,
  paperback_release   BIT          ,
  hardback_release    BIT          ,
    );

CREATE TABLE DC_COMICS.issue_collected_in_novel
(
  issue_collected_in_novel_id  INT NOT NULL IDENTITY PRIMARY KEY,

  issue_id int FOREIGN KEY REFERENCES DC_COMICS.comic_issue(issue_id),
  graphic_novel_id int FOREIGN KEY REFERENCES DC_COMICS.graphic_novel(graphic_novel_id),
);
---------------------------------------------------------------------
-- Populate Tables
---------------------------------------------------------------------

SET NOCOUNT ON;

SET IDENTITY_INSERT  DC_COMICS.writer ON;
INSERT INTO  DC_COMICS.writer(writer_id, writer_name, writer_DOB)
  VALUES(1, 'Scott Snyder', '1975-01-01');
INSERT INTO  DC_COMICS.writer(writer_id, writer_name, writer_DOB)
  VALUES(2, 'Grant Morrison', '1975-01-02');
INSERT INTO  DC_COMICS.writer(writer_id, writer_name, writer_DOB)
  VALUES(3, 'Geoff Johns', '1975-01-04');
INSERT INTO  DC_COMICS.writer(writer_id, writer_name, writer_DOB)
  VALUES(4, 'Mark Millar', '1975-01-03');
INSERT INTO  DC_COMICS.writer(writer_id, writer_name, writer_DOB)
  VALUES(5, 'Josh Williamson', '1975-01-07');
SET IDENTITY_INSERT  DC_COMICS.writer OFF;


SET IDENTITY_INSERT  DC_COMICS.artist ON;
INSERT INTO  DC_COMICS.artist(artist_id, artist_name, artist_DOB)
  VALUES(1, 'Jim Lee', '1973-01-01');
INSERT INTO  DC_COMICS.artist(artist_id, artist_name, artist_DOB)
  VALUES(2, 'Bruce Timm', '1972-01-04');
INSERT INTO  DC_COMICS.artist(artist_id, artist_name, artist_DOB)
  VALUES(3, 'Alex Ross', '1971-02-04');
INSERT INTO  DC_COMICS.artist(artist_id, artist_name, artist_DOB)
  VALUES(4, 'Adam Hughes', '1945-01-03');
INSERT INTO  DC_COMICS.artist(artist_id, artist_name, artist_DOB)
  VALUES(5, 'Glen Orbik', '1985-01-07');
SET IDENTITY_INSERT  DC_COMICS.artist OFF;

SET IDENTITY_INSERT DC_COMICS.colorist ON;
INSERT INTO  DC_COMICS.colorist(colorist_id, colorist_name, colorist_DOB)
  VALUES(1, 'Alex Sinclair', '1953-01-01');
INSERT INTO  DC_COMICS.colorist(colorist_id, colorist_name, colorist_DOB)
  VALUES(2, 'Dave Stewart', '1978-01-04');
INSERT INTO  DC_COMICS.colorist(colorist_id, colorist_name, colorist_DOB)
  VALUES(3, 'Adrienne Roy', '1971-02-04');
INSERT INTO  DC_COMICS.colorist(colorist_id, colorist_name, colorist_DOB)
  VALUES(4, 'Abe Foreu', '1944-01-23');
INSERT INTO  DC_COMICS.colorist(colorist_id, colorist_name, colorist_DOB)
  VALUES(5, 'Adam Kubert', '1976-01-17');
SET IDENTITY_INSERT DC_COMICS.colorist OFF;

SET IDENTITY_INSERT DC_COMICS.comic_issue ON;
INSERT INTO  DC_COMICS.comic_issue(issue_id,writer_id, colorist_id, artist_id, issue_title, issue_number, issue_release_date)
  VALUES(1, 3, 2, 2, 'Peepland', 22, '2022-04-13');
INSERT INTO  DC_COMICS.comic_issue(issue_id,writer_id, colorist_id, artist_id, issue_title, issue_number, issue_release_date)
  VALUES(2, 3, 1, 3, 'Animal Man', 24, '2022-04-13');
INSERT INTO DC_COMICS.comic_issue(issue_id,writer_id, colorist_id, artist_id, issue_title, issue_number, issue_release_date)
  VALUES(3, 2, 1, 1, 'Batman', 6, '2022-04-13');
INSERT INTO DC_COMICS.comic_issue(issue_id,writer_id, colorist_id, artist_id, issue_title, issue_number, issue_release_date)
  VALUES(4, 4, 5, 5, 'Kill or be killed', 4, '2022-04-13');
INSERT INTO DC_COMICS.comic_issue(issue_id,writer_id, colorist_id, artist_id, issue_title, issue_number, issue_release_date)
  VALUES(5, 2, 4, 4, 'Live, die, repeat!', 64, '2022-04-13');
SET IDENTITY_INSERT  DC_COMICS.comic_issue OFF;

SET IDENTITY_INSERT DC_COMICS.graphic_novel ON;
INSERT INTO  DC_COMICS.graphic_novel(graphic_novel_id, novel_title, novel_release_date, paperback_release, hardback_release)
  VALUES(1, 'Peepland Omnibus', '2022-04-13', 1, 0);
INSERT INTO  DC_COMICS.graphic_novel(graphic_novel_id, novel_title, novel_release_date, paperback_release, hardback_release)
  VALUES(2, 'Animal Man Volume 2', '2022-04-13', 1, 1);
INSERT INTO  DC_COMICS.graphic_novel(graphic_novel_id, novel_title, novel_release_date, paperback_release, hardback_release)
  VALUES(3, 'Batman: Night of Monster Men', '2022-04-13', 0, 0);
INSERT INTO  DC_COMICS.graphic_novel(graphic_novel_id, novel_title, novel_release_date, paperback_release, hardback_release)
  VALUES(4, 'Kill or be killed: Ultimate Edition', '2022-04-13', 0, 1);
INSERT INTO  DC_COMICS.graphic_novel(graphic_novel_id, novel_title, novel_release_date, paperback_release, hardback_release)
  VALUES(5, 'Live, die, repeat! Platinum collection', '2022-04-13', 1, 1);
SET IDENTITY_INSERT DC_COMICS.graphic_novel OFF;


SET IDENTITY_INSERT  DC_COMICS.issue_collected_in_novel ON;
INSERT INTO  DC_COMICS.issue_collected_in_novel(issue_collected_in_novel_id, issue_id, graphic_novel_id)
  VALUES(1, 1, 2);
INSERT INTO  DC_COMICS.issue_collected_in_novel(issue_collected_in_novel_id, issue_id, graphic_novel_id)
  VALUES(2, 2, 2);
INSERT INTO  DC_COMICS.issue_collected_in_novel(issue_collected_in_novel_id, issue_id, graphic_novel_id)
  VALUES(3, 3, 5);
INSERT INTO  DC_COMICS.issue_collected_in_novel(issue_collected_in_novel_id, issue_id, graphic_novel_id)
  VALUES(4, 5, 4);
INSERT INTO  DC_COMICS.issue_collected_in_novel(issue_collected_in_novel_id, issue_id, graphic_novel_id)
  VALUES(5, 3, 3);
SET IDENTITY_INSERT DC_COMICS.graphic_novel OFF;




