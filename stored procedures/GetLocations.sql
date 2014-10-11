DROP PROCEDURE GetLocationsForEdit
GO

CREATE PROCEDURE GetLocationsForEdit
AS
BEGIN
	select ID
	,Acronym
	,BusinessUnit
	,MetroID
	from Locations
	order by Acronym
END