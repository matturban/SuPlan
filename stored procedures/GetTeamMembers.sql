/****** Object:  StoredProcedure [dbo].[GetTeamMembers]    Script Date: 02/14/2014 15:01:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMembers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMembers]
GO

CREATE PROCEDURE [dbo].[GetTeamMembers]
	@Updated bit=null,
	@TMID int,
	@TeamID int,
	@MetroID int,
	@LocationID int,
	@ShortTitle varchar(5)=null,
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
	if @JDRatingID=0 set @JDRatingID=null
	if @RiskID=0 set @RiskID=null
	if @NextJobID=0 set @NextJobID=null
	if @TeamInterestID=0 set @TeamInterestID=null
	if @TimeFrameID=0 set @TimeFrameID=null

	declare @top int
	set @top = 1000
	
	if coalesce(
				cast(@Updated as varchar(1))
				,cast(@TMID as varchar(1))
				,cast(@TeamID as varchar(1))
				,cast(@MetroID as varchar(1))
				,cast(@LocationID as varchar(1))
				,@ShortTitle
				,cast(@JDRatingID as varchar(1))
				,cast(@RiskID as varchar(1))
				,cast(@NextJobID as varchar(1))
				,cast(@TeamInterestID as varchar(1))
				,cast(@TimeFrameID as varchar(1))
				,@Relocate
				,@DestinationPlan) is null
	BEGIN
		select @top = 0
	END
	
	if @ShortTitle is null
	BEGIN
		set @ShortTitle = '%'
	END
	
	if @DestinationPlan is null
	BEGIN
		set @DestinationPlan = '%'
	END
	else
	BEGIN
		set @DestinationPlan = '%' + @DestinationPlan + '%'
	END
	
	if @Updated = 0 set @Updated = null
	
	select top (@top)
	  TM.ID as TMID
	  ,M.Name as Metro
	  ,L.ID as LocationID
	  ,L.Acronym as Location
	  ,TM.TeamMemberID
	  ,T.ID as TeamID
	  ,T.Name AS Team
	  ,TM.Name as TMName
	  ,isnull(EL.ID,-1) as LevelID
	  ,isnull(EL.Level,'') as Education
	  ,isnull(JT.ID,-1) as TitleID
	  ,isnull(JT.ShortTitle,'') as JobTitle
	  ,TM.HireDate
	  ,TM.JobEntryDate
	  ,TM.LastJD
	  ,isnull(JR.ID,-1) as RatingID
	  ,isnull(JR.Rating,'') as JDRating
	  ,JR.RatingValue as JDRatingValue
	  ,isnull(R.ID,-1) as RiskID
	  ,isnull(R.Risk,'') as Risk
	  ,isnull(NJ.ID,-1) as NextJobID
	  ,isnull(NJ.ShortTitle,'') as NextJob
	  ,isnull(TI.ID,-1) as TeamInterestID
	  ,isnull(TI.Name,'') as TeamInterest
	  ,isnull(NT.ID,-1) as TimeFrameID
	  ,isnull(NT.TimeFrame,'') as TimeFrame
	  ,isnull(NT.TimeFrame,'') + isnull(' (as of ' + convert(varchar(10), TM.TimeFrameUpdated, 101) + ')','') as TimeFrameLong
	  ,[dbo].[fn_GetRelocateByTM](TM.ID) as Relocate
	  ,REPLACE(TM.DestinationPlan,'<br>',' ') as DestinationPlan --replace added to clean up html tags inserted during data conversion
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
	left outer join NextJobTitles NJ on TM.NextJobID = NJ.ID
	left outer join Teams TI on TM.TeamInterestID =  TI.ID
	left outer join TimeFrames NT on TM.NextJobTimeFrameID = NT.ID
	left outer join (select distinct TMID from BackFill) BF on TM.ID = BF.TMID
	left outer join (select distinct TMID from ImportCheckTM) IC on TM.ID = IC.TMID
	inner join [dbo].[fn_getTMIDByRelocate](@Relocate) rel on TM.ID = rel.TMID
	where 1=1
	and TM.Active = 1
	and isnull(@Updated,CAST(ISNULL(IC.TMID,0) as bit)) = CAST(ISNULL(IC.TMID,0) as bit)
	and isnull(@TMID,TM.ID) = TM.ID
	and isnull(@TeamID,T.ID) = T.ID
	and isnull(@MetroID,M.ID) = M.ID
	and isnull(@LocationID,L.ID) = L.ID
	and isnull(JT.ShortTitle,'') like @ShortTitle
	and CAST(isnull(@JobEntryDate,isnull(TM.JobEntryDate,0)) as DATE) = CAST(isnull(TM.JobEntryDate,0) as DATE)
	and CAST(isnull(@LastJDDate, isnull(TM.LastJD,0)) as DATE) = CAST(isnull(TM.LastJD,0) as DATE)
	and isnull(@JDRatingID,isnull(JR.ID,0)) = isnull(JR.ID,0)
	and isnull(@RiskID,isnull(R.ID,0)) = isnull(R.ID,0)
	and isnull(@NextJobID,isnull(NJ.ID,0)) = isnull(NJ.ID,0)
	and isnull(@TeamInterestID,isnull(TI.ID,0)) = isnull(TI.ID,0)
	and isnull(@TimeFrameID,isnull(NT.ID,0)) = isnull(NT.ID,0)
	and isnull(TM.DestinationPlan,'') like @DestinationPlan  
	order by M.Name,L.Acronym,T.Name,TM.Name 
 
 END
