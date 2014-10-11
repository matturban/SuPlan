
/****** Object:  UserDefinedFunction [dbo].[fn_ParseStringList]    Script Date: 04/22/2014 16:09:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_ParseStringList]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_ParseStringList]
GO


CREATE FUNCTION [dbo].[fn_ParseStringList] 
	(@List varchar(max),
     @ListSeparator char(1))
RETURNS @TblList TABLE 
	(Key_Value varchar(max))
AS
BEGIN
    DECLARE @Left varchar(max), @i int, @j int

	if @ListSeparator is null
	 begin
		Select @ListSeparator = '|'
	 end

    SELECT @i = 0
    SELECT @j = PATINDEX('%' + @ListSeparator  + '%', SUBSTRING(@List, @i + 1, LEN(@List) - @i))

    WHILE (@j > 0)
    BEGIN
        SELECT @Left = SUBSTRING(@List, @i + 1, @j - 1)

        INSERT INTO @TblList
        SELECT @Left
        
        SELECT @i = @i + @j

        SELECT @j = PATINDEX('%' + @ListSeparator  + '%', SUBSTRING(@List, @i + 1, LEN(@List) - @i))
    END

    SELECT @Left = RTRIM(LTRIM(SUBSTRING(@List, @i + 1, LEN(@List) - @i)))

    INSERT INTO @TblList
    SELECT @Left

    RETURN
END
GO


