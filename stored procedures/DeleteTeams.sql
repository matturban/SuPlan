USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTeams]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteTeams]
GO

CREATE PROCEDURE [dbo].[DeleteTeams]
@ID int
AS
BEGIN
	delete from Teams where ID = @ID
END
GO
