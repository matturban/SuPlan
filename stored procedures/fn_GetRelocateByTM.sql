USE [SuPlan]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetRelocationByTM]    Script Date: 02/27/2014 16:10:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetRelocateByTM]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetRelocateByTM]
GO



CREATE FUNCTION [dbo].[fn_GetRelocateByTM]
(
	@TMID int
)
RETURNS varchar(max)
AS
BEGIN

declare @Metros table (id int identity(1,1), metroid int, metroname varchar(50))
insert into @Metros (metroid, metroname)
select distinct
M.ID
, M.Name
from 
TMRelocate R
inner join Locations L on R.ToLocationID = L.ID
inner join Metros M on L.MetroID = M.ID
where R.TMID = @TMID 

declare @Locations table (id int identity(1,1), metroid int, locationname varchar(50))

declare @mCount int

select @mCount = COUNT(id) from @Metros

declare @result varchar(max)
set @result = '<span>'

declare @m int

set @m = 1

while @m <= @mCount
BEGIN
	select @result = @result + '<b>' + m.metroname + ':</b>'
	from @Metros m
	where m.id = @m
	
	insert into @Locations (metroid, locationname)
	select distinct
	L.MetroID
	, L.Acronym
	from 
	TMRelocate R
	inner join Locations L on R.ToLocationID = L.ID
	inner join @Metros m on L.MetroID = m.metroid
	where R.TMID = @TMID and m.id = @m

	declare @lCount int
	select @lCount = COUNT(l.id) from @Locations l
	
	---------------------------------------------------------------------------------------
	--select @lCount
	--select @m
	--select * from @Locations
	--------------------------------------------------------------------------------------
	declare @l int
	set @l = 1
	
	while @l <= @lCount
	BEGIN
		select @result = @result + l.locationname + ', '
		from @Locations l 
		inner join @Metros m on l.metroid = m.metroid
		where l.id = @l and m.id = @m
		
		set @l = @l+1
	END--
	if RIGHT(@result,2) = ', ' 
		BEGIN
			set @result = SUBSTRING(@result,1,len(@result)-1)
		END
		
	set @result = @result + '</br>'
	set @m = @m+1
END
set @result = @result + '</span>'

return @result

END

GO


