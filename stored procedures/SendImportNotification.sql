
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SendImportNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SendImportNotification]
GO

CREATE PROCEDURE [dbo].[SendImportNotification] AS

BEGIN
	DECLARE 
	
		@EmailTo varchar(max),
		@EmailBody nvarchar(max),
		@EmailSubject nvarchar(255) = 'SuPlan Import Notification',
		@EmailImportance varchar(6) = 'Normal',
		
		@DBMailProfile varchar(100),
		@ErrorData nvarchar(max),
		@ServerName varchar(100),
		@DBName varchar(100),
		@ErrorsOccurred bit,
		@TextColor varchar(10),
		@LastDateInserted smalldatetime,
		@RowCount int
	
	SELECT	@LastDateInserted =CAST(DateInserted as smalldatetime), 
			@RowCount = COUNT(*)
				from TeamMembersImport
				where CAST(DateInserted as smalldatetime) = (select max(CAST(DateInserted as smalldatetime)) from TeamMembersImport)
				group by CAST(DateInserted as smalldatetime)
		
	
	SELECT
		@ServerName = CONVERT(varchar, SERVERPROPERTY('servername')),
		@DBName = DB_NAME()

	IF ISNULL(@LastDateInserted,'1/1/1900') < CAST(DATEADD(MINUTE,-30,GETDATE()) AS SMALLDATETIME) OR @RowCount < 5000
		SELECT
			@EmailImportance = 'High',
			@TextColor = '#FF0000'	-- red
	ELSE
	SELECT
		@TextColor = '#0000FF'	-- blue
	  
	SELECT @EmailBody = ISNULL(cast(@RowCount as varchar(5)) + ' rows inserted ' + cast(@LastDateInserted as varchar(20)),'no rows inserted')
	-- add common information to the e-mail body
	SELECT @EmailBody =
			N'<h5 style="font-family: Verdana, Arial; color: ' + @TextColor + '">' + ISNULL(@EmailBody, '') + '</h5>' +
			N'<table border="0" style="font-family: Verdana, Arial; font-size: 8pt">' +
			N'<tr><td>Server:</td><td>' + @ServerName + '</td></tr>' +
			N'<tr><td>Database:</td><td>' + @DBName + '</td></tr>' +
			N'<tr><td>Date/Time:</td><td>' + CONVERT(varchar, GETDATE(), 121) + '</td></tr>' +
			N'</table>'

	-- get the e-mail info
	SELECT
		@DBMailProfile = 'DB Mail',
		@EmailTo  = (select email_address from msdb.dbo.sysoperators where name = 'SuPlanImport'),
		@EmailSubject = ISNULL(@EmailSubject, 'SQL Server Message from ' + @ServerName)

	IF @EmailTo IS NULL
		PRINT 'No e-mail recipients are specified for ' + @EmailSubject + '!'
	ELSE
		 --send the e-mail
		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = @DBMailProfile
			,@recipients = @EmailTo
			,@importance = @EmailImportance
			,@subject = @EmailSubject
			,@body = @EmailBody
			,@body_format = 'HTML'

END
