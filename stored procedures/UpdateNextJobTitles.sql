IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateNextJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateNextJobTitles]
GO

CREATE PROCEDURE [dbo].[UpdateNextJobTitles]
@ID int,
@ShortTitle varchar(50)

AS
BEGIN
	update NextJobTitles
	set ShortTitle = @ShortTitle
	where ID = @ID
END
GO
