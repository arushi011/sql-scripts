USE [Tool_Config]
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveUserCustomerToolFilter]    Script Date: 12-12-2017 18:18:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************
** File:    usp_SaveUserCustomerToolFilter.sql
** Name:	usp_SaveUserCustomerToolFilter
** Desc:	Save user customer tool filter
** Auth:	Vikas Chaturvedi
** Date:	21-Jun-2017
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
** 1    XXXX		XXXX		XXXXX
*******************************/
ALTER PROC [dbo].[usp_SaveUserCustomerToolFilter]
@nmCustomerId NUMERIC(18,0),
@vcuserid VARCHAR(50),
@nmToolId NUMERIC(18,0),
@nmservicesubtypeid NUMERIC(18,0),
@vcCreatedBy VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
	
	
	INSERT INTO UserCustomerToolFilter (nmCustomerId,vcuserid,nmtoolid,nmservicesubtypeid,
	chActive,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn)
	(
	SELECT nmCustomerId,@vcuserid, nmToolId, nmServiceSubTypeId,'Y',@vcCreatedBy,GETUTCDATE(),@vcModifiedBy,GETUTCDATE() 
	FROM  CustomerToolFilter 
	WHERE nmCustomerId=@nmCustomerId and nmServiceSubTypeId=@nmservicesubtypeid AND chActive='Y' and nmToolId=@nmToolId
	)
