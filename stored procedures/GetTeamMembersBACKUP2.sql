/****** Object:  StoredProcedure [dbo].[GetTeamMembers]    Script Date: 02/14/2014 15:01:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMembers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMembers]
GO

CREATE PROCEDURE [dbo].[GetTeamMembers]
	@filter varchar(max),
	@relocate varchar(max)
AS

--declare @filter varchar(max)
--set @filter = 'where LOWER(TM.LastName) like ''%murr%'' '

BEGIN
	
	declare @query varchar(max)
	
	if @filter = ''
	BEGIN
		set @query = 'select top 0 '
	END
	else
	BEGIN
		set @query = 'select '
	END

	set @query = @query +
	  'TM.ID as TMID
	  ,M.Name as Metro
	  ,L.ID as LocationID
	  ,L.Acronym as Location
      ,TM.TeamMemberID
      ,T.ID as TeamID
      ,T.Name AS Team
      ,TM.Name as TMName
      ,isnull(EL.ID,-1) as LevelID
      ,isnull(EL.Level,'''') as Education
	  ,isnull(JT.ID,-1) as TitleID
      ,isnull(JT.ShortTitle,'''') as JobTitle
      ,TM.HireDate
      ,TM.JobEntryDate
      ,TM.LastJD
      ,isnull(JR.ID,-1) as RatingID
      ,isnull(JR.Rating,'''') as JDRating
      ,JR.RatingValue as JDRatingValue
      ,isnull(R.ID,-1) as RiskID
      ,isnull(R.Risk,'''') as Risk
      ,isnull(NJ.ID,-1) as NextJobID
      ,isnull(NJ.Title,'''') as NextJob
      ,isnull(TI.ID,-1) as TeamInterestID
      ,isnull(TI.Name,'''') as TeamInterest
      ,isnull(NT.ID,-1) as TimeFrameID
      ,isnull(NT.TimeFrame,'''') as TimeFrame
      ,[dbo].[fn_GetRelocateByTM](TM.ID) as Relocate
      ,TM.DestinationPlan
      ,BF.TMID as TMIDB
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
    left outer join (select distinct TMID from BackFill) BF on TM.ID = BF.TMID
    left outer join (select distinct TMID from ImportCheckTM) IC on TM.ID = IC.TMID
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