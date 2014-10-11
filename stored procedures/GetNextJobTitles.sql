/****** Object:  StoredProcedure [dbo].[GetNextJobTitles]    Script Date: 04/23/2014 13:00:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNextJobTitles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetNextJobTitles]
GO

/****** Object:  StoredProcedure [dbo].[GetNextJobTitles]    Script Date: 04/23/2014 13:00:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GetNextJobTitles]
as 
BEGIN
	select ID as NextJobID
	, ShortTitle
	from NextJobTitles
END
GO


