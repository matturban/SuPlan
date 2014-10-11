IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTeamMemberNames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTeamMemberNames]
GO

CREATE PROCEDURE GetTeamMemberNames
AS
BEGIN
	select distinct TM.ID as NameID
	, TM.Name
	from TeamMembers TM
	inner join JobTitles J on TM.JobTitleID = J.ID
	where J.Include = 1	
	and TM.Active = 1
	order by Name
END