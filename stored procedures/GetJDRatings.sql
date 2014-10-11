DROP PROCEDURE GetJDRatings
GO

CREATE PROCEDURE GetJDRatings
AS
BEGIN
	select ID as RatingID
	, Rating
	, RatingValue
	from JDRatings
	order by RatingValue
END