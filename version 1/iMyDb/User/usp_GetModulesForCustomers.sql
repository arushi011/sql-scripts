USE [iMYDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetModulesForCustomers]    Script Date: 02-12-2017 14:29:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[usp_GetModulesForCustomers]
@vcCustomerId VARCHAR(max),
@vcUserId VARCHAR(50)
AS 
select distinct
ctm.nmCustomerId,acm.vcCustomerName,ctm.nmDataSourceId, dsd.vcDataSourceName, sstm.nmServiceSubTypeId, sstm.vcDescription, tm.vcConnection, tm.nmToolId, sst.nmServiceTypeId, sst.vcName,
IIF(umcm.nmServiceSubTypeId IS NULL AND umcm.nmCustomerId IS NULL,0,1) AS isModuleSelected 
from [fnSplitString](@vcCustomerId,',') customers
join Admin_CustomerMaster acm on customers.ResultSet  = acm.nmCustomerId AND acm.chActive='Y'
join CustomerToToolMapping ctm on customers.ResultSet = ctm.nmCustomerId AND ctm.chActive='Y'
join ServiceSubTypeMaster sstm on ctm.nmServiceSubTypeId = sstm.nmServiceSubTypeId and sstm.chActive = 'Y' 
join ServiceTypeMaster sst on sstm.nmServiceTypeId = sst.nmServiceTypeId and sst.chActive = 'Y' 
join ToolMaster tm on tm.nmToolId = ctm.nmToolId and tm.chActive = 'Y'
join DataSourceDetails dsd on dsd.nmDataSourceId = ctm.nmDataSourceId AND dsd.chActive = 'Y' 
left join UserModuleCustomerMapping umcm on ctm.nmServiceSubTypeId = umcm.nmServiceSubTypeId AND ctm.nmCustomerId = umcm.nmCustomerId and ctm.nmDataSourceId = umcm.nmDataSourceId
AND umcm.vcUserId=@vcUserId 
AND umcm.chActive='Y'

