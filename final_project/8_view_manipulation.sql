USE nguye2aq_dbo
GO

-- Update view
ALTER VIEW HARDBACK_NOVELS_RELEASED_2022_04_13 AS
SELECT novel_title
FROM DC_COMICS.graphic_novel
WHERE paperback_release = 0 and hardback_release = 1;