
/****** Object:  StoredProcedure [dbo].[GetTeamMembers]    Script Date: 02/28/2014 16:29:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMemberByTMID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMemberByTMID]
GO

/****** Object:  StoredProcedure [dbo].[GetTeamMemberByTMID]    Script Date: 02/28/2014 16:29:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetTeamMemberByTMID]
	@TMID int
AS

BEGIN
	  select TM.ID as TMID
	  ,M.Name as Metro
	  ,L.Acronym as Location
      ,TM.TeamMemberID
      ,T.Name as Team
      ,TM.Name as TMName
      ,isnull(EL.Level,'') as Education
      ,isnull(JT.ShortTitle,'') as JobTitle
      ,TM.HireDate
      ,TM.JobEntryDate
      ,TM.LastJD
      ,isnull(JR.Rating,'') as JDRating
      ,JR.RatingValue as JDRatingValue
      ,isnull(R.Risk,'') as Risk
	  ,isnull(NJ.ShortTitle,'') as NextJob
      ,isnull(TI.Name,'') as TeamInterest
      ,isnull(NT.TimeFrame,'') as TimeFrame
	  ,isnull(NT.TimeFrame,'') + isnull(' (as of ' + convert(varchar(10), TM.TimeFrameUpdated, 101) + ')','') as TimeFrameLong
      ,[dbo].[fn_GetRelocateByTM](TM.ID) as Relocate
      ,REPLACE(TM.DestinationPlan,'<br>',' ') as DestinationPlan --replace added to clean up html tags inserted during data conversion
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
    left outer join NextJobTitles NJ on TM.NextJobID = NJ.ID
    left outer join Teams TI on TM.TeamInterestID =  TI.ID
    left outer join TimeFrames NT on TM.NextJobTimeFrameID = NT.ID
    left outer join (select distinct TMID from ImportCheckTM) IC on TM.ID = IC.TMID
	where TM.ID = @TMID
	and TM.Active = 1
    
    
 --select @query
 
 --exec (@query)
 
 END
 
GO


