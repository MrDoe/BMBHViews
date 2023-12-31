USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[UploadFile]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UploadFile]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRoleViews]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UpdateRoleViews]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_VALCOUNT]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UPDATE_VALCOUNT]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SEARCH_TABLES]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UPDATE_SEARCH_TABLES]
GO
/****** Object:  StoredProcedure [dbo].[UnsetRolePermission]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UnsetRolePermission]
GO
/****** Object:  StoredProcedure [dbo].[UnsetPermission]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[UnsetPermission]
GO
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[SetUserRole]
GO
/****** Object:  StoredProcedure [dbo].[SetRolePermission]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[SetRolePermission]
GO
/****** Object:  StoredProcedure [dbo].[SetPermission]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[SetPermission]
GO
/****** Object:  StoredProcedure [dbo].[SetDocPermission]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[SetDocPermission]
GO
/****** Object:  StoredProcedure [dbo].[RecreateSearchTableForUser]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[RecreateSearchTableForUser]
GO
/****** Object:  StoredProcedure [dbo].[RecreateSearchTable]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[RecreateSearchTable]
GO
/****** Object:  StoredProcedure [dbo].[GrantPatientSearch]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GrantPatientSearch]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsChecked]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPermittedViewsChecked]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsByRole]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPermittedViewsByRole]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViews]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPermittedViews]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedSearchTables]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPermittedSearchTables]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedDocs]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPermittedDocs]
GO
/****** Object:  StoredProcedure [dbo].[GetPanels]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetPanels]
GO
/****** Object:  StoredProcedure [dbo].[GetAllViews]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetAllViews]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetAllUsers]
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoles]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GetAllRoles]
GO
/****** Object:  StoredProcedure [dbo].[GenerateRoleDocs]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[GenerateRoleDocs]
GO
/****** Object:  StoredProcedure [dbo].[DenyPatientSearch]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[DenyPatientSearch]
GO
/****** Object:  StoredProcedure [dbo].[CreateSTARLIMScart]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[CreateSTARLIMScart]
GO
/****** Object:  StoredProcedure [dbo].[CreateLookups]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[CreateLookups]
GO
/****** Object:  StoredProcedure [dbo].[CreateLookup]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[CreateLookup]
GO
/****** Object:  StoredProcedure [dbo].[Create_SL_View]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[Create_SL_View]
GO
/****** Object:  StoredProcedure [dbo].[CNT_DISTINCT]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[CNT_DISTINCT]
GO
/****** Object:  StoredProcedure [dbo].[AddViewToPanel]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[AddViewToPanel]
GO
/****** Object:  StoredProcedure [dbo].[AddSearchForm]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[AddSearchForm]
GO
/****** Object:  StoredProcedure [dbo].[AddNewUser]    Script Date: 09.05.2019 13:41:38 ******/
DROP PROCEDURE [dbo].[AddNewUser]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09.05.2019 13:41:38 ******/
DROP FUNCTION [dbo].[Split]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split]
(
    @String NVARCHAR(4000),
    @Delimiter NCHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    WITH Split(stpos,endpos)
    AS(
        SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
        UNION ALL
        SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
            FROM Split
            WHERE endpos > 0
    )
    SELECT 'Id' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
        'Data' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
    FROM Split
)
GO
/****** Object:  StoredProcedure [dbo].[AddNewUser]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddNewUser]
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
EXEC ('CREATE LOGIN [' + @UserName + '] FROM WINDOWS WITH DEFAULT_DATABASE=[BMBH_Views]
USE [BMBH_Views]
CREATE USER [' + @UserName + '] FOR LOGIN [' + @UserName + ']
EXEC sp_addrolemember N''db_datareader'', N''' + @UserName + '''
EXEC sp_addrolemember N''db_datawriter'', N''' + @UserName + '''
INSERT INTO UserRoles (UserId, RoleId, AllowPatientSearch) VALUES(''' + @UserName + ''', NULL, ''N'')
USE [CLIN106_DATA]
CREATE USER [' + @UserName + '] FOR LOGIN [' + @UserName + ']
EXEC sp_addrolemember N''db_datareader'', N''' + @UserName + '''
EXEC sp_addrolemember N''db_datawriter'', N''' + @UserName + '''
')
END
GO
/****** Object:  StoredProcedure [dbo].[AddSearchForm]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddSearchForm]
	-- Add the parameters for the stored procedure here
	@View nvarchar(255)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--overwrite
--IF OBJECT_ID(@View + '_Searchform') IS NOT NULL
--BEGIN
--exec('DROP VIEW ' + @View + '_Searchform')
--END

IF OBJECT_ID(@View + '_Searchform') IS NULL
BEGIN
exec( 'CREATE VIEW ' + @View + '_Searchform AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as Sorter
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''' + @View + '''' );
END

-- overwrite
--IF OBJECT_ID(@View + '_Search') IS NOT NULL
--BEGIN
--exec('DROP TABLE ' + @View + '_Search')
--END

IF OBJECT_ID(@View + '_Search') IS NULL
BEGIN
exec( 'CREATE TABLE ' + @View + '_Search(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
	[Logic] [nvarchar](4) NULL,
	[Sorter] [int] NULL,
 CONSTRAINT [PK_' + @View + '_Search] PRIMARY KEY CLUSTERED 
( [ID] ASC ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]' );
END

END

GO
/****** Object:  StoredProcedure [dbo].[AddViewToPanel]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddViewToPanel]
	-- Add the parameters for the stored procedure here
@View nvarchar(255),
@Caption nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin tran;
    -- Insert statements for procedure here
	IF NOT EXISTS (select * from VIEW_SETTINGS where VIEW_NAME = @View)
	BEGIN 
		insert into VIEW_SETTINGS (VIEW_NAME) values (@View)
	END 
	ELSE 
	BEGIN 
		update VIEW_SETTINGS set VIEW_CAPTION = @Caption where VIEW_NAME = @View
	END
	commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[CNT_DISTINCT]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CNT_DISTINCT]
	-- Add the parameters for the stored procedure here
	@Field nvarchar(255),
	@Table nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @sql nvarchar(1024)
DECLARE @Count_ int

SET @sql = N'SELECT @Count = COUNT(distinct [' + @Field+ ']) FROM [' + @Table + ']';
EXECUTE sp_executesql @sql, N'@Count int OUTPUT', @Count = @Count_ OUTPUT;
	
-- Return the result of the function
RETURN @Count_;
END

GO
/****** Object:  StoredProcedure [dbo].[Create_SL_View]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create_SL_View]
-- Add the parameters for the stored procedure here
@ViewName nvarchar(50) = '',
@Template nvarchar(50) = '',
@PatID nvarchar(20) = 'PID',
@StudyID nvarchar(20) = 'STUDY_ID'

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE @SQL nvarchar(max)
SET @SQL = ''
DECLARE @Select as nvarchar(max);
SET @Select = 'select i.INVENTORYID AS ID,s.EXTERNAL_STATUS as [Status],i.EXTERNAL_CODE AS Proben_ID,ma.MATNAME AS Materialtyp,t.AMOUNTLEFT AS Füllmenge,t.AMOUNT_UNIT_CODE AS Einheit,
                      l.LONGNAME AS Lagerort,t.CONTAINER_EXTERNAL_CODE AS Rack_ID,t.CONTAINER_POS_Y AS Zeile,t.CONTAINER_POS_X AS Spalte,b.PID as ' + @PatID + ',b.STUDY_ID as ' + @StudyID + ',';
DECLARE @From nvarchar(max);
SET @From = ' from CLIN106_DATA.dbo.INVENTORY i JOIN CLIN106_DATA.dbo.METADATA m on m.ID=i.METADATA_GUID JOIN CLIN106_DATA.dbo.BMBH_PIDS b on b.INVENTORYID=i.INVENTORYID JOIN CLIN106_DATA.dbo.INVENTORY_TRANSACTIONS t on t.INVENTORYID=i.INVENTORYID and t.FLAG_CURRENT=1 join CLIN106_DATA.dbo.MATERIALS ma on ma.MATCODE=i.MATCODE join CLIN106_DATA.dbo.LOCATIONS l on l.LOCATIONCODE=t.LOCATIONCODE join CLIN106_DATA.dbo.EXTERNAL_STATUS s on s.STATUS = t.STATUS'
DECLARE @Where as nvarchar(max);
SET @Where = ' where i.FLAG_CONTAINER = 0 and m.TEMPLATE_NAME = ''' + @Template + ''''

DECLARE @field_name as nvarchar(50);
DECLARE @internal_field as nvarchar(16);
DECLARE @field_cursor as CURSOR;

SET @field_cursor = CURSOR FOR
select t.FIELD_NAME, 'm.' + SUBSTRING(t.INTERNAL_FIELD_NAME, 10, 7)
from CLIN106_DATA.dbo.METADATA_TEMPLATE_FIELDS t
where t.TEMPLATE_NAME like @Template ESCAPE '\'
and [LANGUAGE] = 'GER'
and [VERSION] = (select [VERSION] from CLIN106_DATA.dbo.V_MAX_TEMPLATE_VERS where TEMPLATE_NAME = @Template)
and t.INTERNAL_FIELD_NAME is not null
order by t.SORTER

OPEN @field_cursor  
FETCH NEXT FROM @field_cursor INTO @field_name, @internal_field  

WHILE @@FETCH_STATUS = 0  
BEGIN  
       SET @Select += @internal_field + ' as ''' + @field_name + ''','
       FETCH NEXT FROM @field_cursor INTO @field_name, @internal_field  
END  
CLOSE @field_cursor  
DEALLOCATE @field_cursor
SET @Select = Substring(@Select, 1, Len(@Select)-1)
SET @SQL = 'Create View [' + @ViewName + '] as ' + @Select + @From + @Where
EXEC(@SQL);
END

GO
/****** Object:  StoredProcedure [dbo].[CreateLookup]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateLookup]
	-- Add the parameters for the stored procedure here
	@ViewName nvarchar(50),
	@Attribute nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC('insert into Lookups (ViewName, Attribute, Value)
		  select distinct ''' +  @ViewName + ''',''' + @Attribute + ''',' + @Attribute + ' from ' + @ViewName)
END
GO
/****** Object:  StoredProcedure [dbo].[CreateLookups]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateLookups]
	-- Add the parameters for the stored procedure here
	@ViewName nvarchar(50)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

CREATE TABLE #Temp (Attribut nvarchar(50))
EXEC('insert into #Temp (Attribut) 
	  select s.Attribut
	  from ' + @ViewName + '_Searchform s
	  join V_VALUECNT v on v.Attribut = s.Attribut COLLATE SQL_Latin1_General_CP1_CI_AI
	  where v.ViewName = ''' + @ViewName + ''' COLLATE SQL_Latin1_General_CP1_CI_AI
	  and v.ValueCnt <= 100 order by s.Sorter')

EXEC('delete from Lookups where ViewName = ''' + @ViewName + '''')

DECLARE db_cursor CURSOR FOR 
SELECT Attribut FROM #Temp

DECLARE @Attribut NVARCHAR(50);

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @Attribut
WHILE @@FETCH_STATUS = 0  
BEGIN 
	EXEC [dbo].[CreateLookup] @ViewName = @ViewName, @Attribute = @Attribut
	FETCH NEXT FROM db_cursor INTO @Attribut
END

CLOSE db_cursor  
DEALLOCATE db_cursor 
DROP TABLE #Temp;

END
GO
/****** Object:  StoredProcedure [dbo].[CreateSTARLIMScart]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateSTARLIMScart]
	-- Add the parameters for the stored procedure here
	@CartName nvarchar(255),
	@UserName nvarchar(15),
	@GUID uniqueidentifier,
	@Iteration int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @OrigUser nvarchar(255);
	SET @OrigUser = ORIGINAL_LOGIN();
	
    -- Insert statements for procedure here
   BEGIN TRANSACTION;
		EXEC sp_getapplock @Resource='CLIN106_DATA.dbo.LIMSCOUNTERS', @LockMode='Exclusive';
		EXEC sp_getapplock @Resource='CLIN106_DATA.dbo.CART', @LockMode='Exclusive';
		
		DECLARE @nMaxID int;
		select @nMaxID = max(CART_ID) FROM CLIN106_DATA.dbo.CART;
		SET @nMaxID = @nMaxID + 1;
		update CLIN106_DATA.dbo.LIMSCOUNTERS set LIMSCOUNTER = @nMaxID where TABLNAME = 'CART_ID';
			
		DECLARE @sCartNo nvarchar(255);
		SET @sCartNo = CAST(@nMaxID AS NVARCHAR(255)) + '.1';

		INSERT INTO CLIN106_DATA.dbo.CART
		(CART_ID, CART_NAME, CART_DESC, USRNAM, CREATED_DT, OBJECT_TYPE, CREATOR, CART_ID_VER)
		values (@nMaxID, @CartName, null, @UserName, GetDate(), 'BioRepository', @OrigUser, @sCartNo)

   		DECLARE @nCartOrigRec int;
		SELECT @nCartOrigRec = MAX(ORIGREC) from CLIN106_DATA.dbo.CART;
   COMMIT;
   	
	insert into CLIN106_DATA.dbo.CART_ITEMS (CART_ORIGREC, ITEM_ORIGREC) 
	select @nCartOrigRec, i.ORIGREC
	from CLIN106_DATA.dbo.INVENTORY i 
	join BMBH_VIEWS.dbo.V_RECURSIVE_TEMP s on s.ID = i.INVENTORYID
	where s.[GUID] = @GUID and s.[Iteration] = @Iteration-1
	
	DECLARE @AlertID int;
	Select @AlertID = Max(AlertID) from CLIN106_DATA.dbo.ALERTS_MGMT;
	SET @AlertID = @AlertID + 1;
	
	BEGIN TRANSACTION;
		EXEC sp_getapplock @Resource='CLIN106_DATA.dbo.LIMSCOUNTERS', @LockMode='Exclusive';	    
		EXEC sp_getapplock @Resource='CLIN106_DATA.dbo.ALERTS_MGMT', @LockMode='Exclusive';	    
		EXEC sp_getapplock @Resource='CLIN106_DATA.dbo.ALERTS_USERS', @LockMode='Exclusive';	    
		UPDATE CLIN106_DATA.dbo.LIMSCOUNTERS set LIMSCOUNTER = @AlertID where TABLNAME = 'ALERTS_MGMT' and FLDNAME = 'ALERTID';

		Insert into CLIN106_DATA.dbo.ALERTS_MGMT
		(ALERTID, DATECREATED, CREATEDBY, [STATUS], ORIGSTS, ALERTMESSAGE) 
		values (@AlertID, GetDate(), @OrigUser, 'Draft', 'A', 'Der Benutzer ''' + @OrigUser + ''' hat Ihnen von BMBH-Views die Liste '''+ @CartName+ ''' geschickt.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + 'Listennummer: [' + @sCartNo + ']')	

		Insert into CLIN106_DATA.dbo.ALERTS_USERS(ALERTID,USRNAM) 
		values (@AlertID, @UserName);
	COMMIT;
	
	Update CLIN106_DATA.dbo.ALERTS_MGMT set [STATUS] = 'Pending Acknowledgement' where ALERTID = @AlertID
	Update CLIN106_DATA.dbo.ALERTS_USERS set DATENOTIFIED = GetDate() where ALERTID = @AlertID
END
GO
/****** Object:  StoredProcedure [dbo].[DenyPatientSearch]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DenyPatientSearch]
@User nvarchar(255) 
AS
BEGIN
SET NOCOUNT ON;
UPDATE UserRoles SET AllowPatientSearch = 'N' WHERE UserId = @User;
EXEC('DENY SELECT ON V_PatientSearch_BP TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_BP_PSD TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('DENY INSERT ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('DENY UPDATE ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('DENY DELETE ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_BP_Searchform TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_HN TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_HN_Searchform TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('DENY INSERT ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('DENY UPDATE ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('DENY DELETE ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IF TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IF_PSD TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IF_Searchform TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('DENY INSERT ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('DENY UPDATE ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('DENY DELETE ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IP TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IP_PSD TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IP_Searchform TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('DENY INSERT ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('DENY UPDATE ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('DENY DELETE ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_NVG TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_NVG_Searchform TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('DENY INSERT ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('DENY UPDATE ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('DENY DELETE ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('DENY SELECT ON V_PatientSearch_NVG_PSD TO [' + @User + ']');
EXEC master.dbo.sp_droplinkedsrvlogin @rmtsrvname = N'MYSQL', @locallogin = @User;
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRoleDocs]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christoph Döllinger
-- Create date: 07.05.2019
-- Description:	Generates RoleDoc entries
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRoleDocs] 
	-- Add the parameters for the stored procedure here
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into RoleDocs
	([RoleId]
    ,[DocId]
    ,[Permission])
	select @RoleId, DocId, 0
	from Documents
	where DocID not in (select DocID from RoleDocs where RoleId = @RoleId)
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoles]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllRoles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT NULL as RoleId, NULL as RoleName
	union
	SELECT RoleId, RoleName
	from Roles
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllUsers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select name from sys.server_principals where type_desc = 'WINDOWS_LOGIN' and name NOT LIKE 'NT%' order by name
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllViews]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllViews]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Temp as Table
(
    table_qualifier    sysname,
    table_owner        nvarchar(384),
    table_name         nvarchar(384),
    table_type         varchar(100),
    fUsePattern        bit
)

INSERT INTO @Temp
EXEC sp_tables 'V_%', 'dbo', 'BMBH_Views'

select table_name from @Temp
where table_type = 'VIEW' and table_name not like '%_SearchForm'
order by table_name
END

GO
/****** Object:  StoredProcedure [dbo].[GetPanels]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPanels]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM PANELS order by Sorter;
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedDocs]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christoph Döllinger
-- Create date: 08.05.2019
-- Description:	Get all documents for user
-- =============================================
CREATE PROCEDURE [dbo].[GetPermittedDocs] 
	-- Add the parameters for the stored procedure here
	@User nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [FilePath]
		  ,[ShortName]
		  ,[PanelID]
		  ,[Sorter]
		  ,[Description]
	FROM [BMBH_Views].[dbo].[RoleDocs] r
	JOIN [BMBH_Views].[dbo].[Documents] d on d.DocID = r.DocId
	JOIN [BMBH_Views].[dbo].[UserRoles] u on u.RoleId = r.RoleId
	WHERE u.UserId = @User and r.Permission = 1
	order by PanelID, Sorter
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedSearchTables]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPermittedSearchTables]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Temp as Table
(
TABLE_QUALIFIER nvarchar(128),
TABLE_OWNER nvarchar(128),
TABLE_NAME nvarchar(128),
GRANTOR nvarchar(128),
GRANTEE nvarchar(128),
PRIVILEDGE nvarchar(20),
IS_GRANTABLE nvarchar(3)
)

INSERT INTO @Temp
EXEC sp_table_privileges
   @table_name = 'V_%_Search'

select TABLE_NAME from @Temp
where PRIVILEDGE = 'SELECT'
and GRANTEE = @User
END

GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViews]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPermittedViews]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Temp as Table
(
TABLE_QUALIFIER nvarchar(128),
TABLE_OWNER nvarchar(128),
TABLE_NAME nvarchar(128),
GRANTOR nvarchar(128),
GRANTEE nvarchar(128),
PRIVILEDGE nvarchar(20),
IS_GRANTABLE nvarchar(3)
)

INSERT INTO @Temp
EXEC sp_table_privileges
   @table_name = 'V_%' 

select t.TABLE_NAME, s.VIEW_CAPTION, s.PANEL_NAME, s.SORTER
from @Temp t
left join VIEW_SETTINGS s on s.VIEW_NAME = t.TABLE_NAME COLLATE SQL_Latin1_General_CP1_CI_AS
left join PANELS p on p.PanelID = s.PANEL_NAME COLLATE SQL_Latin1_General_CP1_CI_AS
where t.PRIVILEDGE = 'SELECT' COLLATE SQL_Latin1_General_CP1_CI_AS
and t.GRANTEE = @User COLLATE SQL_Latin1_General_CP1_CI_AS
and s.PANEL_NAME is not null
order by p.Sorter, s.Sorter
END

GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsByRole]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPermittedViewsByRole]
	-- Add the parameters for the stored procedure here
	@RoleId nvarchar(50),
	@ViewName nvarchar(120)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here    
	IF Len(@ViewName) = 0 
		EXEC('select r.ViewName, Permission, s.VIEW_CAPTION, s.PANEL_NAME, s.USE_LOOKUPS, s.SORTER
			  from RoleViews r
			  LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = r.ViewName
			  where r.RoleId=' + @RoleId + ' and ViewName not like ''V_PatientSearch%''
			  order by r.ViewName');
	ELSE
		EXEC('select r.ViewName, Permission, s.VIEW_CAPTION, s.PANEL_NAME, s.USE_LOOKUPS, s.SORTER
			  from RoleViews r
			  LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = r.ViewName
			  where r.RoleId=' + @RoleId + ' and r.ViewName LIKE ''%'+ @ViewName + '%'' and ViewName not like ''V_PatientSearch%''
			  order by r.ViewName');	
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsChecked]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPermittedViewsChecked]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
DECLARE @PermittedViews as Table
(
TABLE_QUALIFIER nvarchar(128),
TABLE_OWNER nvarchar(128),
TABLE_NAME nvarchar(128),
GRANTOR nvarchar(128),
GRANTEE nvarchar(128),
PRIVILEDGE nvarchar(20),
IS_GRANTABLE nvarchar(3)
)

INSERT INTO @PermittedViews
EXEC sp_table_privileges @table_name = 'V_%'

DECLARE @AllViews as Table
(
    table_qualifier    sysname,
    table_owner        nvarchar(384),
    table_name         nvarchar(384),
    table_type         varchar(100),
    fUsePattern        bit
)

INSERT INTO @AllViews
EXEC sp_tables 'V_%', 'dbo', 'BMBH_Views'
	
SELECT a.table_name as ViewName, CASE WHEN u.TABLE_NAME is not null then CAST(1 as bit) else CAST(0 as bit) END as Permission, s.VIEW_CAPTION, s.PANEL_NAME
FROM @AllViews a
LEFT JOIN @PermittedViews u on u.TABLE_NAME = a.TABLE_NAME and u.PRIVILEDGE = 'SELECT' and u.GRANTEE = @User
LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = a.table_name
where a.table_type = 'VIEW' and a.table_name not like '%_SearchForm'
order by s.SORTER

END
GO
/****** Object:  StoredProcedure [dbo].[GrantPatientSearch]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GrantPatientSearch]
@User nvarchar(255) 
AS
BEGIN
SET NOCOUNT ON;
UPDATE UserRoles SET AllowPatientSearch = 'Y' WHERE UserId = @User;
EXEC('GRANT SELECT ON V_PatientSearch_BP TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_BP_PSD TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('GRANT INSERT ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('GRANT UPDATE ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('GRANT DELETE ON V_PatientSearch_BP_Search TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_BP_Searchform TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_HN TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_HN_Searchform TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('GRANT INSERT ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('GRANT UPDATE ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('GRANT DELETE ON V_PatientSearch_HN_Search TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IF TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IF_PSD TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IF_Searchform TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('GRANT INSERT ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('GRANT UPDATE ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('GRANT DELETE ON V_PatientSearch_IF_Search TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IP TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IP_PSD TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IP_Searchform TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('GRANT INSERT ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('GRANT UPDATE ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('GRANT DELETE ON V_PatientSearch_IP_Search TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_NVG TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_NVG_Searchform TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('GRANT INSERT ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('GRANT UPDATE ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('GRANT DELETE ON V_PatientSearch_NVG_Search TO [' + @User + ']');
EXEC('GRANT SELECT ON V_PatientSearch_NVG_PSD TO [' + @User + ']');
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'MYSQL', @locallogin = @User, @useself = N'False', @rmtuser = N'mssql_user', @rmtpassword = N'cqw7FFTduAtqYsq9'
END

GO
/****** Object:  StoredProcedure [dbo].[RecreateSearchTable]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RecreateSearchTable]
	-- Add the parameters for the stored procedure here
	@View nvarchar(255),
	@RoleId int
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
CREATE TABLE #Users ( UserId NVARCHAR(50) );

EXEC('insert into #Users select UserId from UserRoles where RoleId=' + @RoleId);
--EXEC('TRUNCATE TABLE [' + @View + '_Search]');

DECLARE db_cursor CURSOR FOR 
SELECT UserId 
FROM #Users 

DECLARE @User NVARCHAR(50);

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @User  
WHILE @@FETCH_STATUS = 0  
BEGIN 
      EXEC('delete from [' + @View + '_Search] where UserId = ''' + @User + '''');
      EXEC('insert into [' + @View + '_Search] select Attribut, Operator, '''', Datentyp, ''' + @User + ''', Controltype, 0 as ValueCnt, ''UND'' as Logic, Sorter from [' + @View + '_SearchForm]');
      FETCH NEXT FROM db_cursor INTO @User 
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 

DROP TABLE #Users;

EXEC ('UPDATE t 
	   SET t.Controltype = ''TextBox'' 
	   FROM [' + @View + '_Search] t 
	   left join V_VALUECNT v on v.Attribut = t.Attribut COLLATE Latin1_General_CI_AS and v.ViewName = ''' + @View + ''' COLLATE Latin1_General_CI_AS
	   WHERE Controltype = ''DropDownList'' AND v.ValueCnt > 100')

EXEC('insert into [VIEW_SETTINGS]
	  ([VIEW_NAME], [VIEW_CAPTION])
	  select ''' + @View + ''', ''' + @View + '''
	  where not exists (select 1 from [VIEW_SETTINGS] where [VIEW_NAME] = ''' + @View + ''')')
END


GO
/****** Object:  StoredProcedure [dbo].[RecreateSearchTableForUser]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RecreateSearchTableForUser]
	-- Add the parameters for the stored procedure here
	@View nvarchar(255),
	@User nvarchar(255)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

EXEC('delete from [' + @View + '_Search] where UserId = ''' + @User + '''');
EXEC('insert into [' + @View + '_Search] select Attribut, Operator, '''', Datentyp, ''' + @User + ''', Controltype, 0 as ValueCnt, ''UND'' as Logic, Sorter from [' + @View + '_SearchForm]');
EXEC ('UPDATE t 
	   SET t.Controltype = ''TextBox'' 
	   FROM [' + @View + '_Search] t 
	   left join V_VALUECNT v on v.Attribut = t.Attribut COLLATE Latin1_General_CI_AS and v.ViewName = ''' + @View + ''' COLLATE Latin1_General_CI_AS
	   WHERE Controltype = ''DropDownList'' AND v.ValueCnt > 100')
END

GO
/****** Object:  StoredProcedure [dbo].[SetDocPermission]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christoph Döllinger
-- Create date: 07.05.2019
-- Description:	Sets permission for document
-- =============================================
CREATE PROCEDURE [dbo].[SetDocPermission] 
	-- Add the parameters for the stored procedure here
	@RoleId int, 
	@DocId int,
	@Permission bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE RoleDocs
	SET Permission = @Permission
	WHERE RoleId = @RoleId AND DocId = @DocId
	
END
GO
/****** Object:  StoredProcedure [dbo].[SetPermission]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetPermission]
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

-- BMBH specific
--EXEC('use Warehouse
--GRANT CONNECT TO [' + @User + ']
--GRANT SELECT TO  [' + @User + ']
--use CLIN106_DATA
--GRANT CONNECT TO [' + @User + ']
--GRANT SELECT TO  [' + @User + ']');

EXEC('use BMBH_Views
GRANT CONNECT TO [' + @User + ']
GRANT EXECUTE ON [dbo].[GetPermittedDocs] TO [' + @User + '] 
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



GO
/****** Object:  StoredProcedure [dbo].[SetRolePermission]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetRolePermission]
	-- Add the parameters for the stored procedure here
	@RoleId int,
	@View nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE BMBH_Views.dbo.RoleViews
	SET Permission = 1
	WHERE RoleId = @RoleId and ViewName = @View

	EXEC AddSearchForm @View

	DECLARE cur CURSOR LOCAL for
	SELECT UserId
	from BMBH_Views.dbo.UserRoles
	where RoleId = @RoleId;

	DECLARE @User NVARCHAR(255);
	OPEN cur
	fetch next from cur into @User
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		exec SetPermission @User, @View
		fetch next from cur into @User
	END
	
	CLOSE cur
	deallocate cur	
END

GO
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetUserRole]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255),
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE UserRoles
	SET RoleId = @RoleId
	WHERE UserId = @User

	DECLARE @ViewName NVARCHAR(255);
	DECLARE cur1 CURSOR LOCAL for
	select distinct ViewName from RoleViews
	
	OPEN cur1
	fetch next from cur1 into @ViewName
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		exec UnSetPermission @User, @ViewName
		fetch next from cur1 into @ViewName
	END
	
	CLOSE cur1
	deallocate cur1
	
	IF @RoleId > 0
	BEGIN
		DECLARE cur CURSOR LOCAL for
		select ViewName from RoleViews where RoleId = @RoleId and Permission = 1

		OPEN cur
		fetch next from cur into @ViewName
		
		WHILE @@FETCH_STATUS = 0 BEGIN
			exec SetPermission @User, @ViewName
			fetch next from cur into @ViewName	
		END
		
		CLOSE cur
		deallocate cur	
	END
END

GO
/****** Object:  StoredProcedure [dbo].[UnsetPermission]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnsetPermission]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255),
	@View nvarchar(255)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

--EXEC sp_configure 'remote query timeout', 0 ;  
--RECONFIGURE ;  

-- Insert statements for procedure here
EXEC('DENY SELECT ON [dbo].[' + @View + '] TO [' + @User + ']
 DENY SELECT ON [dbo].[' + @View + '_SearchForm] TO [' + @User + ']
 DENY UPDATE ON [dbo].[' + @View + '_Search] TO [' + @User + ']
 DENY SELECT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
 DENY INSERT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
 DENY DELETE ON [dbo].[' + @View + '_Search] TO [' + @User + ']');
END

GO
/****** Object:  StoredProcedure [dbo].[UnsetRolePermission]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnsetRolePermission]
	-- Add the parameters for the stored procedure here
	@RoleId int,
	@View nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE BMBH_Views.dbo.RoleViews
	SET Permission = 0
	WHERE RoleId = @RoleId and ViewName = @View
		
	DECLARE cur CURSOR LOCAL for
	SELECT UserId
	from BMBH_Views.dbo.UserRoles
	where RoleId = @RoleId;

	DECLARE @User NVARCHAR(255);
	OPEN cur
	fetch next from cur into @User
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		exec UnsetPermission @User, @View
		fetch next from cur into @User
	END
	
	CLOSE cur
	deallocate cur
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SEARCH_TABLES]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_SEARCH_TABLES]
	-- Add the parameters for the stored procedure here
	@User nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Temp as Table
(
TABLE_QUALIFIER nvarchar(128),
TABLE_OWNER nvarchar(128),
TABLE_NAME nvarchar(128),
GRANTOR nvarchar(128),
GRANTEE nvarchar(128),
PRIVILEDGE nvarchar(20),
IS_GRANTABLE nvarchar(3)
)

DECLARE @SearchTable nvarchar(255)

INSERT INTO @Temp
EXEC sp_table_privileges
   @table_name = 'V_%'

DECLARE MY_CURSOR CURSOR
	LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR
select TABLE_NAME
from @Temp 
where PRIVILEDGE = 'SELECT' and GRANTEE = @User
and TABLE_NAME not like '_Search'

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @SearchTable
WHILE @@FETCH_STATUS = 0
BEGIN
	print 'Berechne Werte für ' + @SearchTable
	EXEC UPDATE_VALCOUNT @SearchTable, @User
	FETCH NEXT FROM MY_CURSOR INTO @SearchTable
END
CLOSE MY_CURSOR
END

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_VALCOUNT]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_VALCOUNT]
	-- Add the parameters for the stored procedure here
@Table nvarchar(255)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE @i int;
DECLARE @n int;
DECLARE @sql nvarchar(255);
DECLARE @Field nvarchar(255);
DECLARE @Value int;

EXEC('DELETE FROM V_VALUECNT WHERE ViewName = ''' + @Table + '''')
EXEC('INSERT INTO V_VALUECNT SELECT ''' + @Table + ''' as ViewName, Attribut, 0 as ValueCnt FROM [' + @Table + '_Searchform]')

SET @sql = 'SELECT @i = Min(ID) FROM V_VALUECNT WHERE ViewName = ''' + @Table + '''';
EXECUTE sp_executesql @sql, N'@i int OUTPUT', @i = @i OUTPUT
SET @sql = 'SELECT @n = Max(ID) FROM V_VALUECNT WHERE ViewName = ''' + @Table + '''';
EXECUTE sp_executesql @sql, N'@n int OUTPUT', @n = @n OUTPUT

WHILE (@i <= @n)
BEGIN
	SET @sql = 'SELECT @Field = Attribut FROM V_VALUECNT WHERE ID = @i';
	EXECUTE sp_executesql @sql, N'@i int, @Field nvarchar(255) OUTPUT', @i = @i, @Field = @Field OUTPUT
	EXEC @Value = CNT_DISTINCT @Field, @Table
	EXEC ('UPDATE V_VALUECNT SET ValueCnt = ' + @Value + ' WHERE ID = ' + @i)
	SET @i = @i + 1;
END
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRoleViews]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateRoleViews]
	-- Add the parameters for the stored procedure here
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Temp as Table
	(
		table_qualifier    sysname,
		table_owner        nvarchar(384),
		table_name         nvarchar(384),
		table_type         varchar(100),
		fUsePattern        bit
	)

	INSERT INTO @Temp
	EXEC sp_tables 'V_%', 'dbo', 'BMBH_Views'
	
	delete from @Temp
	where table_type <> 'VIEW' or table_name like '%_Searchform' or table_name like '%_Search'

	insert into RoleViews
	(RoleId, ViewName, Permission)
	select @RoleId, table_name, 0
	from @Temp t
	left join RoleViews r on t.table_name = r.ViewName COLLATE Latin1_General_CI_AS and RoleId = @RoleId
	where r.ViewName is NULL 
END
GO
/****** Object:  StoredProcedure [dbo].[UploadFile]    Script Date: 09.05.2019 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christoph Döllinger
-- Create date: 06.05.2019
-- Description:	Inserts file into Documents table after upload
-- =============================================
CREATE PROCEDURE [dbo].[UploadFile] 
	-- Add the parameters for the stored procedure here
	@filePath nvarchar(255),
    @fileName nvarchar(50),
    @RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @version int;
	
	SELECT @version = Max([Version]) 
	FROM BMBH_Views.dbo.Documents
	WHERE [FileName] = @fileName

	IF @version > 1 
		SET @version = @version + 1;
	ELSE
		SET @version = 1;

    -- Insert statements for procedure here
	insert into BMBH_Views.dbo.Documents
	([FilePath], [FileName], [fileType], [Version])
	values (@filePath, @fileName, UPPER(SUBSTRING(@filename, CHARINDEX('.', @filename)+1, LEN(@filename))), @version)
	
	EXEC GenerateRoleDocs @RoleId
END

