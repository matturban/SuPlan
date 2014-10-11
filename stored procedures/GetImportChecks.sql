USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetImportChecks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetImportChecks]
GO

CREATE PROCEDURE [dbo].[GetImportChecks]
AS
BEGIN
	select ID
	, CheckDescription
	, CheckSQL
	from ImportChecks
END
GO
