--select * from Admin_CustomerMaster
--update Admin_CustomerMaster set chActive= 'Y' where vcCustomerName = 'asdf'
--delete from Admin_CustomerMaster 
--select * from CustomerDataSourceMapping
--delete from CustomerDataSourceMapping 
--select * from CustomerToToolMapping
--delete from CustomerToToolMapping
--select * from Tool_Config.dbo.CustomerToolFilterInList
--select * from tool_config.dbo.CustomerToolFilter
--delete from tool_config.dbo.CustomerToolFilter 
--delete from Tool_Config.dbo.CustomerToolFilterInList

select * from Admin_CustomerMaster
--update Admin_CustomerMaster set chActive= 'Y' where vcCustomerName = 'asdf'
--delete from Admin_CustomerMaster where nmCustomerId = 8
select * from CustomerDataSourceMapping
--delete from CustomerDataSourceMapping where nmCustomerId >= 8
select * from CustomerToToolMapping
--delete from CustomerToToolMapping where nmCustomerId >= 8
select * from Tool_Config.dbo.CustomerToolFilterInList
select * from tool_config.dbo.CustomerToolFilter
--delete from tool_config.dbo.CustomerToolFilter where nmCustomerId >= 8

select * from BaseModuleSourceTableMapping
--where nmServiceSubTypeId=4
select * from BaseSourceTables

select vcTableAlias from BaseSourceTables BST
JOIN BaseModuleSourceTableMapping BMS ON BST.nmSourceTableId=BMS.nmBaseSourceTableId
WHERE BST.chBase='Y' AND BST.chActive='Y' and BMS.nmServiceSubTypeId=1

delete from BaseModuleSourceTableMapping where nmBaseSourceTableId = 4
update BaseModuleSourceTableMapping set nmBaseSourceTableId = 1 where  nmServiceSubTypeId =4
update BaseSourceTables set chBase  = 'Y' where nmSourceTableId = 4
insert into BaseModuleSourceTableMapping(nmServiceSubTypeId, nmBaseSourceTableId, chActive) values (4,4,'Y')

exec usp_GetServiceSubTypesForSource '1,2'

SELECT	nmToolId, nmServiceSubTypeId FROM	DataSourceEnvironmentDetails WHERE nmAutoId=3
SELECT	vcDBName,vcConnection FROM	ToolMaster WHERE	nmToolId=2 and nmServiceSubTypeID=4

insert into ToolMaster(nmToolId,vcName,vcDescription,vcConnection,nmServiceSubTypeID, vcDatabaseType, vcDBName,
vcToolTimeFormat,chUseForSR,chiAutomate, chActive) values (2,'Tool','Tool',
'Ykf7DTKOeWWqGJ8Pe3d4yX3XfgRvsp+8WfpH44aKxUc8dwA9mUPMhXdBJ2ihrUUPYahKBfwllI0m9sXkgxIiykAuAnlgJSF6asdITn2hQV6VUiB+u4/9QhPsLgxJf3iBBc8/XYfz+NGw/IVUjTpbmolySqdQGxWuWJ/dm1tEUBI=',
4,'SQL',
'Tool.DBO.','101','N','Y','Y')

select * from DataSourceDetails
select * from DataSourceEnvironmentDetails
select * from ServiceSubTypeMaster
select * from ToolMaster
update ToolMaster set vcConnection = 'Ykf7DTKOeWWqGJ8Pe3d4yX3XfgRvsp+8WfpH44aKxUc8dwA9mUPMhXdBJ2ihrUUP4LK+DOE1/NmeP+wxmJKBaqHOw++X7HC6Ap4Ot65x9otkmK9t2VP9MHjmhwwDfV5YYcKSlfW/ERui3ilG39lkAumNHH+UN+CUXXbYwCwwpv0='
where nmToolId = 1 
select * from BaseModuleSourceTableMapping
--where nmServiceSubTypeId=4
select * from BaseSourceTables

insert into DataSourceEnvironmentDetails(nmDataSourceId,nmServiceSubTypeId,nmToolId,chActive) values (2,4,2,'Y')
insert into DataSourceDetails(nmDataSourceId, vcDataSourceName, nmServiceTypeId, vcIntegrationMethodCode, vcDataSourceDetails, chiAutomate, chActive) values(3, 'Test-Datasource-2', 1, 1,'[{"URL":"https://hclgbp1dev.service-now.com","Table":"/#tablename.do?JSONv2","UserName":"MYDBDataSync@hcl.com","Password":"D/DhLpnZZb6ZPQn0P/fPTg==","isProxy":"Y","ProxyIPAddress":"10.97.32.18","ProxyPort":"80","ProxyUserName":"hclisd\\iAutomate","ProxyPassword":"wksAY2Z1O/LXH0m7NPRJ1A==","isSSLAuthReq":"N"}]',
'Y','Y')
insert into DataSourceEnvironmentDetails(nmDataSourceId, nmServiceSubTypeId, nmToolId) values(3, 4, 3)
insert into ToolMaster (nmToolId, vcName , vcDescription, vcConnection, nmServiceSubTypeID, vcDatabaseType, vcDBName, vcToolTimeFormat)
values(3, 'Tool', 'Tool' ,'Ykf7DTKOeWWqGJ8Pe3d4yX3XfgRvsp+8WfpH44aKxUc8dwA9mUPMhXdBJ2ihrUUP6B7Tj/w9Ldnm8PT0voSTnaffi064jggDwf4ae7clZMub1Nv6D2dD24W2n0RpjML4L4JwSIQeH+REzO90Nci51Q==', 4, 'SQL', 'Tool.DBO.', 101)
update ServiceSubTypeMaster set chAutomation = 'Y' where nmServiceSubTypeId = 3
update ToolMaster set chiAutomate = 'Y' where nmToolId = 3

select * from DataSourceEnvironmentDetails
update DataSourceEnvironmentDetails set nmToolId = 5 where nmAutoId = 10003
select * from Admin_CustomerMaster

update Admin_CustomerMaster  set vcLogoPath=''

ALTER table Admin_CustomerMaster
Alter COLUMN vcLogoPath VARCHAR(MAX)

select * from DataSourceCustomerDetails

