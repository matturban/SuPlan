USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateTeams]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateTeams]
GO

CREATE PROCEDURE [dbo].[UpdateTeams]
@ID int,
@Name varchar(50),
@TeamCode varchar(20)
AS
BEGIN
	update Teams
	set Name = @Name
	, TeamCode = @TeamCode
	where ID = @ID
END
GO
