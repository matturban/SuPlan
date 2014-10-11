IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteNextJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteNextJobTitles]
GO

CREATE PROCEDURE [dbo].[DeleteNextJobTitles]
@ID int
AS
BEGIN
	delete from NextJobTitles where ID = @ID
END
GO
