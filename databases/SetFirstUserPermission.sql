USE [BMBH_Views]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SetPermission]
		@User = N'WINDEV1712EVAL\User', -- change user here!
		@View = N'V_TITLES'

SELECT	'Return Value' = @return_value

GO
