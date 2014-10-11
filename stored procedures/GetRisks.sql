DROP PROCEDURE GetRisks
GO

CREATE PROCEDURE GetRisks
AS
BEGIN
	select ID as RiskID
	, Risk
	from Risks
END