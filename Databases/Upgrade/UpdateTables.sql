USE [BMBH_Views]
GO
/****** Object:  View [dbo].[V_PatientSearch_HN_Searchform]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_HN_Searchform]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[V_PatientSearch_HN_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''V_PatientSearch_HN''
' 
GO
/****** Object:  View [dbo].[V_PatientSearch_IF_Searchform]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_IF_Searchform]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[V_PatientSearch_IF_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''V_PatientSearch_IF''
' 
GO
/****** Object:  View [dbo].[V_PatientSearch_IP_Searchform]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_IP_Searchform]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[V_PatientSearch_IP_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''V_PatientSearch_IP''
' 
GO
/****** Object:  View [dbo].[V_PatientSearch_NVG_Searchform]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_NVG_Searchform]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[V_PatientSearch_NVG_Searchform] AS
	   SELECT COLUMN_NAME AS Attribut, ''='' AS Operator, null AS Wert, DATA_TYPE AS Datentyp, 
       CASE WHEN DATA_TYPE LIKE ''%char'' THEN ''DropDownList'' WHEN DATA_TYPE LIKE ''date%'' THEN ''Calendar'' ELSE ''TextBox'' END AS Controltype, 0 as ValueCnt
	   FROM INFORMATION_SCHEMA.COLUMNS
	   WHERE TABLE_NAME = ''V_PatientSearch_NVG''
' 
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Documents](
	[DocID] [int] IDENTITY(1,1) NOT NULL,
	[FilePath] [nvarchar](255) NULL,
	[FileName] [nvarchar](50) NULL,
	[FileType] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[ShortName] [nvarchar](50) NULL,
	[Timestamp] [datetime] NULL,
	[PanelID] [nvarchar](50) NULL,
	[Sorter] [smallint] NULL,
	[Version] [smallint] NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[DocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IDTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IDTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nID] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Lookups]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lookups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Lookups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ViewName] [nvarchar](50) NULL,
	[Attribute] [nvarchar](50) NULL,
	[Text] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
 CONSTRAINT [PK_Lookups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PANELS]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PANELS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PANELS](
	[PanelID] [nvarchar](50) NOT NULL,
	[Heading] [nvarchar](50) NULL,
	[SubHeading] [nvarchar](255) NULL,
	[Backcolor] [char](7) NULL,
	[Textcolor] [char](7) NULL,
	[Bordercolor] [char](7) NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Sorter] [int] NULL,
	[ShowPatientSearch] [bit] NULL,
 CONSTRAINT [PK_PANELS] PRIMARY KEY CLUSTERED 
(
	[PanelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RoleDocs]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleDocs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RoleDocs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[DocId] [int] NULL,
	[Permission] [bit] NULL,
 CONSTRAINT [PK_RoleDocs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09.05.2019 11:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RoleViews]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleViews]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RoleViews](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ViewName] [nvarchar](100) NULL,
	[RoleId] [int] NULL,
	[Permission] [tinyint] NOT NULL,
 CONSTRAINT [PK_RoleViews] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SysConfig]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SysConfig]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SysConfig](
	[ORIGREC] [int] IDENTITY(1,1) NOT NULL,
	[OPTION_NAME] [nvarchar](50) NULL,
	[OPTION_VALUE] [nvarchar](255) NULL,
 CONSTRAINT [PK_SysConfig] PRIMARY KEY CLUSTERED 
(
	[ORIGREC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-- insert default values
SET IDENTITY_INSERT [dbo].[SysConfig] ON 
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (1, N'EMAIL_SERVER_ADDRESS', N'161.42.230.120')
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (2, N'EMAIL_SERVER_PORT', N'25')
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (3, N'EMAIL_USERNAME', N'bmbhinfo')
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (4, N'EMAIL_PASSWORD', N'******')
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (5, N'EMAIL_FROM_NAME', N'BioMaterialBank Heidelberg')
INSERT [dbo].[SysConfig] ([ORIGREC], [OPTION_NAME], [OPTION_VALUE]) VALUES (7, N'EMAIL_FROM_ADDRESS', N'info@biobank-heidelberg.de')
SET IDENTITY_INSERT [dbo].[SysConfig] OFF
END
GO

/****** Object:  Table [dbo].[UserRoles]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](50) NOT NULL,
	[RoleId] [nvarchar](50) NULL,
	[AllowPatientSearch] [nchar](1) NULL,
 CONSTRAINT [PK_UserRoles_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_PatientSearch_BP_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_BP_Search]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_PatientSearch_BP_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Wert] [nvarchar](max) NULL,
	[Datatype] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[Controltype] [nvarchar](20) NULL,
	[ValueCnt] [int] NULL,
	[Logic] [nvarchar](6) NULL,
	[Sorter] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_BP_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_PatientSearch_HN_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_HN_Search]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_PatientSearch_IF_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_IF_Search]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_PatientSearch_IP_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_IP_Search]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_PatientSearch_NVG_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_PatientSearch_NVG_Search]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_Recursive_Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_Recursive_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Iteration] [int] NOT NULL,
	[SQL] [nvarchar](max) NULL,
	[SearchMode] [nvarchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_Recursive_Temp]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_Recursive_Temp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_Recursive_Temp](
	[ID] [int] NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Timestamp] [timestamp] NOT NULL,
	[Iteration] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_Save_Ext_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_Save_Ext_Search]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_Save_Ext_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SQL] [nvarchar](max) NULL,
	[UserId] [nvarchar](50) NULL,
	[ViewName] [nvarchar](50) NULL,
	[SearchName] [nvarchar](50) NULL,
 CONSTRAINT [PK_V_Save_Ext_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_Save_Search]') AND type in (N'U'))
BEGIN
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
	[SearchName] [nvarchar](50) NULL,
	[Logic] [nvarchar](4) NULL,
	[Sorter] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_STARLIMS_DEPT]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_STARLIMS_DEPT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_STARLIMS_DEPT](
	[DEPT] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_V_STARLIMS_DEPT] PRIMARY KEY CLUSTERED 
(
	[DEPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_STARLIMS_USERS]    Script Date: 09.05.2019 11:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_STARLIMS_USERS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_STARLIMS_USERS](
	[USRNAM] [nvarchar](50) NULL,
	[FULLNAME] [nvarchar](50) NULL,
	[DEPTLIST] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 09.05.2019 11:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V_VALUECNT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V_VALUECNT](
	[ViewName] [nvarchar](50) NOT NULL,
	[Attribut] [nvarchar](50) NOT NULL,
	[ValueCnt] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_V_VALUECNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [IX_V_VALUECNT] UNIQUE NONCLUSTERED 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[VIEW_SETTINGS]    Script Date: 09.05.2019 11:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VIEW_SETTINGS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VIEW_SETTINGS](
	[VIEW_NAME] [nvarchar](50) NOT NULL,
	[VIEW_CAPTION] [nvarchar](50) NULL,
	[PANEL_NAME] [nvarchar](50) NULL,
	[USE_LOOKUPS] [bit] NOT NULL,
	[SORTER] [smallint] NOT NULL,
 CONSTRAINT [PK_VIEW_SETTINGS] PRIMARY KEY CLUSTERED 
(
	[VIEW_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Lookups_Attribute_ViewName]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Lookups]') AND name = N'IX_Lookups_Attribute_ViewName')
CREATE NONCLUSTERED INDEX [IX_Lookups_Attribute_ViewName] ON [dbo].[Lookups]
(
	[Attribute] ASC,
	[ViewName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PatientSearch]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND name = N'IX_PatientSearch')
CREATE NONCLUSTERED INDEX [IX_PatientSearch] ON [dbo].[PatientSearch]
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_1]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND name = N'IX_PatientSearch_1')
CREATE NONCLUSTERED INDEX [IX_PatientSearch_1] ON [dbo].[PatientSearch]
(
	[BMBH_PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_2]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND name = N'IX_PatientSearch_2')
CREATE NONCLUSTERED INDEX [IX_PatientSearch_2] ON [dbo].[PatientSearch]
(
	[Histo_Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_3]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND name = N'IX_PatientSearch_3')
CREATE NONCLUSTERED INDEX [IX_PatientSearch_3] ON [dbo].[PatientSearch]
(
	[ISH_PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_4]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PatientSearch]') AND name = N'IX_PatientSearch_4')
CREATE NONCLUSTERED INDEX [IX_PatientSearch_4] ON [dbo].[PatientSearch]
(
	[ISH_FID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_V_VALUECNT_1]    Script Date: 09.05.2019 11:35:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[V_VALUECNT]') AND name = N'IX_V_VALUECNT_1')
CREATE NONCLUSTERED INDEX [IX_V_VALUECNT_1] ON [dbo].[V_VALUECNT]
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Documents_Timestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Documents] ADD  CONSTRAINT [DF_Documents_Timestamp]  DEFAULT (getdate()) FOR [Timestamp]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Documents_Sorter]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Documents] ADD  CONSTRAINT [DF_Documents_Sorter]  DEFAULT ((0)) FOR [Sorter]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PANELS_Textcolor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_Textcolor]  DEFAULT ('#000000') FOR [Textcolor]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PANELS_Bordercolor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_Bordercolor]  DEFAULT ('#FFFFFF') FOR [Bordercolor]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PANELS_ShowPatientSearch]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_ShowPatientSearch]  DEFAULT ((0)) FOR [ShowPatientSearch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_RoleViews_Permitted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RoleViews] ADD  CONSTRAINT [DF_RoleViews_Permitted]  DEFAULT ((0)) FOR [Permission]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_UserRoles_AllowPatientSearch]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_AllowPatientSearch]  DEFAULT (N'N') FOR [AllowPatientSearch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_VIEW_SETTINGS_USE_LOOKUPS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VIEW_SETTINGS] ADD  CONSTRAINT [DF_VIEW_SETTINGS_USE_LOOKUPS]  DEFAULT ((0)) FOR [USE_LOOKUPS]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_VIEW_SETTINGS_SORTER]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VIEW_SETTINGS] ADD  CONSTRAINT [DF_VIEW_SETTINGS_SORTER]  DEFAULT ((0)) FOR [SORTER]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Lookups_Lookups]') AND parent_object_id = OBJECT_ID(N'[dbo].[Lookups]'))
ALTER TABLE [dbo].[Lookups]  WITH CHECK ADD  CONSTRAINT [FK_Lookups_Lookups] FOREIGN KEY([ID])
REFERENCES [dbo].[Lookups] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Lookups_Lookups]') AND parent_object_id = OBJECT_ID(N'[dbo].[Lookups]'))
ALTER TABLE [dbo].[Lookups] CHECK CONSTRAINT [FK_Lookups_Lookups]
GO
