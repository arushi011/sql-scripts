ALTER PROC [dbo].[usp_SaveCustomer]
@vcCustomerName VARCHAR(200),
@vcCustomerDescription VARCHAR(500),
@vcLogoPath VARCHAR(MAX),
@chIsRepositoryCustomer CHAR(1),
@chCustom CHAR(1),
@chActive CHAR(1),
@vcCreatedBy VARCHAR(50),
@vcModifiedBy VARCHAR(50)
AS
DECLARE @nmCustomerId AS INT
SELECT @nmCustomerId=(ISNULL(MAX(nmCustomerId),0)+1) FROM Admin_CustomerMaster
INSERT INTO Admin_CustomerMaster (nmCustomerId, vcCustomerName, vcCustomerDescription, vcLogoPath, 
			chIsRepositoryCustomer, chCustom, chActive, vcCreatedBy, vcModifiedBy)
VALUES (@nmCustomerId, @vcCustomerName,@vcCustomerDescription,@vcLogoPath,@chIsRepositoryCustomer,
		@chCustom, @chActive,@vcCreatedBy,@vcModifiedBy)
SELECT @nmCustomerId AS nmCustomerId

