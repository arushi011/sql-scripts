USE [Tool_Config]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteCustomerToolFilterInList]    Script Date: 13-12-2017 11:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************
** File:    usp_DeleteCustomerToolFilter.sql
** Name:	usp_DeleteCustomerToolFilter
** Desc:	delete customer tool filter list
** Auth:	Vikas Chaturvedi
** Date:	21-Jun-2017
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
*******************************/
alter PROC [dbo].[usp_DeleteCustomerToolFilterInList]
@nmCustomerId INT,
@nmServiceSubTypeId INT,
@nmToolId INT,
@vcCreatedBy VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
UPDATE CustomerToolFilterInList SET chActive='N', vcModifiedBy=@vcModifiedBy, dtModifiedOn=GETUTCDATE() 
WHERE nmCustomerId=@nmCustomerId AND nmServiceSubTypeId=@nmServiceSubTypeId
AND nmToolId=@nmToolId AND chActive='Y'