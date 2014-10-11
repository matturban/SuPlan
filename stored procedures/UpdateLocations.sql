DROP PROCEDURE UpdateLocations
GO

CREATE PROCEDURE UpdateLocations
@ID int,
@Acronym varchar(50),
@BusinessUnit varchar(50),
@MetroID int
AS
BEGIN
	update Locations
	set Acronym = @Acronym
	, BusinessUnit = @BusinessUnit
	, MetroID = @MetroID
	where ID = @ID
END