/****** Object:  StoredProcedure [dbo].[GetTeamMembers]    Script Date: 02/14/2014 15:01:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMembersExport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMembersExport]
GO

CREATE PROCEDURE [dbo].[GetTeamMembersExport]
	@Updated bit,
	@TMID int,
	@TeamID int,
	@MetroID int,
	@LocationID int,
	@JobTitleID int,
	@JobEntryDate datetime=null,
	@LastJDDate datetime=null,
	@JDRatingID int,
	@RiskID int,
	@NextJobID int,
	@TeamInterestID int,
	@TimeFrameID int,
	@Relocate varchar(max)=null,
	@DestinationPlan varchar(max)=null
AS

BEGIN
	if @TMID=0 set @TMID=null
	if @TeamID=0 set @TeamID=null
	if @MetroID=0 set @MetroID=null
	if @LocationID=0 set @LocationID=null
	if @JobTitleID=0 set @JobTitleID=null
	if @JDRatingID=0 set @JDRatingID=null
	if @RiskID=0 set @RiskID=null
	if @NextJobID=0 set @NextJobID=null
	if @TeamInterestID=0 set @TeamInterestID=null
	if @TimeFrameID=0 set @TimeFrameID=null
	if @DestinationPlan is null
	
	BEGIN
		set @DestinationPlan = ''
	END
	
	if @Relocate is null
	BEGIN
		set @Relocate = '%'
	END
	
	select
	  M.Name as Metro
	  ,L.Acronym as Location
      ,TM.TeamMemberID
      ,CASE WHEN RIGHT(LOWER(T.Name),5) = ' team'
		THEN LEFT(T.Name,len(T.Name)-5)
		ELSE T.Name END AS Team
      ,TM.Name as TMName
      ,isnull(EL.Level,'') as Education
      ,isnull(JT.Title,'') as JobTitle
      ,TM.HireDate
      ,TM.JobEntryDate
      ,TM.LastJD
      ,isnull(JR.Rating,'') as JDRating
      ,JR.RatingValue as JDRatingValue
      ,isnull(R.Risk,'') as Risk
      ,isnull(NJ.Title,'') as NextJob
      ,isnull(TI.Name,'') as TeamInterest
      ,isnull(NT.TimeFrame,'') as TimeFrame
      ,[dbo].[fn_GetRelocateByTM](TM.ID) as Relocate
      ,TM.DestinationPlan
      ,BF.zeromonth as [0-6 Month Back Fill]
      ,BF.sixmonth as [6-12 Month Back Fill]
      ,BF.twelvemonth as [12+ Month Back Fill]
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
    where 1=1
	and isnull(@Updated,CAST(ISNULL(IC.TMID,0) as bit)) = CAST(ISNULL(IC.TMID,0) as bit)
	and isnull(@TMID,TM.ID) = TM.ID
	and isnull(@TeamID,T.ID) = T.ID
	and isnull(@MetroID,M.ID) = M.ID
	and isnull(@LocationID,L.ID) = L.ID
	and isnull(@JobTitleID,JT.ID) = JT.ID
	and CAST(isnull(@JobEntryDate,isnull(TM.JobEntryDate,0)) as DATE) = CAST(isnull(TM.JobEntryDate,0) as DATE)
	and CAST(isnull(@LastJDDate, isnull(TM.LastJD,0)) as DATE) = CAST(isnull(TM.LastJD,0) as DATE)
	and isnull(@JDRatingID,isnull(JR.ID,0)) = isnull(JR.ID,0)
	and isnull(@RiskID,isnull(R.ID,0)) = isnull(R.ID,0)
	and isnull(@NextJobID,isnull(NJ.ID,0)) = isnull(NJ.ID,0)
	and isnull(@TeamInterestID,isnull(TI.ID,0)) = isnull(TI.ID,0)
	and isnull(@TimeFrameID,isnull(NT.ID,0)) = isnull(NT.ID,0)
	and @DestinationPlan like isnull(TM.DestinationPlan,'')
	and @Relocate not like [dbo].[fn_GetRelocateByTM](TM.ID)
 
 END
 
 /*
declare @filter varchar(max)
declare @relocate varchar(max)

set @filter = ' '
set @relocate = 'CIC,111,KBS,LKV;'

exec GetTeamMembers @filter, @relocate
*/