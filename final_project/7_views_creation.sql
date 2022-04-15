USE nguye2aq_dbo
GO

CREATE VIEW HARDBACK_NOVELS_RELEASED_2022_04_13 AS
SELECT novel_title, graphic_novel_id, paperback_release
FROM DC_COMICS.graphic_novel
WHERE novel_release_date = '2022-04-13' and hardback_release = 1