USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBackFill]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteBackFill]
GO


CREATE PROCEDURE [dbo].[DeleteBackFill] 
@ID int

AS

BEGIN

	DELETE FROM BackFill where ID = @ID
	
END