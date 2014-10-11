USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertImportChecks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertImportChecks]
GO

CREATE PROCEDURE [dbo].[InsertImportChecks]
@CheckDescription varchar(50)
, @CheckSQL varchar(max)
AS
BEGIN
	insert into ImportChecks (CheckDescription, CheckSQL)
	values(@CheckDescription, @CheckSQL)
END
GO
