USE [CLIN106_DATA]
GO
/****** Object:  ForeignKey [FK_CART_ITEMS_CART01]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[CART_ITEMS] DROP CONSTRAINT [FK_CART_ITEMS_CART01]
GO
/****** Object:  ForeignKey [FK_INVENTORY_CENTRALRECEIVIN05]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_CENTRALRECEIVIN05]
GO
/****** Object:  ForeignKey [FK_INVENTORY_INVENTORY_TYPE06]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_INVENTORY_TYPE06]
GO
/****** Object:  ForeignKey [FK_INVENTORY_MATERIALS08]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_MATERIALS08]
GO
/****** Object:  ForeignKey [FK_INVENTORY_METADATA07]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_METADATA07]
GO
/****** Object:  ForeignKey [INVENTORY_FK2]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [INVENTORY_FK2]
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SEARCH_TABLES]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[UPDATE_SEARCH_TABLES]
GO
/****** Object:  View [dbo].[V_PatientSearch_BP]    Script Date: 09/03/2018 15:14:05 ******/
DROP VIEW [dbo].[V_PatientSearch_BP]
GO
/****** Object:  View [dbo].[V_PatientSearch_IF]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IF]
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_NVG]
GO
/****** Object:  View [dbo].[V_PatientSearch_IP]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IP]
GO
/****** Object:  View [dbo].[V_PatientSearch_HN]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_HN]
GO
/****** Object:  StoredProcedure [dbo].[UnsetRolePermission]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[UnsetRolePermission]
GO
/****** Object:  View [dbo].[V_PatientSearch_IP_PSD]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IP_PSD]
GO
/****** Object:  View [dbo].[V_STARLIMS_DEPT]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_STARLIMS_DEPT]
GO
/****** Object:  View [dbo].[V_STARLIMS_USERS]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_STARLIMS_USERS]
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG_PSD]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_NVG_PSD]
GO
/****** Object:  View [dbo].[V_PatientSearch_IF_PSD]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IF_PSD]
GO
/****** Object:  View [dbo].[V_PatientSearch_BP_PSD]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_BP_PSD]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRoleViews]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[UpdateRoleViews]
GO
/****** Object:  StoredProcedure [dbo].[SetRolePermission]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[SetRolePermission]
GO
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[SetUserRole]
GO
/****** Object:  StoredProcedure [dbo].[Create_SL_View]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[Create_SL_View]
GO
/****** Object:  StoredProcedure [dbo].[CreateSTARLIMScart]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[CreateSTARLIMScart]
GO
/****** Object:  StoredProcedure [dbo].[DenyPatientSearch]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[DenyPatientSearch]
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoles]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetAllRoles]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViews]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetPermittedViews]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsByRole]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetPermittedViewsByRole]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsChecked]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetPermittedViewsChecked]
GO
/****** Object:  StoredProcedure [dbo].[GrantPatientSearch]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GrantPatientSearch]
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 09/03/2018 15:14:03 ******/
DROP TABLE [dbo].[IDTable]
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[INVENTORY]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_CENTRALRECEIVIN05]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_INVENTORY_TYPE06]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_MATERIALS08]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [FK_INVENTORY_METADATA07]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [INVENTORY_FK2]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [df_INVENTORY_ORIGSTS]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [df_INVENTORY_INVENTORY_TYPE]
GO
ALTER TABLE [dbo].[INVENTORY] DROP CONSTRAINT [df_INVENTORY_FLAG_CONTAINER]
GO
DROP TABLE [dbo].[INVENTORY]
GO
/****** Object:  Table [dbo].[LIMSCOUNTERS]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[LIMSCOUNTERS] DROP CONSTRAINT [df_LIMSCOUNTERS_ORIGSTS]
GO
DROP TABLE [dbo].[LIMSCOUNTERS]
GO
/****** Object:  Table [dbo].[METADATA_TEMPLATE_FIELDS]    Script Date: 09/03/2018 15:14:13 ******/
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ORIGSTS]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_CONTROL_TYPE]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_LENGTH]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_SORTER]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_REQUIRED]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_AUTO_LAYOUT]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_READ_ONLY]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_LEAVE]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_KEY_PRESS]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_SELECTION_CHANGED]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_VERSION]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_INVARIANT_DATE]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_DATE_FORMAT]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_VISIBLE]
GO
ALTER TABLE [dbo].[METADATA_TEMPLATE_FIELDS] DROP CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_COPY_CONTENTS]
GO
DROP TABLE [dbo].[METADATA_TEMPLATE_FIELDS]
GO
USE [BMBH_Views]
GO
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 09/03/2018 15:14:03 ******/
DROP TABLE [dbo].[PatientSearch]
GO
/****** Object:  StoredProcedure [dbo].[RecreateSearchTable]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[RecreateSearchTable]
GO
/****** Object:  StoredProcedure [dbo].[SetPermission]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[SetPermission]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetAllUsers]
GO
/****** Object:  StoredProcedure [dbo].[GetAllViews]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetAllViews]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedSearchTables]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[GetPermittedSearchTables]
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[DEPARTMENTS]    Script Date: 09/03/2018 15:14:13 ******/
ALTER TABLE [dbo].[DEPARTMENTS] DROP CONSTRAINT [df_DEPARTMENTS_ORIGSTS]
GO
DROP TABLE [dbo].[DEPARTMENTS]
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[AddSearchForm]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[AddSearchForm]
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[ALERTS_MGMT]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[ALERTS_MGMT] DROP CONSTRAINT [df_ALERTS_MGMT_ORIGSTS]
GO
DROP TABLE [dbo].[ALERTS_MGMT]
GO
/****** Object:  Table [dbo].[ALERTS_USERS]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[ALERTS_USERS] DROP CONSTRAINT [df_ALERTS_USERS_ORIGSTS]
GO
DROP TABLE [dbo].[ALERTS_USERS]
GO
/****** Object:  Table [dbo].[CART]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[CART] DROP CONSTRAINT [df_CART_ORIGSTS]
GO
ALTER TABLE [dbo].[CART] DROP CONSTRAINT [df_CART_VERSION]
GO
DROP TABLE [dbo].[CART]
GO
/****** Object:  Table [dbo].[CART_ITEMS]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[CART_ITEMS] DROP CONSTRAINT [FK_CART_ITEMS_CART01]
GO
ALTER TABLE [dbo].[CART_ITEMS] DROP CONSTRAINT [df_CART_ITEMS_ORIGSTS]
GO
DROP TABLE [dbo].[CART_ITEMS]
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[CNT_DISTINCT]    Script Date: 09/03/2018 15:14:07 ******/
DROP PROCEDURE [dbo].[CNT_DISTINCT]
GO
USE [Warehouse]
GO
/****** Object:  View [dbo].[V_Nexus_Eingaenge]    Script Date: 09/03/2018 15:14:11 ******/
DROP VIEW [dbo].[V_Nexus_Eingaenge]
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 09/03/2018 15:14:11 ******/
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_ORIGSTS]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_PWEXPD]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_SHOWERRORDETAILS]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_SIMULTANEOUSLOGINSALLOWED]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_LDAP_PORT]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [df_USERS_POWERUSER]
GO
DROP TABLE [dbo].[USERS]
GO
/****** Object:  View [dbo].[V_MAX_TEMPLATE_VERS]    Script Date: 09/03/2018 15:14:08 ******/
DROP VIEW [dbo].[V_MAX_TEMPLATE_VERS]
GO
USE [BMBH_Views]
GO
/****** Object:  Table [dbo].[V_PatientSearch_BP_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_PatientSearch_BP_Search]
GO
/****** Object:  View [dbo].[V_PatientSearch_BP_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_BP_Searchform]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IF_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_PatientSearch_IF_Search]
GO
/****** Object:  View [dbo].[V_PatientSearch_IF_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IF_Searchform]
GO
/****** Object:  Table [dbo].[V_PatientSearch_NVG_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_PatientSearch_NVG_Search]
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_NVG_Searchform]
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_Recursive_Log]
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_Save_Search]
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_VALUECNT]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IP_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_PatientSearch_IP_Search]
GO
/****** Object:  View [dbo].[V_PatientSearch_IP_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_IP_Searchform]
GO
/****** Object:  Table [dbo].[V_PatientSearch_HN_Search]    Script Date: 09/03/2018 15:14:04 ******/
DROP TABLE [dbo].[V_PatientSearch_HN_Search]
GO
/****** Object:  View [dbo].[V_PatientSearch_HN_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
DROP VIEW [dbo].[V_PatientSearch_HN_Searchform]
GO
/****** Object:  View [dbo].[V_PatientSearch_HN_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_HN_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, '=' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE '%char' THEN 'DropDownList' WHEN DATA_TYPE LIKE 'date%' THEN 'Calendar' ELSE 'TextBox' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = 'V_PatientSearch_HN'
GO
/****** Object:  Table [dbo].[V_PatientSearch_HN_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_HN_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_HN_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PatientSearch_IP_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IP_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, '=' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE '%char' THEN 'DropDownList' WHEN DATA_TYPE LIKE 'date%' THEN 'Calendar' ELSE 'TextBox' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = 'V_PatientSearch_IP'
GO
/****** Object:  Table [dbo].[V_PatientSearch_IP_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_IP_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_IP_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_VALUECNT](
	[ViewName] [nvarchar](50) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[ValueCnt] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_V_VALUECNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_V_VALUECNT] UNIQUE NONCLUSTERED 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_V_VALUECNT_1] ON [dbo].[V_VALUECNT] 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Save_Search](
	[_ID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[Attribut] [nvarchar](50) NULL,
	[Operator] [nvarchar](50) NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
	[ViewName] [nvarchar](50) NULL,
	[SearchName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Recursive_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Iteration] [int] NOT NULL,
	[SQL] [nvarchar](max) NULL,
	[SearchMode] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_NVG_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, '=' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE '%char' THEN 'DropDownList' WHEN DATA_TYPE LIKE 'date%' THEN 'Calendar' ELSE 'TextBox' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = 'V_PatientSearch_NVG'
GO
/****** Object:  Table [dbo].[V_PatientSearch_NVG_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_NVG_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_NVG_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PatientSearch_IF_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IF_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, '=' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE '%char' THEN 'DropDownList' WHEN DATA_TYPE LIKE 'date%' THEN 'Calendar' ELSE 'TextBox' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = 'V_PatientSearch_IF'
GO
/****** Object:  Table [dbo].[V_PatientSearch_IF_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_IF_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_IF_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PatientSearch_BP_Searchform]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_BP_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, '=' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE '%char' THEN 'DropDownList' WHEN DATA_TYPE LIKE 'date%' THEN 'Calendar' ELSE 'TextBox' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = 'V_PatientSearch_BP'
GO
/****** Object:  Table [dbo].[V_PatientSearch_BP_Search]    Script Date: 09/03/2018 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_BP_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_BP_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [CLIN106_DATA]
GO
/****** Object:  View [dbo].[V_MAX_TEMPLATE_VERS]    Script Date: 09/03/2018 15:14:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_MAX_TEMPLATE_VERS] as
select TEMPLATE_NAME, MAX([Version]) as [VERSION]
from METADATA_TEMPLATE_VERS
group by TEMPLATE_NAME
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 09/03/2018 15:14:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[ORIGREC] [int] IDENTITY(3,1) NOT NULL,
	[ALIVE] [nvarchar](12) NULL,
	[ALIVEP] [int] NULL,
	[AUTHORITY] [nvarchar](1) NULL,
	[CREATEBY] [nvarchar](15) NULL,
	[CREATEDATE] [datetime] NULL,
	[CURRACT] [nvarchar](50) NULL,
	[DEPTLIST] [nvarchar](254) NULL,
	[DESIGNER] [nvarchar](2) NULL,
	[EMAIL] [nvarchar](60) NULL,
	[FAX] [nvarchar](25) NULL,
	[FULLNAME] [nvarchar](255) NULL,
	[GRACELOG] [int] NULL,
	[GRPAUTH] [nvarchar](10) NULL,
	[GRPNAME] [nvarchar](30) NULL,
	[IDDLEACTION] [nvarchar](30) NULL,
	[IDDLETIME] [int] NULL,
	[IDLESPEC] [nvarchar](15) NULL,
	[JOBDESCRIPTION] [nvarchar](25) NULL,
	[LANGID] [nvarchar](4) NULL,
	[LOGDATE] [datetime] NULL,
	[MASTER] [nvarchar](2) NULL,
	[METHODDEVELOPER] [nvarchar](2) NULL,
	[OPENACTS] [nvarchar](200) NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_USERS_ORIGSTS]  DEFAULT (N'N'),
	[PASSWRD] [nvarchar](100) NULL,
	[PICTURE_BMP] [nvarchar](50) NULL,
	[PW1] [nvarchar](100) NULL,
	[PW2] [nvarchar](100) NULL,
	[PW3] [nvarchar](100) NULL,
	[PW4] [nvarchar](100) NULL,
	[PWEXPD] [datetime] NULL CONSTRAINT [df_USERS_PWEXPD]  DEFAULT (N'31.12.2099'),
	[RASMANAGER] [nvarchar](2) NULL,
	[SECURITYACTION] [nvarchar](50) NULL,
	[SIGNATURE] [nvarchar](100) NULL,
	[STATUS] [nvarchar](15) NULL,
	[USERPHONE] [nvarchar](25) NULL,
	[USRNAM] [nvarchar](15) NOT NULL,
	[USTATUS] [nvarchar](2) NULL,
	[WORKSTATIONNAME] [nvarchar](50) NULL,
	[WORKSTATIONUSER] [nvarchar](30) NULL,
	[READONLY] [nvarchar](2) NULL,
	[STARDOC_ID] [nvarchar](20) NULL,
	[SHOWERRORDETAILS] [nchar](1) NULL CONSTRAINT [df_USERS_SHOWERRORDETAILS]  DEFAULT ('N'),
	[PIN] [nvarchar](255) NULL,
	[LAST_LOGIN_ATTEMPT_DATE] [datetime] NULL,
	[LAST_LOGIN_FAILED_ATTEMPTS] [int] NULL,
	[DESIGNERROLE] [nvarchar](16) NULL,
	[REG_REQUEST_GUID] [nvarchar](256) NULL,
	[SIMULTANEOUSLOGINSALLOWED] [int] NULL CONSTRAINT [df_USERS_SIMULTANEOUSLOGINSALLOWED]  DEFAULT ((-1)),
	[LDAP_SERVER] [nvarchar](255) NULL,
	[LDAP_PORT] [int] NULL CONSTRAINT [df_USERS_LDAP_PORT]  DEFAULT ((389)),
	[LDAP_DNNAME] [nvarchar](512) NULL,
	[POWERUSER] [nchar](1) NULL CONSTRAINT [df_USERS_POWERUSER]  DEFAULT ('Y'),
	[LDAP_ALIAS] [nvarchar](255) NULL,
	[PWPOLICYROLE] [nvarchar](2) NULL,
	[GRABBER] [nchar](1) NULL,
	[DEPT] [nvarchar](20) NULL,
	[ROLE] [nvarchar](15) NULL,
 CONSTRAINT [USERS_PK] PRIMARY KEY CLUSTERED 
(
	[USRNAM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [USERS_ORIGREC] ON [dbo].[USERS] 
(
	[ORIGREC] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
USE [Warehouse]
GO
/****** Object:  View [dbo].[V_Nexus_Eingaenge]    Script Date: 09/03/2018 15:14:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Nexus_Eingaenge]
AS
SELECT     Eingangsnummer, [Vorname Patient], [Nachname Patient], Geburtsdatum, Geschlecht, Alter_bei_Probenentnahme_berechnet AS [Alter], Geburtsname, Spezies, 
                      Lebensnummer, Lebensnummer_Thorax, Aufnahmenummer, Eingangsdatum, [Einsender Kurzname], Materialart, Auftragsart, Abrechnungsart, Priorität, [Zugew# Arzt], 
                      [Zyto Ergebnis], Mandant, Schwangerschaftswoche, TimestampX, ID, Ist_interner_Einsender, Einwilligung_Behandlungsvertrag, Freigabedatum_Probe, Status
FROM         dbo.Nexus_Eingaenge_bereinigt
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Nexus_Eingaenge_bereinigt"
            Begin Extent = 
               Top = 0
               Left = 273
               Bottom = 303
               Right = 481
            End
            DisplayFlags = 280
            TopColumn = 12
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1875
         Alias = 1740
         Table = 1170
         Output = 1440
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Nexus_Eingaenge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Nexus_Eingaenge'
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[CNT_DISTINCT]    Script Date: 09/03/2018 15:14:07 ******/
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
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[CART_ITEMS]    Script Date: 09/03/2018 15:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CART_ITEMS](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_CART_ITEMS_ORIGSTS]  DEFAULT (N'N'),
	[CART_ID] [int] NULL,
	[ITEM_ORIGREC] [int] NULL,
	[STATUS] [nvarchar](15) NULL,
	[CART_ORIGREC] [int] NULL,
 CONSTRAINT [PK_CART_ITEMS] PRIMARY KEY CLUSTERED 
(
	[ORIGREC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CART_ITEMS_ORIGREC] ON [dbo].[CART_ITEMS] 
(
	[ITEM_ORIGREC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CART_ITEMS02] ON [dbo].[CART_ITEMS] 
(
	[CART_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CART_ITEMS03] ON [dbo].[CART_ITEMS] 
(
	[CART_ORIGREC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CART]    Script Date: 09/03/2018 15:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CART](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_CART_ORIGSTS]  DEFAULT (N'N'),
	[CART_ID] [int] NOT NULL,
	[CART_NAME] [nvarchar](255) NULL,
	[CART_DESC] [nvarchar](2000) NULL,
	[USRNAM] [nvarchar](15) NULL,
	[CREATED_DT] [datetime] NULL,
	[OBJECT_TYPE] [nvarchar](50) NULL,
	[RASCLIENT_ORIGREC] [int] NULL,
	[DEPARTMENT_ORIGREC] [int] NULL,
	[CART_DESTINATION] [nvarchar](255) NULL,
	[REQUESTID] [int] NULL,
	[CREATOR] [nvarchar](255) NULL,
	[DEPT] [nvarchar](20) NULL,
	[CART_ID_VER] [nvarchar](255) NULL,
	[VERSION] [int] NOT NULL CONSTRAINT [df_CART_VERSION]  DEFAULT ((1)),
 CONSTRAINT [PK_CART] PRIMARY KEY CLUSTERED 
(
	[ORIGREC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CART02] ON [dbo].[CART] 
(
	[CART_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALERTS_USERS]    Script Date: 09/03/2018 15:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALERTS_USERS](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_ALERTS_USERS_ORIGSTS]  DEFAULT (N'N'),
	[ALERTID] [int] NOT NULL,
	[USRNAM] [nvarchar](15) NOT NULL,
	[DATENOTIFIED] [datetime] NULL,
	[DATEACKNOWLEDGE] [datetime] NULL,
	[REMARKS] [ntext] NULL,
 CONSTRAINT [PK_ALERTS_USERS] PRIMARY KEY CLUSTERED 
(
	[ALERTID] ASC,
	[USRNAM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALERTS_MGMT]    Script Date: 09/03/2018 15:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALERTS_MGMT](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_ALERTS_MGMT_ORIGSTS]  DEFAULT (N'N'),
	[ALERTID] [int] NOT NULL,
	[DATECREATED] [datetime] NULL,
	[CREATEDBY] [nvarchar](255) NULL,
	[STATUS] [nvarchar](30) NULL,
	[ALERTMESSAGE] [ntext] NULL,
 CONSTRAINT [PK_ALERTS_MGMT] PRIMARY KEY CLUSTERED 
(
	[ALERTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[AddSearchForm]    Script Date: 09/03/2018 15:14:07 ******/
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

IF OBJECT_ID(@View + '_Searchform') IS NULL
BEGIN
exec( 'CREATE VIEW ' + @View + '_Searchform AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''' + @View + '''' );
END

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
 CONSTRAINT [PK_' + @View + '_Search] PRIMARY KEY CLUSTERED 
( [ID] ASC )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]' );
END
END
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[DEPARTMENTS]    Script Date: 09/03/2018 15:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEPARTMENTS](
	[ORIGREC] [int] IDENTITY(9,1) NOT NULL,
	[DEPT] [nvarchar](20) NOT NULL,
	[DEPTCODE] [nvarchar](2) NULL,
	[MANAGER] [nvarchar](10) NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_DEPARTMENTS_ORIGSTS]  DEFAULT (N'N'),
	[RASCLIENTID] [nvarchar](15) NULL,
	[SHARESDB] [nvarchar](10) NULL,
	[NAME] [nvarchar](128) NULL,
	[ADDRESS1] [nvarchar](512) NULL,
	[ADDRESS2] [nvarchar](512) NULL,
	[CITY] [nvarchar](128) NULL,
	[STATE] [nvarchar](50) NULL,
	[ZIP] [nvarchar](20) NULL,
	[COUNTRY] [nvarchar](50) NULL,
	[PHONE1] [nvarchar](20) NULL,
	[PHONE2] [nvarchar](20) NULL,
	[FAX] [nvarchar](20) NULL,
	[URL] [nvarchar](256) NULL,
	[ACCOUNT_NO] [nvarchar](50) NULL,
	[KNOWN_AS] [nvarchar](256) NULL,
 CONSTRAINT [DEPARTMENTS_PK] PRIMARY KEY CLUSTERED 
(
	[DEPT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [BMBH_Views]
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedSearchTables]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllViews]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SetPermission]    Script Date: 09/03/2018 15:14:07 ******/
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

-- Insert statements for procedure here
EXEC sp_addrolemember N'db_datareader', @User
EXEC sp_addrolemember N'db_datawriter', @User
EXEC('use BMBH_Views
GRANT CONNECT TO [' + @User + ']
use Warehouse
GRANT CONNECT TO [' + @User + ']
GRANT SELECT TO  [' + @User + ']
use CLIN106_DATA
GRANT CONNECT TO [' + @User + ']
GRANT SELECT TO  [' + @User + ']
use BMBH_Views
GRANT EXECUTE ON [dbo].[GetPermittedViews] TO [' + @User + '] 
GRANT EXECUTE ON [dbo].[CreateSTARLIMScart] TO [' + @User + '] 
GRANT VIEW DEFINITION ON [dbo].[GetPermittedViews] TO [' + @User + ']
GRANT CONTROL ON [dbo].[GetPermittedViews] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '_SearchForm] TO [' + @User + ']
GRANT UPDATE ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT SELECT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
GRANT INSERT ON [dbo].[' + @View + '_Search] TO [' + @User + ']
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
/****** Object:  StoredProcedure [dbo].[RecreateSearchTable]    Script Date: 09/03/2018 15:14:07 ******/
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
      EXEC('insert into [' + @View + '_Search] select Attribut, Operator, '''', Datentyp, ''' + @User + ''', Controltype, 0 as ValueCnt from [' + @View + '_SearchForm]');

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
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 09/03/2018 15:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientSearch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Vorname] [nvarchar](255) NULL,
	[Geburtsdatum] [date] NULL,
	[ISH_PID] [nvarchar](50) NULL,
	[ISH_FID] [nvarchar](50) NULL,
	[BMBH_PID] [nchar](8) NULL,
	[GUID] [uniqueidentifier] NULL,
	[Histo_Nr] [nvarchar](13) NULL,
	[Status] [nvarchar](255) NULL,
	[Timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_PatientSearch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch] ON [dbo].[PatientSearch] 
(
	[GUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_1] ON [dbo].[PatientSearch] 
(
	[BMBH_PID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_2] ON [dbo].[PatientSearch] 
(
	[Histo_Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_3] ON [dbo].[PatientSearch] 
(
	[ISH_PID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_4] ON [dbo].[PatientSearch] 
(
	[ISH_FID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
USE [CLIN106_DATA]
GO
/****** Object:  Table [dbo].[METADATA_TEMPLATE_FIELDS]    Script Date: 09/03/2018 15:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[METADATA_TEMPLATE_FIELDS](
	[ORIGREC] [int] IDENTITY(10935,1) NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ORIGSTS]  DEFAULT (N'N'),
	[TEMPLATE_NAME] [nvarchar](255) NOT NULL,
	[FIELD_NAME] [nvarchar](255) NOT NULL,
	[LANGUAGE] [nvarchar](10) NOT NULL,
	[CAPTION] [nvarchar](255) NULL,
	[CONTROL_TYPE] [nvarchar](100) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_CONTROL_TYPE]  DEFAULT ('TextBox'),
	[LOOKUP_NAME] [nvarchar](255) NULL,
	[LENGTH] [int] NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_LENGTH]  DEFAULT ((32)),
	[MASK] [nvarchar](255) NULL,
	[INTERNAL_FIELD_NAME] [nvarchar](255) NULL,
	[LEFT] [int] NULL,
	[TOP] [int] NULL,
	[WIDTH] [int] NULL,
	[HEIGHT] [int] NULL,
	[LABEL_LEFT] [int] NULL,
	[LABEL_TOP] [int] NULL,
	[LABEL_WIDTH] [int] NULL,
	[LABEL_HEIGHT] [int] NULL,
	[VALIDATING_TYPE] [nvarchar](32) NULL,
	[LABEL_FONT] [nvarchar](255) NULL,
	[LABEL_FORE_COLOR] [nvarchar](255) NULL,
	[LABEL_BACK_COLOR] [nvarchar](255) NULL,
	[FONT] [nvarchar](255) NULL,
	[FORE_COLOR] [nvarchar](255) NULL,
	[BACK_COLOR] [nvarchar](255) NULL,
	[SORTER] [int] NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_SORTER]  DEFAULT ((9999)),
	[REQUIRED] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_REQUIRED]  DEFAULT ('N'),
	[AUTO_LAYOUT] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_AUTO_LAYOUT]  DEFAULT ('N'),
	[READ_ONLY] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_READ_ONLY]  DEFAULT ('N'),
	[DEFAULT_VALUE] [nvarchar](1024) NULL,
	[ON_LEAVE] [nchar](1) NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_LEAVE]  DEFAULT ('N'),
	[ON_LEAVE_CALC] [nvarchar](10) NULL,
	[ON_KEY_PRESS] [nchar](1) NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_KEY_PRESS]  DEFAULT ('N'),
	[ON_KEY_PRESS_CALC] [nvarchar](10) NULL,
	[ON_SELECTION_CHANGED] [nchar](1) NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_ON_SELECTION_CHANGED]  DEFAULT ('N'),
	[ON_SELECTION_CHANGED_CALC] [nvarchar](10) NULL,
	[VERSION] [int] NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_VERSION]  DEFAULT ((1)),
	[INVARIANT_DATE] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_INVARIANT_DATE]  DEFAULT ('N'),
	[DATE_FORMAT] [nvarchar](60) NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_DATE_FORMAT]  DEFAULT ('G'),
	[VISIBLE] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_VISIBLE]  DEFAULT (N'Y'),
	[COPY_CONTENTS] [nchar](1) NOT NULL CONSTRAINT [df_METADATA_TEMPLATE_FIELDS_COPY_CONTENTS]  DEFAULT (N'Y'),
 CONSTRAINT [PK_METADATA_TEMPLATE_FIELDS] PRIMARY KEY CLUSTERED 
(
	[TEMPLATE_NAME] ASC,
	[FIELD_NAME] ASC,
	[LANGUAGE] ASC,
	[VERSION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_METADATA_TEMPLATE_FIELDS_5_1966630049__K5_K3_K38_4_7_8_11_27_30] ON [dbo].[METADATA_TEMPLATE_FIELDS] 
(
	[LANGUAGE] ASC,
	[TEMPLATE_NAME] ASC,
	[VERSION] ASC
)
INCLUDE ( [FIELD_NAME],
[CONTROL_TYPE],
[LOOKUP_NAME],
[INTERNAL_FIELD_NAME],
[SORTER],
[READ_ONLY]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_METADATA_TEMPLATE_FIELDS_O] ON [dbo].[METADATA_TEMPLATE_FIELDS] 
(
	[ORIGREC] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_METADATA_TEMPLATE_FIELDS02] ON [dbo].[METADATA_TEMPLATE_FIELDS] 
(
	[TEMPLATE_NAME] ASC,
	[VERSION] ASC,
	[LANGUAGE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_METADATA_TEMPLATE_FIELDS03] ON [dbo].[METADATA_TEMPLATE_FIELDS] 
(
	[FIELD_NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LIMSCOUNTERS]    Script Date: 09/03/2018 15:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMSCOUNTERS](
	[ORIGREC] [int] IDENTITY(38957,1) NOT NULL,
	[FLDNAME] [nvarchar](30) NOT NULL,
	[LIMSCOUNTER] [int] NOT NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_LIMSCOUNTERS_ORIGSTS]  DEFAULT (N'N'),
	[PREFIX] [nvarchar](20) NULL,
	[TABLNAME] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IS_TABLE_FIELD] ON [dbo].[LIMSCOUNTERS] 
(
	[FLDNAME] ASC,
	[TABLNAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_LIMSCOUNTERS04] ON [dbo].[LIMSCOUNTERS] 
(
	[FLDNAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INVENTORY]    Script Date: 09/03/2018 15:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVENTORY](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[INVENTORYID] [int] NOT NULL,
	[MATCODE] [nvarchar](30) NULL,
	[ORIGSTS] [nchar](1) NOT NULL CONSTRAINT [df_INVENTORY_ORIGSTS]  DEFAULT (N'N'),
	[UNIT_CODE] [nvarchar](25) NULL,
	[INVENTORY_CODE] [nvarchar](50) NULL,
	[EXTERNAL_CODE] [nvarchar](100) NULL,
	[INVENTORY_TYPE] [nvarchar](25) NULL CONSTRAINT [df_INVENTORY_INVENTORY_TYPE]  DEFAULT ('Inventory'),
	[FLAG_CONTAINER] [int] NULL CONSTRAINT [df_INVENTORY_FLAG_CONTAINER]  DEFAULT ((0)),
	[METADATA_GUID] [nvarchar](36) NULL,
	[CONTAINER_TYPE] [nvarchar](30) NULL,
	[SAMPLETYPE] [nvarchar](50) NULL,
	[EXTERNAL_ID] [nvarchar](30) NULL,
	[QC_LEVEL] [nvarchar](30) NULL,
	[PREP_METHOD] [nvarchar](256) NULL,
	[INVENTORY_METADATA_ID] [int] NULL,
 CONSTRAINT [INVENTORY_PK] PRIMARY KEY CLUSTERED 
(
	[INVENTORYID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [_dta_index_INVENTORY_5_622625261__K10_K2_K9] ON [dbo].[INVENTORY] 
(
	[METADATA_GUID] ASC,
	[INVENTORYID] ASC,
	[FLAG_CONTAINER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EXTERNALCODE] ON [dbo].[INVENTORY] 
(
	[EXTERNAL_CODE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY01] ON [dbo].[INVENTORY] 
(
	[MATCODE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY02] ON [dbo].[INVENTORY] 
(
	[METADATA_GUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY03] ON [dbo].[INVENTORY] 
(
	[INVENTORYID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY04] ON [dbo].[INVENTORY] 
(
	[EXTERNAL_CODE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY05] ON [dbo].[INVENTORY] 
(
	[FLAG_CONTAINER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORY06] ON [dbo].[INVENTORY] 
(
	[INVENTORYID] ASC,
	[FLAG_CONTAINER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_INVENTORYCODE] ON [dbo].[INVENTORY] 
(
	[INVENTORY_CODE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
USE [BMBH_Views]
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 09/03/2018 15:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GrantPatientSearch]    Script Date: 09/03/2018 15:14:07 ******/
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
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsChecked]    Script Date: 09/03/2018 15:14:07 ******/
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
	
-- Insert statements for procedure here
SELECT a.table_name as ViewName, CASE WHEN u.TABLE_NAME is not null then CAST(1 as bit) else CAST(0 as bit) END as Permission, s.VIEW_CAPTION, s.PANEL_NAME
FROM @AllViews a
LEFT JOIN @PermittedViews u on u.TABLE_NAME = a.TABLE_NAME and u.PRIVILEDGE = 'SELECT' and u.GRANTEE = @User
LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = a.table_name
where a.table_type = 'VIEW' and a.table_name not like '%_SearchForm'

END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViewsByRole]    Script Date: 09/03/2018 15:14:07 ******/
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
	@RoleId nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here    
	select r.ViewName, Permission, s.VIEW_CAPTION, s.PANEL_NAME
	from RoleViews r
	LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = r.ViewName
	where r.RoleId = @RoleId
	order by r.ViewName
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermittedViews]    Script Date: 09/03/2018 15:14:07 ******/
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

select t.TABLE_NAME, s.VIEW_CAPTION, s.PANEL_NAME
from @Temp t
left join VIEW_SETTINGS s on s.VIEW_NAME = t.TABLE_NAME
where t.PRIVILEDGE = 'SELECT'
and t.GRANTEE = @User
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoles]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[DenyPatientSearch]    Script Date: 09/03/2018 15:14:07 ******/
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
END
GO
/****** Object:  StoredProcedure [dbo].[CreateSTARLIMScart]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[Create_SL_View]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SetUserRole]    Script Date: 09/03/2018 15:14:07 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[SetRolePermission]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateRoleViews]    Script Date: 09/03/2018 15:14:07 ******/
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
	left join RoleViews r on t.table_name = r.ViewName and RoleId = @RoleId
	where r.ViewName is NULL
END
GO
/****** Object:  View [dbo].[V_PatientSearch_BP_PSD]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_BP_PSD] as
SELECT p.[ID] 
	  ,pat.[Name]
      ,pat.[Vorname]
      ,pat.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,pat.UKH_FID as ISH_FID
      ,p.BMBH_PID
      ,p.[GUID]
      ,'' as Histo_Nr
      ,'' as [Status]
      ,pat.Biobank     
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select p.Name, p.Vorname, p.Geburtsdatum, p.BMBH_PID, p.UKH_PID, p.UKH_FID, t.Name as Biobank from Patienten p join Patienten_Teilbiobanken b on b.PatID=p.ID join Teilbiobanken t on t.ID = b.BiobankID')) pat 
      on pat.BMBH_PID = p.BMBH_PID
 WHERE pat.Biobank is not null and pat.Biobank <> 'NCT-Gewebebank'
GO
/****** Object:  View [dbo].[V_PatientSearch_IF_PSD]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IF_PSD] as
SELECT p.[ID] 
	  ,pat.[Name]
      ,pat.[Vorname]
      ,pat.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,p.ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,'' as Histo_Nr
      ,'' as [Status]
      ,pat.Biobank     
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select p.Name, p.Vorname, p.Geburtsdatum, p.BMBH_PID, p.UKH_PID, p.UKH_FID, t.Name as Biobank from Patienten p join Patienten_Teilbiobanken b on b.PatID=p.ID join Teilbiobanken t on t.ID = b.BiobankID')) pat 
      on pat.UKH_FID = p.ISH_FID
 WHERE p.ISH_FID <> '' and pat.Biobank is not null and pat.Biobank <> 'NCT-Gewebebank'
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG_PSD]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_NVG_PSD] as
SELECT p.[ID] 
	  ,p.[Name]
      ,p.[Vorname]
      ,p.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,pat.UKH_FID as ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,'' as Histo_Nr
      ,'' as [Status]
      ,pat.Biobank     
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select p.Name, p.Vorname, p.Geburtsdatum, p.BMBH_PID, p.UKH_PID, p.UKH_FID, t.Name as Biobank from Patienten p join Patienten_Teilbiobanken b on b.PatID=p.ID join Teilbiobanken t on t.ID = b.BiobankID')) pat 
      on pat.Name = p.Name and pat.Vorname = p.Vorname and pat.Geburtsdatum = p.Geburtsdatum
 WHERE p.Name <> '' and pat.Biobank is not null and pat.Biobank <> 'NCT-Gewebebank'
GO
/****** Object:  View [dbo].[V_STARLIMS_USERS]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_STARLIMS_USERS]
AS
SELECT     USRNAM, FULLNAME, DEPTLIST
FROM         CLIN106_DATA.dbo.USERS
WHERE     (STATUS = 'Active') AND (USRNAM <> 'ANONYMOUS') AND (USRNAM <> 'NGWTEST') AND (USRNAM <> 'SYSADM') AND (USRNAM <> 'NLBTEST')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[5] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "USERS (CLIN106_DATA.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_STARLIMS_USERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_STARLIMS_USERS'
GO
/****** Object:  View [dbo].[V_STARLIMS_DEPT]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_STARLIMS_DEPT] as
select '' as DEPT
union
select DEPT
from CLIN106_DATA.dbo.DEPARTMENTS
where SHARESDB = 'Shares DB'
and DEPT not in ('HNO', 'LAB1', 'Orthopädie', 'Kardiologie')
GO
/****** Object:  View [dbo].[V_PatientSearch_IP_PSD]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IP_PSD] as
SELECT p.[ID] 
	  ,pat.Name
      ,pat.Vorname
      ,pat.Geburtsdatum
      ,p.ISH_PID 
      ,pat.UKH_FID as 'ISH_FID'
      ,pat.BMBH_PID
      ,p.[GUID]
      ,'' as Histo_Nr
      ,'' as [Status]
      ,pat.Biobank     
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select p.Name, p.Vorname, p.Geburtsdatum, p.BMBH_PID, p.UKH_PID, p.UKH_FID, t.Name as Biobank from Patienten p join Patienten_Teilbiobanken b on b.PatID=p.ID join Teilbiobanken t on t.ID = b.BiobankID')) pat 
      on pat.UKH_PID = p.ISH_PID
 WHERE p.ISH_PID <> '' and pat.Biobank is not null and pat.Biobank <> 'NCT-Gewebebank'
GO
/****** Object:  StoredProcedure [dbo].[UnsetRolePermission]    Script Date: 09/03/2018 15:14:07 ******/
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
/****** Object:  View [dbo].[V_PatientSearch_HN]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_HN] as
SELECT distinct p.[ID] 
	  ,n.[Nachname Patient] as Name
      ,n.[Vorname Patient] as Vorname
      ,n.[Geburtsdatum]
      ,n.Lebensnummer as ISH_PID
      ,n.Aufnahmenummer as ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,p.Histo_Nr
      ,n.[Status]
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN V_Nexus_Eingaenge n on n.Eingangsnummer = p.Histo_Nr COLLATE SQL_Latin1_General_CP1_CI_AS
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select * from Patienten')) pat 
      on pat.Name = n.[Nachname Patient] and pat.Vorname = n.[Vorname Patient] and pat.Geburtsdatum = n.Geburtsdatum
 WHERE p.Histo_Nr IS NOT NULL
GO
/****** Object:  View [dbo].[V_PatientSearch_IP]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IP] as
SELECT distinct p.[ID] 
	  ,n.[Nachname Patient] as Name
      ,n.[Vorname Patient] as Vorname
      ,n.Geburtsdatum
      ,p.ISH_PID
      ,n.Aufnahmenummer as ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,n.Eingangsnummer as Histo_Nr
      ,n.[Status]      
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select * from Patienten')) pat 
      on pat.UKH_PID = p.ISH_PID
 LEFT JOIN V_Nexus_Eingaenge n on p.ISH_PID = n.Lebensnummer
 WHERE p.ISH_PID <> ''
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_NVG] as
SELECT p.[ID] 
	  ,p.[Name]
      ,p.[Vorname]
      ,p.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,pat.UKH_FID as ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,n.Eingangsnummer as Histo_Nr
      ,n.[Status]      
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select * from Patienten')) pat 
      on pat.Name = p.Name and pat.Vorname = p.Vorname and pat.Geburtsdatum = p.Geburtsdatum
 LEFT JOIN V_Nexus_Eingaenge n on n.[Nachname Patient] = p.Name and n.[Vorname Patient] = p.Vorname and n.Geburtsdatum = p.Geburtsdatum
 WHERE p.Name <> ''
GO
/****** Object:  View [dbo].[V_PatientSearch_IF]    Script Date: 09/03/2018 15:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_IF] as
SELECT distinct p.[ID] 
	  ,pat.[Name]
      ,pat.[Vorname]
      ,pat.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,p.ISH_FID
      ,pat.BMBH_PID
      ,p.[GUID]
      ,n.Eingangsnummer as Histo_Nr
      ,n.[Status]      
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * FROM OPENQUERY(MYSQL, 'select * from Patienten')) pat on pat.UKH_FID = p.ISH_FID 
 LEFT JOIN V_Nexus_Eingaenge n on n.[Nachname Patient] = p.Name and n.[Vorname Patient] = p.Vorname and n.Geburtsdatum = p.Geburtsdatum
 WHERE p.ISH_FID <> ''
GO
/****** Object:  View [dbo].[V_PatientSearch_BP]    Script Date: 09/03/2018 15:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PatientSearch_BP] as
SELECT distinct p.[ID] 
	  ,pat.[Name]
      ,pat.[Vorname]
      ,pat.[Geburtsdatum]
      ,pat.UKH_PID as ISH_PID
      ,pat.UKH_FID as ISH_FID
      ,p.BMBH_PID
      ,p.[GUID]
      ,n.Eingangsnummer as Histo_Nr
      ,n.[Status]
  FROM [BMBH_Views].[dbo].[PatientSearch] p
 LEFT JOIN (SELECT * 
      FROM OPENQUERY(MYSQL, 'select * from Patienten')) pat 
      on pat.BMBH_PID = p.BMBH_PID
 LEFT JOIN V_Nexus_Eingaenge n on n.[Nachname Patient] = pat.Name and n.[Vorname Patient] = pat.Vorname and n.Geburtsdatum = pat.Geburtsdatum
 WHERE p.BMBH_PID <> ''
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SEARCH_TABLES]    Script Date: 09/03/2018 15:14:07 ******/
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
USE [CLIN106_DATA]
GO
/****** Object:  ForeignKey [FK_CART_ITEMS_CART01]    Script Date: 09/03/2018 15:14:12 ******/
ALTER TABLE [dbo].[CART_ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_CART_ITEMS_CART01] FOREIGN KEY([CART_ORIGREC])
REFERENCES [dbo].[CART] ([ORIGREC])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CART_ITEMS] CHECK CONSTRAINT [FK_CART_ITEMS_CART01]
GO
/****** Object:  ForeignKey [FK_INVENTORY_CENTRALRECEIVIN05]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD  CONSTRAINT [FK_INVENTORY_CENTRALRECEIVIN05] FOREIGN KEY([EXTERNAL_ID])
REFERENCES [dbo].[CENTRALRECEIVING] ([EXTERNAL_ID])
GO
ALTER TABLE [dbo].[INVENTORY] CHECK CONSTRAINT [FK_INVENTORY_CENTRALRECEIVIN05]
GO
/****** Object:  ForeignKey [FK_INVENTORY_INVENTORY_TYPE06]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD  CONSTRAINT [FK_INVENTORY_INVENTORY_TYPE06] FOREIGN KEY([INVENTORY_TYPE])
REFERENCES [dbo].[INVENTORY_TYPE] ([INVENTORY_TYPE_CODE])
GO
ALTER TABLE [dbo].[INVENTORY] CHECK CONSTRAINT [FK_INVENTORY_INVENTORY_TYPE06]
GO
/****** Object:  ForeignKey [FK_INVENTORY_MATERIALS08]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD  CONSTRAINT [FK_INVENTORY_MATERIALS08] FOREIGN KEY([CONTAINER_TYPE])
REFERENCES [dbo].[MATERIALS] ([MATCODE])
GO
ALTER TABLE [dbo].[INVENTORY] CHECK CONSTRAINT [FK_INVENTORY_MATERIALS08]
GO
/****** Object:  ForeignKey [FK_INVENTORY_METADATA07]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD  CONSTRAINT [FK_INVENTORY_METADATA07] FOREIGN KEY([METADATA_GUID])
REFERENCES [dbo].[METADATA] ([ID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[INVENTORY] CHECK CONSTRAINT [FK_INVENTORY_METADATA07]
GO
/****** Object:  ForeignKey [INVENTORY_FK2]    Script Date: 09/03/2018 15:14:14 ******/
ALTER TABLE [dbo].[INVENTORY]  WITH CHECK ADD  CONSTRAINT [INVENTORY_FK2] FOREIGN KEY([MATCODE])
REFERENCES [dbo].[MATERIALS] ([MATCODE])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[INVENTORY] CHECK CONSTRAINT [INVENTORY_FK2]
GO
