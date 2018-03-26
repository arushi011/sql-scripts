select * from UserCustomerMapping where chActive = 'Y'  
select * from tool_config.dbo.userCustomerToolFilter where chActive = 'Y'
select * from UserModuleCustomerMapping where chActive = 'Y'  
select * from UserToolMapping where chActive = 'Y' 
select * from UserMaster
select * from CustomerToToolMapping where chActive = 'Y'
--select * from ServiceToolField
--delete from UserCustomerMapping where chActive = 'N'
--delete from tool_config.dbo.UserCustomerToolFilter
--delete from UserModuleCustomerMapping 
--delete from UserToolMapping where nmToolID <> 0 and nmServiceSubTypeID <> 0 
--delete from UserMaster where nmAutoId <> 1
select * from UserRoleMaster
select * from UserReportValueMappings
--delete from UserRoleMaster where nmAutoId <>1
select * from Tool_config.dbo.CustomerToolFilter
select * from DataSourceEnvironmentDetails
select * from servicetypemaster
select * from UserToolMapping
select * from ServiceSubTypeMaster
select * from ServiceToolField
--delete from ServiceToolField where nmAutoId = 2
--insert into ServiceToolField(nmServiceTypeId,vcField,chActive) values(1,'vcDomain','Y')
select * from CustomerToToolMapping
--select * from Admin_CustomerMaster
--select * from Admin_CustomerRoleMapping
--select * from ToolTypeMaster
--select * from ToolDatabaseDetail
--select * from CustomerToToolMapping
--select * from CUSTOMERDATASOURCEMAPPING
--select * from ServiceSubTypeMaster
--select * from tool_config.dbo.ToolTables
--select * from Tool_Config.dbo.TableColumns
--select * from Tool_Config.dbo.Admin_ModuleColumns  
--select * from Tool_Config.dbo.CodeTypeMaster
--select * from Tool_Config.dbo.CodeMaster
--select * from Tool_Config.dbo.UserCustomerToolFilter
--select * from Tool_Config.dbo.ProcedureConfiguration
--select * from Admin_CustomerRoleMapping
--select * from ComponentMaster
--select * from DataSourceCustomerDetails
select * from UserToolMapping

