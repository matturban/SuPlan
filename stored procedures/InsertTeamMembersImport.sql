/****** Object:  StoredProcedure [dbo].[ImportTeamMembers]    Script Date: 05/15/2014 12:44:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTeamMembersImport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertTeamMembersImport]
GO

CREATE PROCEDURE [dbo].[InsertTeamMembersImport]
@ImportData table
AS
BEGIN

	
END
GO


