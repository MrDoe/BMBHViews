USE [BMBH_Views]
GO

DECLARE	@User nvarchar(255)
SET @User = 'WINDEV1903EVAL\User' -- change user here!

EXEC [dbo].[SetPermission] @User, @View = N'V_SALES'

UPDATE UserRoles
SET UserId = @User
WHERE UserId = 'WINDEV1903EVAL\User'

GO
