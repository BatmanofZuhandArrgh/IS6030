--3. DML scripts to load the data.
USE nguye2aq_dbo
GO

--5. Queries that show all the data.
SELECT * from DC_COMICS.artist
SELECT * from DC_COMICS.colorist
SELECT * from DC_COMICS.writer
SELECT * from DC_COMICS.comic_issue
SELECT * from DC_COMICS.graphic_novel
SELECT * from DC_COMICS.issue_collected_in_novel

--6. Queries that show all the relations.
PRINT N'The table comic_issue connects to other job position tables, many-to-1 through its position_id'
SELECT i.issue_id, i.issue_title, a.artist_name, w.writer_name, c.colorist_name
FROM 
		DC_COMICS.comic_issue i 
	INNER JOIN
		DC_COMICS.artist a ON i.artist_id = a.artist_id --connect to DC_COMICS.artist by foreign key artist_id
	INNER JOIN
		DC_COMICS.colorist c ON i.colorist_id = c.colorist_id --connect to DC_COMICS.colorist by foreign key  colorist_id
	INNER JOIN	
		DC_COMICS.writer w ON i.writer_id = w.writer_id --connect to DC_COMICS.writer by foreign key writer_id

PRINT N'The table comic_issue connects to table graphic_novel, many to many, so to satisfy 3NF an intermediate table issues_collected_in_novels was created'
SELECT i.issue_title, i.issue_number, n.novel_title
FROM 
		DC_COMICS.comic_issue i 
	INNER JOIN
		DC_COMICS.issue_collected_in_novel icn ON i.issue_id = icn.issue_id --DC_COMICS.comic_issue connects to DC_COMICS.Issue_connected_in_novel by foreign key issue_id
	INNER JOIN
		DC_COMICS.graphic_novel n ON n.graphic_novel_id = icn.graphic_novel_id----DC_COMICS.graphic_novel connects to DC_COMICS.Issue_connected_in_novel by foreign key graphic_novel_id



