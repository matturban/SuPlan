USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertMetros]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertMetros]
GO

CREATE PROCEDURE [dbo].[InsertMetros]
@Name varchar(50)
AS
BEGIN
	insert into Metros (Name) values(@Name)
END
GO


