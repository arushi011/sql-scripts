USE [iMYDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_MapUserCustomersAndServiceSubTypes]    Script Date: 03-12-2017 14:30:05 ******/
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
@vcCommaSepratedCustomers NVARCHAR(MAX),
@vcChangedBy VARCHAR(50)
AS
	
	INSERT INTO UserModuleCustomerMapping (vcuserid,nmcustomerid,nmServiceSubTypeId, chActive, vcCreatedBy, dtCreatedOn, vcModifiedBy, dtModifiedOn)
	(SELECT @vcUserId, ResultSet, @nmServiceSubTypeId, 'Y', @vcChangedBy,GETDATE(), @vcChangedBy, GETDATE()  FROM fnSplitString(@vcCommaSepratedCustomers,','))

	INSERT INTO UserToolMapping (vcUserID,nmToolID,nmServiceSubTypeID,vcDomain,vcToolCustomerName,vcSubCompanyName,vcToolFilter1,
	vcToolFilter2,chActive,chCustom,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn)
	
	(SELECT @vcUserId,ctm.nmToolId, ctm.nmServiceSubTypeId, NULL, acm.vcCustomerName,'N',
	NULL,NULL,'Y','N',@vcChangedBy,GETDATE(),@vcChangedBy,GETDATE() from CustomerToToolMapping ctm
	JOIN fnSplitString(@vcCommaSepratedCustomers,',') cust ON ctm.nmCustomerId=cust.ResultSet AND ctm.nmServiceSubTypeId=@nmServiceSubTypeId
	JOIN Admin_CustomerMaster acm ON cust.ResultSet=acm.nmCustomerId)
