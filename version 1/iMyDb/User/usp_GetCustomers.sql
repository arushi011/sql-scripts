ALTER PROC [dbo].[usp_GetCustomers]
@vcUserId VARCHAR(50)
AS
select distinct 
acm.nmCustomerId, acm.vcCustomerName, 
IIF(ucm.nmcustomerid IS NULL or ucm.chActive ='N' or ucm.chActive IS NULL ,0,1) AS isUserSelected
FROM Admin_CustomerMaster acm
left join UserCustomerMapping ucm on acm.nmCustomerId = ucm.nmCustomerId
and ucm.vcUserId = @vcUserId AND ucm.chActive='Y' and acm.chMockCustomer = 'N'
