DROP PROCEDURE GetJobTitlesForEdit
GO

CREATE PROCEDURE GetJobTitlesForEdit
AS
BEGIN
	select ID
	, Title
	, JobCode
	, JobFamily
	, Category
	, ShortTitle
	, Include
	from JobTitles
	order by Include desc, Title
END
