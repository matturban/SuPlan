DROP PROCEDURE GetMetros
GO

CREATE PROCEDURE GetMetros
AS
BEGIN
	select ID as MetroID
	, Name
	from Metros
	order by Name
END