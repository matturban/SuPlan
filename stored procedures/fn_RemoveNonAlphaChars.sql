USE [SuPlan1]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_RemoveNonAlphaChars]    Script Date: 04/29/2014 12:45:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_RemoveNonAlphaChars]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_RemoveNonAlphaChars]
GO

USE [SuPlan1]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_RemoveNonAlphaChars]    Script Date: 04/29/2014 12:45:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_RemoveNonAlphaChars]
(
@string VARCHAR(8000)
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @IncorrectCharLoc SMALLINT
	SET @IncorrectCharLoc = PATINDEX('%[^0-9]%', @string)
	WHILE @IncorrectCharLoc > 0
		BEGIN
		SET @string = STUFF(@string, @IncorrectCharLoc, 1, '')
		SET @IncorrectCharLoc = PATINDEX('%[^a-zA-Z ,]%', @string)
	END
	SET @string = @string
	RETURN @string
END

GO


