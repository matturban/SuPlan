IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteJobTitles]
GO

CREATE PROCEDURE [dbo].[DeleteJobTitles]
@ID int
AS
BEGIN
	delete from JobTitles where ID = @ID
END
GO
