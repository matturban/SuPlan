USE [SuPlan]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTeamMembers]    Script Date: 02/20/2014 14:29:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateTeamMembers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateTeamMembers]
GO


CREATE PROCEDURE [dbo].[UpdateTeamMembers] 
@ID int,
@JobEntryDate datetime=null,
@EducationLevelID int,
@LastJD datetime=null,
@LastJDRatingID int,
@RiskID int,
@NextJobID int,
@TeamInterestID int,
@NextJobTimeFrameID int,
@Relocate LocationList READONLY,
@DestinationPlan varchar(max),
@BackFillID int,
@Updated bit,
@Username varchar(50)

AS

BEGIN

	UPDATE [SuPlan].[dbo].[TeamMembers]
	   SET 
		  [JobEntryDate] = @JobEntryDate
		  ,[EducationLevelID] = @EducationLevelID
		  ,[LastJD] = @LastJD
		  ,[LastJDRatingID] = CASE WHEN @LastJDRatingID = -1 THEN NULL ELSE @LastJDRatingID END
		  ,[RiskID] = CASE WHEN @RiskID = -1 THEN NULL ELSE @RiskID END
		  ,[NextJobID] = CASE WHEN @NextJobID = -1 THEN NULL ELSE @NextJobID END
		  ,[TeamInterestID] = CASE WHEN @TeamInterestID = -1 THEN NULL ELSE @TeamInterestID END
		  ,[NextJobTimeFrameID] = CASE WHEN @NextJobTimeFrameID = -1 THEN NULL ELSE @NextJobTimeFrameID END
		  ,[DestinationPlan] = @DestinationPlan
		  ,[LastEdited] = GETDATE()
		  ,[LastEditedBy] = @Username
		  ,[TimeFrameUpdated] = CASE WHEN ISNULL(NextJobTimeFrameID,-1) != ISNULL(@NextJobTimeFrameID,-1) THEN GETDATE() ELSE TimeFrameUpdated END
	 WHERE ID = @ID

	if (@BackFillID > 0)
	BEGIN
		if not exists (select * from BackFill where TMID = @BackFillID and BackFillTMID = @ID)
		BEGIN
			insert into BackFill (TMID, BackFillTMID)
			values (@BackFillID, @ID)
		END
	END

	declare @LocationCount int
	select @LocationCount = COUNT(*) from @Relocate
	
	delete from TMRelocate 
	where TMID = @ID

	if (@LocationCount > 0)
	BEGIN			
		declare @l int
		set @l = 1
		while  @l <= @LocationCount
		BEGIN
			insert into TMRelocate (TMID,ToLocationID)
			select @ID, r.LocationID
			from @Relocate r
			where r.ID = @l
			set @l = @l+1
		END
	END
	
	if (@Updated = 0)
	BEGIN
	IF EXISTS (select * from ImportCheckTM where TMID = @ID)
		BEGIN
			DELETE FROM ImportCheckTM where TMID = @ID
		END
	END
END
GO

