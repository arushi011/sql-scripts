ALTER PROC [dbo].[usp_UpdateCustomer]
@nmCustomerId INT,
@vcCustomerName VARCHAR(200),
@chActive CHAR(1),
@vcLogoPath varchar(MAX),
@vcModifiedby varchar(50)
AS
BEGIN 
BEGIN TRY 
BEGIN TRAN
       UPDATE Admin_CustomerMaster SET vcCustomerName=@vcCustomerName, chActive=@chActive,vcLogoPath=@vcLogoPath,
	   vcModifiedBy=@vcModifiedby,dtModifiedOn=GETUTCDATE()
       WHERE nmCustomerId=@nmCustomerId
       delete CustomerDataSourceMapping WHERE nmCustomerId=@nmCustomerId
       update CustomerToToolMapping set chActive = 'N' WHERE nmCustomerId=@nmCustomerId
Select  '1'
	SELECT 'Updated  Successful'
  COMMIT
END TRY

BEGIN CATCH
 IF @@ERROR <> 0
	 Begin
	 
       ROLLBACK

       SELECT ERROR_MESSAGE()
    
     End

END CATCH

END
