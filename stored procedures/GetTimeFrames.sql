USE [SuPlan]
GO

/****** Object:  StoredProcedure [dbo].[GetTimePeriods]    Script Date: 02/21/2014 10:34:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTimeFrames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTimeFrames]
GO

CREATE PROCEDURE [dbo].[GetTimeFrames]
AS
BEGIN
	select ID as TimeFrameID
	, TimeFrame
	from TimeFrames
END
GO


