USE SuPlan

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertImportCheckTM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertImportCheckTM]
GO

CREATE PROCEDURE InsertImportCheckTM
AS
BEGIN
	delete from ImportCheckTM
	
	declare @top int
	declare @i int

	select @top = MAX(ID) from ImportChecks
	select @i = MIN(ID) from ImportChecks

	while @i <= @top
	BEGIN
		declare @tmid table (tmid int)

		declare @insertsql varchar(max)
		
		select @insertsql = CheckSQL from ImportChecks where ID = @i
		
		if @insertsql is not null
		BEGIN
			insert into @tmid (tmid) 
			exec (@insertsql)
			insert into ImportCheckTM (ImportCheckID, TMID)
			select @i, tmid from @tmid 
			
			delete from @tmid
		END
		set @i = @i + 1
	END
END
