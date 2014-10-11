/****** Object:  StoredProcedure [dbo].[GetTeamMembers]    Script Date: 02/14/2014 15:01:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMembersExport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMembersExport]
GO

CREATE PROCEDURE [dbo].[GetTeamMembersExport]
	@filter varchar(max),
	@relocate varchar(max)
AS

--declare @filter varchar(max)
--set @filter = 'where LOWER(TM.LastName) like ''%murr%'' '

BEGIN
	
	declare @query varchar(max)
	
	if @filter = ''
	BEGIN
		set @query = 'select top 100 '
	END
	else
	BEGIN
		set @query = 'select '
	END

	set @query = @query +
	  'M.Name as Metro
	  ,L.Acronym as Location
      ,TM.TeamMemberID
      ,CASE WHEN RIGHT(LOWER(T.Name),5) = '' team''
		THEN LEFT(T.Name,len(T.Name)-5)
		ELSE T.Name END AS Team
      ,TM.Name as TMName
      ,isnull(EL.Level,'''') as Education
      ,isnull(JT.Title,'''') as JobTitle
      ,TM.HireDate
      ,TM.JobEntryDate
      ,TM.LastJD
      ,isnull(JR.Rating,'''') as JDRating
      ,JR.RatingValue as JDRatingValue
      ,isnull(R.Risk,'''') as Risk
      ,isnull(NJ.Title,'''') as NextJob
      ,isnull(TI.Name,'''') as TeamInterest
      ,isnull(NT.TimeFrame,'''') as TimeFrame
      ,[dbo].[fn_GetRelocateByTM](TM.ID) as Relocate
      ,TM.DestinationPlan
      ,BF.zeromonth
      ,BF.sixmonth
      ,BF.twelvemonth
	  ,CAST(ISNULL(IC.TMID,0) as bit) as Updated
      ,[dbo].[fn_GetImportChecks](TM.ID) as ImportChecks
    from TeamMembers TM 
    left outer join EducationLevels EL on TM.EducationLevelID = EL.ID
    inner join Locations L on TM.LocationID = L.ID
    inner join Metros M on L.MetroID = M.ID
    inner join Teams T on TM.TeamID = T.ID
    left outer join JDRatings JR on TM.LastJDRatingID = JR.ID
    inner join JobTitles JT on TM.JobTitleID = JT.ID and JT.Include = 1
    left outer join Risks R on TM.RiskID = R.ID
    left outer join JobTitles NJ on TM.NextJobID = NJ.ID
    left outer join Teams TI on TM.TeamInterestID =  TI.ID
    left outer join TimeFrames NT on TM.NextJobTimeFrameID = NT.ID
    left outer join (select distinct TMID from ImportCheckTM) IC on TM.ID = IC.TMID
    cross apply [dbo].[fn_GetBackFill] (TM.ID) BF
    '
    
    if @relocate is not null and @relocate != ''
    BEGIN
		set @query = @query + 'inner join [dbo].[fn_getTMIDByRelocate](''' + @relocate + ''') rel on TM.ID = rel.TMID '
    END
    
    BEGIN
		set @query = @query + @filter
    END
    
    
 --select @query
 
 exec (@query)
 
 END
 
 /*
declare @filter varchar(max)
declare @relocate varchar(max)

set @filter = ' '
set @relocate = 'CIC,111,KBS,LKV;'

exec GetTeamMembers @filter, @relocate
*/