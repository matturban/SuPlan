USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateImportChecks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateImportChecks]
GO

CREATE PROCEDURE [dbo].[UpdateImportChecks]
@ID int
, @CheckDescription varchar(50)
, @CheckSQL varchar(max)
AS
BEGIN
	update ImportChecks
	set CheckDescription = @CheckDescription
	, CheckSQL = @CheckSQL
	where ID = @ID
END
GO
