USE [iMYDB]
GO

/****** Object:  Table [dbo].[ServiceToolField]    Script Date: 10-12-2017 22:29:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].ServiceToolField(
[nmAutoId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
[nmServicetypeId] [numeric](18, 0) NULL,
[vcField] [varchar](50) NULL,
[chActive] [char](1) NULL,
[vcCreatedBy] [varchar](50) NULL,
[dtCreatedOn] [datetime] NULL,
[vcModifiedBy] [varchar](50) NULL,
[dtModifiedOn] [datetime] NULL,
)