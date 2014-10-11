DROP PROCEDURE GetEducationLevels
GO

CREATE PROCEDURE GetEducationLevels
AS
BEGIN
	select ID as LevelID
	, [Level]
	from EducationLevels
END