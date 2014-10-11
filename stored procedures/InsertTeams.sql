USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTeams]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertTeams]
GO

CREATE PROCEDURE [dbo].[InsertTeams]
@Name varchar(50),
@TeamCode varchar(20)
AS
BEGIN
	insert into Teams (Name, TeamCode)
	values (@Name, @TeamCode)	
END
GO
