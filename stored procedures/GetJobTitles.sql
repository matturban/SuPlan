DROP PROCEDURE GetJobTitles
GO

CREATE PROCEDURE GetJobTitles
AS
BEGIN
	select ID as TitleID
	, Title
	, ShortTitle
	from JobTitles
	where Include = 1
	order by Title
END