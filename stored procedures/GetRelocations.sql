DROP PROCEDURE GetRelocations
GO

CREATE PROCEDURE GetRelocations
@TMID int
AS
BEGIN
	select M.ID as MetroID
	, M.Name as MetroName
	, L.ID as LocationID
	, L.Acronym as LocationName
	, CAST(CASE WHEN R.TMID IS NULL THEN 0 ELSE 1 END AS BIT)  AS LocationChecked
	from Metros M 
	inner join Locations L on M.ID = L.MetroID
	left outer join TMRelocate R on L.ID = R.ToLocationID AND R.TMID = @TMID
	order by M.Name, L.Acronym
END

--exec GetRelocations 2