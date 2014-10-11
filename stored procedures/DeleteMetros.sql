USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteMetros]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteMetros]
GO

CREATE PROCEDURE [dbo].[DeleteMetros]
@ID int
AS
BEGIN
	delete from Metros where ID = @ID
END
GO


