USE [SuPlan]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBackFill]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertBackFill]
GO


CREATE PROCEDURE [dbo].[InsertBackFill] 
@TMID int,
@BackFillID int

AS

BEGIN
	IF NOT EXISTS (select * from BackFill where TMID = @TMID and BackFillTMID = @BackFillID)
	BEGIN
		INSERT INTO BackFill (TMID, BackFillTMID)
		VALUES (@TMID, @BackFillID)
	END
END