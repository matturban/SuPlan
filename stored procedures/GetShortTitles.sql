DROP PROCEDURE GetShortTitles
GO

CREATE PROCEDURE GetShortTitles
AS
BEGIN
	select distinct ShortTitle
	from JobTitles
	where Include = 1
	order by ShortTitle
END