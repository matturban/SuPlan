USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateJobTitles]
GO

CREATE PROCEDURE [dbo].[UpdateJobTitles]
@ID int,
@Title varchar(50),
@JobCode varchar(20),
@JobFamily varchar(50),
@Category varchar(20),
@ShortTitle varchar(5),
@Include bit 
AS
BEGIN
	update JobTitles
	set Title = @Title
	,JobCode = @JobCode
	,JobFamily = @JobFamily
	,Category = @Category
	,ShortTitle = @ShortTitle
	,Include = @Include
	where ID = @ID
END
GO
