USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[SetPermission]    Script Date: 09.05.2019 09:57:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SetPermission]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255),
	@View nvarchar(255)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

--EXEC sp_configure 'remote query timeout', 0 ;  
--RECONFIGURE;  

-- Insert statements for procedure here
--EXEC sp_addrolemember N'db_datareader', @User
--EXEC sp_addrolemember N'db_datawriter', @User
EXEC('use BMBH_Views
GRANT CONNECT TO [' + @User + ']
GRANT EXECUTE ON [dbo].[GetPanels] TO [' + @User + '] 
GRANT EXECUTE ON [dbo].[RecreateSearchTableForUser] TO [' + @User + '] 
GRANT EXECUTE ON [dbo].[GetPermittedViews] TO [' + @User + '] 
GRANT EXECUTE ON [dbo].[CreateSTARLIMScart] TO [' + @User + '] 
GRANT VIEW DEFINITION ON [dbo].[GetPermittedViews] TO [' + @User + ']
GRANT CONTROL ON [dbo].[GetPermittedViews] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '_SearchForm] TO [' + @User + ']
GRANT UPDATE ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT INSERT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT DELETE ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT SELECT ON [dbo].[V_Save_Search] TO [' + @User + ']
GRANT INSERT ON [dbo].[V_Save_Search] TO [' + @User + ']
GRANT UPDATE ON [dbo].[V_Save_Search] TO [' + @User + ']
GRANT DELETE ON [dbo].[V_Save_Search] TO [' + @User + ']
GRANT SELECT ON [dbo].[V_Recursive_Log] TO [' + @User + ']
GRANT INSERT ON [dbo].[V_Recursive_Log] TO [' + @User + ']
GRANT UPDATE ON [dbo].[V_Recursive_Log] TO [' + @User + ']
GRANT DELETE ON [dbo].[V_Recursive_Log] TO [' + @User + ']
GRANT SELECT ON [dbo].[V_Recursive_Temp] TO [' + @User + ']
GRANT INSERT ON [dbo].[V_Recursive_Temp] TO [' + @User + ']
GRANT DELETE ON [dbo].[V_Recursive_Temp] TO [' + @User + ']
GRANT UPDATE ON [dbo].[V_Recursive_Temp] TO [' + @User + ']
GRANT SELECT ON V_STARLIMS_DEPT TO [' + @User + ']
GRANT SELECT ON V_STARLIMS_USERS TO [' + @User + ']');
END



