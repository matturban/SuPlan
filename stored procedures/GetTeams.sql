USE [SuPlan]
GO

/****** Object:  StoredProcedure [dbo].[GetTeams]    Script Date: 02/20/2014 11:36:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeams]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeams]
GO

USE [SuPlan]
GO

/****** Object:  StoredProcedure [dbo].[GetTeams]    Script Date: 02/20/2014 11:36:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTeams]
AS
BEGIN
	select distinct ID as TeamID
	, Name
	, TeamCode
	from Teams 
	order by Name
END
GO


