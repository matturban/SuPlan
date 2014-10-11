USE [SuPlan]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetRelocateByTM]    Script Date: 03/13/2014 16:40:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetImportChecks]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetImportChecks]
GO


CREATE FUNCTION [dbo].[fn_GetImportChecks]
(
	@TMID int
)
RETURNS varchar(max)
AS
BEGIN
	declare @count int
	declare @i int

	select @count = COUNT(*) from ImportCheckTM where TMID = @TMID

	declare @checks table (id int identity(1,1), checkdesc varchar(50))

	insert into @checks (checkdesc)
	select CheckDescription
	from ImportCheckTM TM
	inner join ImportChecks IC on TM.ImportCheckID = IC.ID
	where TMID = @TMID

	select @i = MIN(id) from @checks

	declare @result varchar(max)
	set @result = ''

	while @i <= @count
	BEGIN
		select @result = @result + isnull(checkdesc,id)  + '</br>' from @checks where id = @i
		
		set @i = @i + 1
	END

	if RIGHT(@result,5) = '</br>'
	BEGIN
		set @result = LEFT(@result,len(@result)-5)
	END

return @result

END

--declare @TMID int
--set @TMID = 979

