ALTER PROC [dbo].[usp_GetServiceSubTypesForSource]
@sourceId VARCHAR(MAX)
AS 

SELECT	ds.nmDataSourceId, 
		ds.vcDataSourceName, 
		dse.nmAutoId, 
		sst.nmServiceSubTypeId,
		sst.vcDescription vcName,
		sst.vcDescription
FROM  DataSourceDetails ds
JOIN [fnSplitString](@sourceId,',') sources ON sources.ResultSet=ds.nmDataSourceId
JOIN DataSourceEnvironmentDetails dse ON ds.nmDataSourceId=dse.nmDataSourceId
JOIN ServiceSubTypeMaster sst ON dse.nmServiceSubTypeID=sst.nmServiceSubTypeID 
JOIN ToolMaster tm on dse.nmToolId= tm.nmToolId
WHERE tm.chUseForSR='N' AND sst.chAutomation='Y' AND sst.chActive='Y' AND tm.chiAutomate='Y' AND tm.chActive='Y'
ORDER BY ds.nmDataSourceId

