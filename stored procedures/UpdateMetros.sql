USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMetros]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateMetros]
GO

CREATE PROCEDURE [dbo].[UpdateMetros]
@ID int,
@Name varchar(50)
AS
BEGIN
	update Metros set Name = @Name where ID = @ID
END
GO


