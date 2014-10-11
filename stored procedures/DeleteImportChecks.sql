USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteImportChecks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteImportChecks]
GO

CREATE PROCEDURE [dbo].[DeleteImportChecks]
@ID int
AS
BEGIN
	delete from ImportChecks where ID = @ID
END
GO
