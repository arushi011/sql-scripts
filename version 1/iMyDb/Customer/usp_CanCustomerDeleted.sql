ALTER PROC [dbo].[usp_CanCustomerDeleted]
@customerId INT
AS
DECLARE @vcCustomerName VARCHAR(MAX)
SELECT IIF((select TOP 1 1 from UserCustomerMapping where nmCustomerId=@customerId AND chActive='Y') IS NULL,1,0) CanCustomerDeleted



