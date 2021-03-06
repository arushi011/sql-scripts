USE [Tool_Config]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteCustomerToolFilter]    Script Date: 13-12-2017 11:56:56 ******/
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
ALTER PROC [dbo].[usp_DeleteCustomerToolFilter]
@nmCustomerId INT,
@vcModifiedBy VARCHAR(50)
AS
UPDATE CustomerToolFilter SET chActive='N', vcModifiedBy=@vcModifiedBy, dtModifiedOn=GETUTCDATE() 
WHERE nmCustomerId=@nmCustomerId AND chActive='Y'