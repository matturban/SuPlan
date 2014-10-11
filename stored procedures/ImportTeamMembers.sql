/****** Object:  StoredProcedure [dbo].[ImportTeamMembers]    Script Date: 05/15/2014 12:44:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportTeamMembers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ImportTeamMembers]
GO

CREATE PROCEDURE [dbo].[ImportTeamMembers]
AS
BEGIN
	declare @Import table (ID int identity(1,1),TMID int, Name varchar(50), LastHireDate datetime, Location varchar(3), LocationID int, TeamID int, JobTitleID int)

	insert into @Import (TMID, Name, LastHireDate, Location, TeamID, JobTitleID)

	select 
	I.TMID
	, I.Name
	, I.LastHireDate
	, CASE WHEN LEN(I.Location)>3 THEN SUBSTRING(I.Location,7,3) ELSE I.Location END AS Location
	, T.ID
	, JT.ID
	from TeamMembersImport I
	inner join JobTitles JT on I.JobTitle = JT.Title
	inner join Teams T on I.TeamCode = T.TeamCode
	where JT.Include = 1

	update @Import 
	set LocationID = L.ID 
	from Locations L
	inner join @Import I on I.Location = L.Acronym

	select * from @Import
	select * from TeamMembers

	--insert new TMs---------------------------------------------------------------
	insert into TeamMembers
	(TeamMemberID
	,Name
	,HireDate
	,LocationID
	,TeamID
	,JobTitleID
	,Active
	,Inserted)

	select
	I.TMID
	,I.Name
	,I.LastHireDate
	,I.LocationID
	,I.TeamID
	,I.JobTitleID
	,1 --Active
	,GETDATE() --inserted
	from @Import I
	where I.TMID not in (select TeamMemberID from TeamMembers)

	--update existing TMs---------------------------------------------------------------
	update TeamMembers
	set 
	Name = I.Name
	, LocationID = I.LocationID
	, TeamID = I.TeamID
	, JobTitleID = I.JobTitleID
	, JobTitleUpdated = CASE WHEN I.JobTitleID != TM.JobTitleID THEN GETDATE() ELSE TM.JobTitleUpdated END
	--, NextJobTimeFrameID = CASE WHEN I.JobTitleID != TM.JobTitleID THEN NULL ELSE TM.NextJobTimeFrameID END
	, LastEdited = GETDATE()
	, LastEditedBy = 'import'
	from @Import I
	inner join TeamMembers TM on TM.TeamMemberID = I.TMID
	where TM.Name != I.Name
	or TM.LocationID != I.LocationID
	or TM.TeamID != I.TeamID
	or TM.JobTitleID != I.JobTitleID
	
	--delete previously deactivated TMs---------------------------------------------------------------
	delete from TeamMembers
	where Active = 0 and Deactivated < GETDATE ()-21

	--deactivate TMs---------------------------------------------------------------
	update TeamMembers
	set Active = 0
	, Deactivated = GETDATE()
	where TeamMemberID not in (select TMID from @Import)
	
	--set import checks---------------------------------------------------------------
	exec InsertImportCheckTM
	
END
GO


