USE [Tool_Config]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteUserCustomerToolFilter]    Script Date: 13-12-2017 15:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************
** File:    usp_DeleteUserCustomerToolFilter.sql
** Name:	usp_DeleteUserCustomerToolFilter
** Desc:	delete user customer tool filter
** Auth:	Vikas Chaturvedi
** Date:	22-Jun-2017
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
** 1    XXXX		XXXX		XXXXX
*******************************/
ALTER PROC [dbo].[usp_DeleteUserCustomerToolFilter]
@nmCustomerId NUMERIC(18,0),
@vcuserid VARCHAR(50),
@nmservicesubtypeid NUMERIC(18,0),
@vcCreatedBy VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
DECLARE @nmtoolid NUMERIC(18,0)
	UPDATE UserCustomerToolFilter SET chActive='N',vcModifiedBy=@vcModifiedBy,dtModifiedOn=GETDATE()
	WHERE nmCustomerId=@nmCustomerId AND vcuserid=@vcuserid
	--AND nmservicesubtypeid=@nmservicesubtypeid 
	AND chActive='Y'
	
