IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetBackFill]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_GetBackFill]
GO

--declare @ID int
--set @ID = 8422

CREATE FUNCTION [dbo].[fn_GetBackFill]
(@ID int)
RETURNS @backfill TABLE (ID int, [zeromonth] varchar(max), [sixmonth] varchar(max), [twelvemonth] varchar(max))
AS
BEGIN
	declare @totalcount int
	declare @zeroID int
	declare @sixID int
	declare @twelveID int
	declare @zerocount int
	declare @sixcount int
	declare @twelvecount int

	select @zeroID = ID from TimeFrames where TimeFrame = '0-6 months'
	select @sixID = ID from TimeFrames where TimeFrame = '6-12 months'
	select @twelveID = ID from TimeFrames where TimeFrame = '12+ months'

	declare @zero table (ID int identity(1,1), TMID int, Name varchar(max))
	declare @six table (ID int identity(1,1), TMID int, Name varchar(max))
	declare @twelve table (ID int identity(1,1), TMID int, Name varchar(max))

	insert into @zero (TMID, Name)
	select BF.BackFillTMID, TM.Name
	from BackFill BF
	inner join TeamMembers TM on BF.BackFillTMID = TM.ID
	where BF.TMID = @ID and TM.NextJobTimeFrameID = @zeroID

	insert into @six (TMID, Name)
	select BF.TMID, TM.Name
	from BackFill BF
	inner join TeamMembers TM on BF.BackFillTMID = TM.ID
	where BF.TMID = @ID and TM.NextJobTimeFrameID = @sixID

	insert into @twelve (TMID, Name)
	select BF.TMID, TM.Name
	from BackFill BF
	inner join TeamMembers TM on BF.BackFillTMID = TM.ID
	where BF.TMID = @ID and TM.NextJobTimeFrameID = @twelveID

	select @zerocount = COUNT(*) from @zero 
	select @sixcount = COUNT(*) from @six
	select @twelvecount = COUNT(*) from @twelve 

	declare @izero int
	declare @isix int
	declare @itwelve int

	set @izero = 1
	set @isix = 1
	set @itwelve = 1

	BEGIN
		insert into @backfill (ID) values (@ID)

		while @izero <= @zerocount
		BEGIN
		update @backfill
		set [zeromonth] = Name + '; ' + isnull([zeromonth],'')
		from 
		@zero T
		where T.ID = @izero
		set @izero = @izero + 1
		END
		
		while @isix <= @sixcount
		BEGIN
		update @backfill
		set [sixmonth] = Name + '; ' + isnull([sixmonth],'')
		from 
		@six T
		where T.ID = @isix
		set @isix = @isix + 1
		END
		
		while @itwelve <= @twelvecount
		BEGIN
		update @backfill
		set [twelvemonth] = Name + '; ' + isnull([twelvemonth],'')
		from 
		@twelve T
		where T.ID = @itwelve
		set @itwelve = @itwelve + 1

		END

		update @backfill
		set [zeromonth] = SUBSTRING([zeromonth],1,len([zeromonth])-2)
		, [sixmonth] = SUBSTRING([sixmonth],1,len([sixmonth])-2)
		, [twelvemonth] = SUBSTRING([twelvemonth],1,len([twelvemonth])-2)
		--select * from @backfill
	END
	RETURN 
END