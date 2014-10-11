IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertNextJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertNextJobTitles]
GO

CREATE PROCEDURE [dbo].[InsertNextJobTitles]
@ShortTitle varchar(50)

AS
BEGIN
	insert into NextJobTitles (ShortTitle)
	values (@ShortTitle)
END
GO
