
declare @tm int
set @tm = 282

DECLARE	@return_value int

EXEC	@return_value = [dbo].[GetTeamMembers]
		@Updated = NULL,
		@TMID = @tm,
		@TeamID = 0,
		@MetroID = 0,
		@LocationID = 0,
		@ShortTitle = null,
		@JobEntryDate = NULL,
		@LastJDDate = NULL,
		@JDRatingID = 0,
		@RiskID = 0,
		@NextJobID = 0,
		@TeamInterestID = 0,
		@TimeFrameID = 0,
		@Relocate = NULL,
		--@Relocate = 'CIC,',
		@DestinationPlan = NULL

exec GetTeamMemberByTMID @tm
