USE [iMYDB]
GO
/****** Object:  StoredProcedure [dbo].[Admin_UpdateUserDetails]    Script Date: 08-12-2017 17:09:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Admin_UpdateUserDetails]    
    
(    
    
@vcCommonXML AS XML,    
    
@vcUserXML AS XML,  
  
@vcActionType AS VARCHAR(50)    
    
)    
    
AS    
    
SET NOCOUNT ON    
    
    
    
Declare @MyDashboardProdMode as VARCHAR(50) , @LoggedinUserRoleID as VARCHAR(50) ,@LoggedinUserID as VARCHAR(50)     
    
    
    
SELECT @MyDashboardProdMode = t.c.value('MyDashboardProdMode[1]', 'VARCHAR(50)')     
    
, @LoggedinUserID = t.c.value('LoggedInUserId[1]', 'VARCHAR(50)')     
    
, @LoggedinUserRoleID = t.c.value('LoggedInUserRoleId[1]', 'VARCHAR(50)')     
    
FROM @vcCommonXML.nodes('/clsMyDBCommonAttrEntity') t(c);    
    
    
    
Declare @chCustom varchar(50) = 'N'    
    
	    
Declare @CustomersCommaSeprated as NVARCHAR(MAX) , @RoleID as VARCHAR(50) , @CQBUserRole as VARCHAR(50)= Null , @AuthenticationType as VARCHAR(50) , @UserID as VARCHAR(50)     
    
, @AD_SSO_ID as VARCHAR(50)= NULL , @Password as VARCHAR(50) , @Name as VARCHAR(200) , @Email as VARCHAR(100) , @Domain as VARCHAR(200)  =NULL   
    
, @UserOrganization as VARCHAR(200) , @DefaultPage as VARCHAR(100) , @UserTheme as VARCHAR(50) , @IsUnlimitedAccess as VARCHAR(50)    
    
, @ValidDays as VARCHAR(10) , @ValidHours as VARCHAR(10) , @isLogging as VARCHAR(50) , @AutoRefresh as VARCHAR(50), @iRefreshInterval as VARCHAR(10)     
    
, @UserTimeZone as VARCHAR(50) , @UserDateFormat as VARCHAR(50) , @IsActive as VARCHAR(50), @vcLDAPID as VARCHAR(100)
    
     
    
SELECT @CustomersCommaSeprated = t.c.value('CustomersCommaSeprated[1]', 'VARCHAR(50)')     
    
, @RoleID = t.c.value('RoleID[1]', 'VARCHAR(50)')     
    
, @CQBUserRole = t.c.value('CQBUserRole[1]', 'VARCHAR(50)')     
    
, @AuthenticationType = t.c.value('AuthenticationType[1]', 'VARCHAR(50)')     
    
, @UserID = t.c.value('UserID[1]', 'VARCHAR(50)')     
    
, @Password = t.c.value('Password[1]', 'VARCHAR(50)')     
    
, @Name = t.c.value('Name[1]', 'VARCHAR(200)')     
    
, @Email = t.c.value('Email[1]', 'VARCHAR(100)')       
    
, @DefaultPage = t.c.value('DefaultPage[1]', 'VARCHAR(100)')     
    
, @UserTheme = t.c.value('UserTheme[1]', 'VARCHAR(50)')          
    
, @UserTimeZone = t.c.value('UserTimeZone[1]', 'VARCHAR(50)')     
    
, @UserDateFormat = t.c.value('UserDateFormat[1]', 'VARCHAR(50)')     
    
, @IsActive = t.c.value('IsActive[1]', 'VARCHAR(50)')

,@vcLDAPID=t.c.value('vcLDAPID[1]', 'VARCHAR(100)')
    
FROM @vcUserXML.nodes('/clsUserEntity') t(c);    
    
    
  
  if(@vcActionType='ADD')  
  
  BEGIN  
   
    
  IF (EXISTS(SELECT 1 from UserMaster where vcUserId=@UserID))    
    
  BEGIN    
    
   Select 'User with the same User ID already exists.' Message1;    
    
   return;    
    
 END  
  
 END  

 if(@vcActionType='RESETPSW')  
 BEGIN
 IF (Not EXISTS(SELECT 1 from UserMaster where vcUserId=@UserID))    
  BEGIN 
  Select 'User with this User ID does not exists.' Message1;    
   return;
  END
   IF ((SELECT vcPropertyValue from iConfiguration where vcPropertyName='password.reset' and chActive='Y')='Y')  
  BEGIN 
  Select 'You are now allowed to reset password again.' Message1;    
   return;
  END
  END


 Begin Try    
    
   Begin Tran T1    
    
    
   IF(@vcActionType='ADD')    
    
   BEGIN    
    
    INSERT INTO UserMaster    
    
    (vcUserId,vcUserName,vcPassword,vcEmailId,vcMYDBCustomerName,nmValidateDays,nmValidateHrs,vcRedirectPath,chUnlimitedAccess,    
    
    vcDomain,vcAuthenticationType,vcAltUserId,chLogging, chAutoRefresh,inRefreshInterval,vcCQBUserRole,    
    
    chChangePassword,vcUserOrganization,nmUserTimeZoneId,vcUserTimeFormat,nmUserTimeOffset,    
    
    chUserTimeDSTEnabled,vcUserTheme,chActive,chCustom,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn, vcTabsOffsetLeft,vcLDAPID)    
    
    VALUES(@UserID,@Name,@Password,@Email,NULL,'0','0',@DefaultPage,'Y',    
    
    NULL,@AuthenticationType,NULL,'N','N','0',NULL,    
    
    'Y','HCL',@UserTimeZone,@UserDateFormat,0,NULL,@UserTheme,    
    
    'Y',NULL,@LoggedinUserID,GETDATE() ,@LoggedinUserID ,GETDATE(),NULL,@vcLDAPID );    
    
        
    
    INSERT INTO UserRoleMaster    
    
    (vcUserID,nmRoleID,chActive,chCustom,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn)    
    
    Values (@UserID,@RoleID,'Y','N',@LoggedinUserID,GETDATE() ,@LoggedinUserID ,GETDATE());    
    
    INSERT INTO UserToolMapping  
    (vcUserID,nmToolID,nmServiceSubTypeID,vcDomain,vcToolCustomerName,vcSubCompanyName
    ,chActive,chCustom,vcCreatedBy,dtCreatedOn,vcModifiedBy,dtModifiedOn)  
    SELECT   
     @UserID,  
     0 nmToolID, --this will be the base connection string  
     0 nmServiceSubTypeID,  --this will be the base service sub type id
     null vcDomain,  
      @CustomersCommaSeprated,  
     'N' vcSubCompanyName,  
     'Y' chActive,@chCustom chCustom,@LoggedinUserID vcCreatedBy,GETDATE() dtCreatedOn,  
     @LoggedinUserID vcModifiedBy,GETDATE() dtModifiedOn 


	INSERT INTO UserCustomerMapping (nmcustomerid, vcuserid, chActive, vcCreatedBy, vcModifiedBy)
	(SELECT ResultSet, @UserID, 'Y', @LoggedinUserID, @LoggedinUserID  FROM fnSplitString(@CustomersCommaSeprated, ','))

    
   END    
    
   ELSE IF(@vcActionType='UPDATE')    
    
   BEGIN    
  
    UPDATE UserMaster  SET vcUserName=@Name, vcPassword=@Password,vcEmailId=@Email,vcMYDBCustomerName=NULL,vcRedirectPath=@DefaultPage  
   
    ,vcAuthenticationType=@AuthenticationType    
    
    ,nmUserTimeZoneId=@UserTimeZone,vcUserTimeFormat=@UserDateFormat,vcUserTheme=@UserTheme,chActive=@IsActive  
    
    ,vcModifiedBy=@LoggedinUserID,dtModifiedOn=GETDATE(),vcLDAPID=@vcLDAPID WHERE vcUserID=@UserID and chActive = 'Y';    
    
    
    
    UPDATE UserRoleMaster SET nmRoleID=@RoleID, vcModifiedBy=@LoggedinUserID,dtModifiedOn=GETDATE() WHERE vcUserID=@UserID and chActive = 'Y';  
	
	update  UserToolMapping set vcToolCustomerName = @CustomersCommaSeprated, vcModifiedBy = @LoggedinUserID, dtModifiedOn = GETDATE()
	where vcUserID = @UserID and nmToolID = 0 and nmServiceSubTypeID = 0 and
	vcSubCompanyName = 'N'and chActive = 'Y'
    
	update UserCustomerMapping set chActive = 'N', vcModifiedBy = @LoggedinUserID, dtModifiedOn = GETUTCDATE() WHERE vcUserID=@UserID AND chActive='Y'; 
	INSERT INTO UserCustomerMapping (nmcustomerid, vcuserid, chActive, vcCreatedBy, vcModifiedBy)
	(SELECT ResultSet, @UserID, 'Y', @LoggedinUserID, @LoggedinUserID FROM fnSplitString(@CustomersCommaSeprated, ','))
    
   END    

 ELSE IF(@vcActionType='RESETPSW')  
  
  BEGIN 
  
  IF (EXISTS(SELECT 1 from UserMaster where vcUserId=@UserID))    
    
  BEGIN 
   update UserMaster set vcPassword=@Password where vcUserID=@UserID;   
   update iConfiguration set vcPropertyValue='Y' where vcPropertyName='password.reset' and chActive='Y';
  END

  END
    
  Commit Tran T1    
    
       select '' Message1    
    
End Try    
    
Begin Catch    
    
       Rollback Tran T1    
    
       Select '' Message1, ERROR_MESSAGE() As ErrorMessage;    
    
End Catch    
    
    
    
SET NOCOUNT OFF    


