USE [iMYDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_MapUserCustomersAndServiceSubTypes]    Script Date: 09-12-2017 19:28:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************
** File:    usp_MapUserCustomersAndServiceSubTypes.sql
** Name:	usp_MapUserCustomersAndServiceSubTypes
** Desc:	map user modules and customers
** Auth:	Vikas Chaturvedi
** Date:	15-Jun-2017
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
** 1    XXXX		XXXX		XXXXX
*******************************/
ALTER PROC [dbo].[usp_MapUserCustomersAndServiceSubTypes]
@vcUserId VARCHAR(50),
@nmServiceSubTypeId NUMERIC(18,0),
@nmCustomerId VARCHAR(50),
@nmDataSourceId VARCHAR(50),
@vcChangedBy VARCHAR(50)
AS
	
	INSERT INTO UserModuleCustomerMapping (vcuserid,nmcustomerid,nmServiceSubTypeId , nmDataSourceId, chActive, vcCreatedBy, dtCreatedOn, vcModifiedBy, dtModifiedOn)
	VALUES(@vcUserId,@nmCustomerId, @nmServiceSubTypeId, @nmDataSourceId, 'Y', @vcChangedBy,GETDATE(), @vcChangedBy, GETDATE())

	INSERT INTO UserToolMapping (vcUserID,nmToolID,nmServiceSubTypeID,vcDomain,vcToolCustomerName,vcSubCompanyName,vcToolFilter1,
	vcToolFilter2,chActive,chCustom,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn)
	(select distinct
	@vcUserId,ctm.nmToolId, ctm.nmServiceSubTypeId, NULL, acm.vcCustomerName,'N',
	NULL,NULL,'Y','N',@vcChangedBy,GETDATE(),@vcChangedBy,GETDATE() 
	from CustomerToToolMapping ctm 
	--JOIN fnSplitString(@vcCommaSepratedCustomers,',') cust
	JOIN Admin_CustomerMaster acm ON acm.nmCustomerId = ctm.nmCustomerId
	Where ctm.nmCustomerId=@nmCustomerId and ctm.nmDataSourceId = @nmDataSourceId
	AND ctm.nmServiceSubTypeId=@nmServiceSubTypeId)

	declare @vcFieldValue varchar(50) = '', @vcFieldName varchar(50) = '', @serviceTypeId varchar(50) = '', @sql varchar(max) = '', @customerName varchar(100) = '', @nmToolId varchar(50) = ''
	
	select @vcFieldValue = ctm.vcCustomerFieldValue, @nmToolId = ctm.nmToolId from CustomerToToolMapping ctm where ctm.nmCustomerId = @nmCustomerId and ctm.nmServiceSubTypeId = @nmServiceSubTypeId and nmDataSourceId = @nmDataSourceId
	and ctm.chActive = 'Y'
	select @serviceTypeId =sstm.nmServiceTypeID from ServiceSubTypeMaster sstm where sstm.nmServiceSubTypeId = @nmServiceSubTypeId and chActive = 'Y'
	select @vcFieldName = stf.vcField from serviceToolField stf where stf.nmServiceTypeId = @serviceTypeId and chActive = 'Y'
	select @customerName =  vcCustomerName from Admin_CustomerMaster where nmCustomerId = @nmCustomerId and chActive = 'Y'
	set @sql = 'update UserToolMapping set '+ @vcFieldName +' = '''+ @vcFieldValue +''' where nmServiceSubTypeID = '''+CAST(CAST(@nmServiceSubTypeId AS INT) AS VARCHAR)+''' and vcToolCustomerName = '''+ @customerName +''' and nmToolId = '''+ @nmToolId +''' and vcUserId = '''+ @vcUserId+''' and chActive = ''Y''';
	exec(@sql)