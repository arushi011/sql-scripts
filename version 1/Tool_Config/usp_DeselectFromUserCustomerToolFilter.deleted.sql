USE [Tool_Config]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeselectFromUserCustomerToolFilter]    Script Date: 09-12-2017 18:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROC [dbo].[usp_DeselectFromUserCustomerToolFilter]
@nmCustomerId NUMERIC(18,0),
@vcuserid VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
DECLARE @nmtoolid NUMERIC(18,0)
	
	UPDATE UserCustomerToolFilter SET chActive='N',vcModifiedBy=@vcModifiedBy,dtModifiedOn=GETDATE()
	WHERE nmCustomerId=@nmCustomerId AND vcuserid=@vcuserid
	AND chActive='Y'
