DROP TYPE [dbo].[LocationList]
GO

CREATE TYPE [dbo].[LocationList] AS TABLE(
[ID] [int],
[LocationID] [int]
)