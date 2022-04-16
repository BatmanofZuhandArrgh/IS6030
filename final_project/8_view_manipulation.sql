USE nguye2aq_dbo
GO

-- Update view
ALTER VIEW HARDBACK_NOVELS_RELEASED_2022_04_13 AS
SELECT novel_title, graphic_novel_id, novel_release_date
FROM DC_COMICS.graphic_novel
WHERE paperback_release = 1 and hardback_release = 1
GO

-- Show view of novel 
SELECT *
FROM HARDBACK_NOVELS_RELEASED_2022_04_13