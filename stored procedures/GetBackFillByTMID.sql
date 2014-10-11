USE [SuPlan]
GO

/****** Object:  StoredProcedure [dbo].[GetBackFillByTMID]    Script Date: 03/07/2014 12:56:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBackFillByTMID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBackFillByTMID]
GO


CREATE PROCEDURE [dbo].[GetBackFillByTMID]
	@TMID int
AS

BEGIN
	  select 
	  BF.ID
	  , BF.TMID as TMID
	  , TM.ID as BF_TMID
	  ,isnull(NT.ID,-1) as TimeFrameID
	  ,isnull(NT.TimeFrame + ':','') as TimeFrame
	  ,CASE WHEN TM.Active = 0 THEN TM.Name + ' - deactivated' ELSE TM.Name END as TMName
    from 
    BackFill BF 
    inner join TeamMembers TM on BF.BackFillTMID = TM.ID
    left outer join TimeFrames NT on TM.NextJobTimeFrameID = NT.ID
	where BF.TMID = @TMID
	order by TimeFrameID

 END
 

GO


