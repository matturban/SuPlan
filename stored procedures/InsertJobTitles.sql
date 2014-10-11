IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertJobTitles]
GO

CREATE PROCEDURE [dbo].[InsertJobTitles]
@Title varchar(50),
@JobCode varchar(20),
@JobFamily varchar(50),
@Category varchar(20),
@ShortTitle varchar(5),
@Include bit 
AS
BEGIN
	insert into JobTitles (Title, JobCode, JobFamily, Category, ShortTitle, Include)
	values (@Title, @JobCode, @JobFamily, @Category, @ShortTitle, @Include)
END
GO
