USE [BMBH_Views]
GO

DECLARE	@User nvarchar(255)
SET @User = 'WINDEV1903EVAL\User' -- change user here!

EXEC [dbo].[SetPermission] @User, @View = N'V_SALES'

IF NOT EXISTS (select 1 from dbo.Roles where RoleId = 1)
BEGIN
	INSERT into dbo.Roles (RoleName)
	values ('Administrator')
END

IF NOT EXISTS (select 1 from dbo.UserRoles where UserId = @User)
BEGIN
	INSERT into dbo.UserRoles (UserId, RoleId)
	values (@User, 1)
END

GO
