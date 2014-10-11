DROP PROCEDURE InsertLocations
GO

CREATE PROCEDURE InsertLocations
@Acronym varchar(50),
@BusinessUnit varchar(50),
@MetroID int
AS
BEGIN
	insert into Locations (Acronym, BusinessUnit, MetroID)
	values(@Acronym, @BusinessUnit, @MetroID)
END