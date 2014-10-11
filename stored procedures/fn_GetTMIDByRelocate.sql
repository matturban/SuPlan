USE [SuPlan]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetTMIDByRelocate]    Script Date: 02/27/2014 16:53:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetTMIDByRelocate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetTMIDByRelocate]
GO



CREATE FUNCTION [dbo].[fn_GetTMIDByRelocate]
(@search varchar(max))
RETURNS @TMID TABLE (TMID int)
AS
BEGIN
	if @search is not null
	BEGIN
		declare @keep varchar(50)
		set @keep = '%[^a-z,;]%'

		while PatIndex(@keep, @search) > 0
		begin
			set @search = stuff(@search, PatIndex(@keep, @search), 1, '')
		end

		select @search = REPLACE(@search,';',',')

		declare @location table (id int identity(1,1),locationname varchar(50))

		DECLARE @value NVARCHAR(11)
		DECLARE @position INT

		SET @search = LTRIM(RTRIM(@search))+ ','
		SET @position = CHARINDEX(',', @search, 1)

		IF REPLACE(@search, ',', '') <> ''
		BEGIN
			  WHILE @position > 0
			  BEGIN 
					 SET @value = LTRIM(RTRIM(LEFT(@search, @position - 1)));
					 INSERT INTO @location (locationname)
					 VALUES (@value);
					 SET @search = RIGHT(@search, LEN(@search) - @position);
					 SET @position = CHARINDEX(',', @search, 1);

			  END
		END   

		insert into @TMID (TMID)
		select distinct TMID
		from @location loc
		inner join Locations L on loc.locationname = L.Acronym
		inner join TMRelocate T on L.ID = T.ToLocationID
	END
	else
	BEGIN
		insert into @TMID (TMID)
		select ID from TeamMembers
	END
	RETURN 
END

GO


