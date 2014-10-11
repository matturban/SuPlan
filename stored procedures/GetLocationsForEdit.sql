DROP PROCEDURE GetLocationsForEdit
GO

CREATE PROCEDURE GetLocationsForEdit
AS
BEGIN
	select L.ID
	,L.Acronym
	,L.BusinessUnit
	,isnull(M.ID,-1) as MetroID
	,isnull(M.Name,'') as Metro
	from Locations L 
	left outer join Metros M on L.MetroID = M.ID
	order by L.Acronym
END