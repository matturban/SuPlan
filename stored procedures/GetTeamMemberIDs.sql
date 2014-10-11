DROP PROCEDURE GetTeamMemberIDs
GO

CREATE PROCEDURE GetTeamMemberIDs
AS
BEGIN
	select distinct TM.ID as TMIDID
	, TM.TeamMemberID
	from TeamMembers TM
	inner join JobTitles J on TM.JobTitleID = J.ID
	where J.Include = 1	
	and TM.Active = 1
	order by TM.TeamMemberID
END