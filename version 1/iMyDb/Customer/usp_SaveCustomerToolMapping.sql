USE [iMYDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveCustomerToolMapping]    Script Date: 11-12-2017 13:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************
** File:    usp_SaveCustomerToolMapping.sql
** Name:	usp_SaveCustomerToolMapping
** Desc:	Save customer tool mapping
** Auth:	Vikas Chaturvedi
** Date:	01-May-2017
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
** 1    06-Jan-2017	Vikas	added chStartAnalysis
** 2    11-Dec-2017 Arushi	added nmdatasourceId filter to get vcvalue from CustomerDataSourceMapping
*******************************/
ALTER PROC [dbo].[usp_SaveCustomerToolMapping]
@envDetailAutoId INT,
@nmCustomerId INT,
@vcFilterXML XML,
@vcFilterWhereClause VARCHAR(MAX),
@vcCustomerFieldName VARCHAR(50),
@chStartAnalysis VARCHAR(1),
@vcCreatedBy VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
BEGIN TRY
    BEGIN TRANSACTION
		DECLARE @nmServiceSubTypeId INT
		DECLARE @nmDataSourceId INT
		DECLARE @nmToolId INT
		DECLARE @vcCustomerFieldValue VARCHAR(MAX)
		DECLARE @nmAutoId INT
		SELECT @nmServiceSubTypeId=nmServiceSubTypeId,@nmToolId=nmToolId, @nmDataSourceId= nmDataSourceId FROM DataSourceEnvironmentDetails WHERE nmAutoId=@envDetailAutoId

		SELECT TOP 1 @vcCustomerFieldValue=vcValue FROM CustomerDataSourceMapping WHERE nmCustomerId=@nmCustomerId and nmDataSourceId=@nmDataSourceId

		INSERT INTO CustomerToToolMapping (nmCustomerId, nmDataSourceId, nmServiceSubTypeId, nmToolId, vcCustomerFieldName, vcCustomerFieldValue, 
											vcFilterXML, vcFilterWhereClause, chActive, chStartAnalysis, vcCreatedBy, vcModifiedBy)
		VALUES (@nmCustomerId, @nmDataSourceId, @nmServiceSubTypeId, @nmToolId, @vcCustomerFieldName, @vcCustomerFieldValue, @vcFilterXML,
				@vcFilterWhereClause,'Y', @chStartAnalysis, @vcCreatedBy,@vcModifiedBy)
		
		SET @nmAutoId=@@IDENTITY
		SELECT nmCustomerId,nmServiceSubTypeId,nmToolId,vcCustomerFieldName,vcCustomerFieldValue FROM CustomerToToolMapping
		WHERE nmAutoId=@nmAutoId
		
		 EXEC ManageCustomerAnalysisJobs @nmDataSourceId,@nmToolId,@nmCustomerId,@nmServiceSubTypeId,@chStartAnalysis
		COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN
END CATCH
