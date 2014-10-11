DROP PROCEDURE DeleteLocations
GO

CREATE PROCEDURE DeleteLocations
@ID int
AS
BEGIN
	if not exists (select * from TeamMembers where LocationID = @ID) 
	and not exists (select * from TMRelocate where TOLocationID = @ID)
	BEGIN
		delete from Locations where ID = @ID
	END
END