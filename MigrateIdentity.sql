INSERT INTO AspNetUsers(
Id,
UserName,
PasswordHash,
SecurityStamp,
Email,
EmailConfirmed,
PhoneNumber,
PhoneNumberConfirmed,
TwoFactorEnabled,
LockoutEnabled,
AccessFailedCount,
UserFullName -- CUSTOM OLD FIELDS FROM LEGACY DATABASE THAT NEED MIGRATION
)
SELECT
aspnet_Users.UserId,
aspnet_Users.UserName,
(aspnet_Membership.Password+'|'+CAST(aspnet_Membership.PasswordFormat as varchar)+'|'+aspnet_Membership.PasswordSalt),
NewID(),
aspnet_Membership.Email,
1,
'N/A',
1,
0,
0,
0,
aspnet_Users.UserFullName -- CUSTOM OLD FIELDS FROM LEGACY DATABASE THAT NEED MIGRATION
FROM aspnet_Users
LEFT OUTER JOIN aspnet_Membership ON aspnet_Membership.ApplicationId = aspnet_Users.ApplicationId 
AND aspnet_Users.UserId = aspnet_Membership.UserId;

INSERT INTO AspNetRoles(Id,Name,NormalizedName)
SELECT RoleId,RoleName,UPPER(RoleName)
FROM aspnet_Roles;


INSERT INTO AspNetUserRoles(UserId,RoleId)
SELECT UserId,RoleId
FROM aspnet_UsersInRoles;
