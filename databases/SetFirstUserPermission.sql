USE [BMBH_Views]
GO

DECLARE	@User nvarchar(255)
SET @User = N'DOMAIN\USERNAME' -- change user here!

EXEC [dbo].[SetPermission] @User, @View = N'V_SALES'

UPDATE UserRoles
SET UserId = @User
WHERE UserId = 'WINDEV1712EVAL\User'

GO
