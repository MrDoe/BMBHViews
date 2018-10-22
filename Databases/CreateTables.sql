USE [BMBH_Views]
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 10/22/2018 09:12:15 ******/
DROP TABLE [dbo].[IDTable]
GO
/****** Object:  Table [dbo].[PANELS]    Script Date: 10/22/2018 09:12:15 ******/
ALTER TABLE [dbo].[PANELS] DROP CONSTRAINT [DF_PANELS_Textcolor]
GO
ALTER TABLE [dbo].[PANELS] DROP CONSTRAINT [DF_PANELS_Bordercolor]
GO
ALTER TABLE [dbo].[PANELS] DROP CONSTRAINT [DF_PANELS_ShowPatientSearch]
GO
DROP TABLE [dbo].[PANELS]
GO
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[PatientSearch]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[RoleViews]    Script Date: 10/22/2018 09:12:16 ******/
ALTER TABLE [dbo].[RoleViews] DROP CONSTRAINT [DF_RoleViews_Permitted]
GO
DROP TABLE [dbo].[RoleViews]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 10/22/2018 09:12:16 ******/
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [DF_UserRoles_AllowPatientSearch]
GO
DROP TABLE [dbo].[UserRoles]
GO
/****** Object:  Table [dbo].[V_PatientSearch_BP_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_PatientSearch_BP_Search]
GO
/****** Object:  Table [dbo].[V_PatientSearch_HN_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_PatientSearch_HN_Search]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IF_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_PatientSearch_IF_Search]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IP_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_PatientSearch_IP_Search]
GO
/****** Object:  Table [dbo].[V_PatientSearch_NVG_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_PatientSearch_NVG_Search]
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_Recursive_Log]
GO
/****** Object:  Table [dbo].[V_Recursive_Temp]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_Recursive_Temp]
GO
/****** Object:  Table [dbo].[V_Save_Ext_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_Save_Ext_Search]
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_Save_Search]
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[V_VALUECNT]
GO
/****** Object:  Table [dbo].[VIEW_SETTINGS]    Script Date: 10/22/2018 09:12:16 ******/
DROP TABLE [dbo].[VIEW_SETTINGS]
GO
/****** Object:  Table [dbo].[VIEW_SETTINGS]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VIEW_SETTINGS](
	[VIEW_NAME] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[VIEW_CAPTION] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[PANEL_NAME] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_VIEW_SETTINGS] PRIMARY KEY CLUSTERED 
(
	[VIEW_NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_VALUECNT](
	[ViewName] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[ValueCnt] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_V_VALUECNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [IX_V_VALUECNT] UNIQUE NONCLUSTERED 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_V_VALUECNT_1] ON [dbo].[V_VALUECNT] 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Save_Search](
	[_ID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[Attribut] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Operator] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Wert] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueCnt] [int] NULL,
	[ViewName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SearchName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Save_Ext_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Save_Ext_Search](
	[ID] [int] NOT NULL,
	[SQL] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[ViewName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[SearchName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_V_Save_Ext_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Recursive_Temp]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Recursive_Temp](
	[ID] [int] NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Timestamp] [timestamp] NOT NULL,
	[Iteration] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_Recursive_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Iteration] [int] NOT NULL,
	[SQL] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SearchMode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_PatientSearch_NVG_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_NVG_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Operator] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wert] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_NVG_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IP_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_IP_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Operator] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wert] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_IP_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_PatientSearch_IF_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_IF_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Operator] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wert] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_IF_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_PatientSearch_HN_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_HN_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Operator] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wert] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[ValueCnt] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_HN_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_PatientSearch_BP_Search]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_PatientSearch_BP_Search](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Attribut] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Operator] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wert] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Datatype] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Controltype] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[ValueCnt] [int] NULL,
	[Logic] [nvarchar](3) COLLATE Latin1_General_CI_AS NULL,
	[Sorter] [int] NULL,
 CONSTRAINT [PK_V_PatientSearch_BP_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[RoleId] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[AllowPatientSearch] [nchar](1) COLLATE Latin1_General_CI_AS NULL CONSTRAINT [DF_UserRoles_AllowPatientSearch]  DEFAULT (N'N'),
 CONSTRAINT [PK_UserRoles_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleViews]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleViews](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ViewName] [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
	[RoleId] [int] NULL,
	[Permission] [tinyint] NOT NULL CONSTRAINT [DF_RoleViews_Permitted]  DEFAULT ((0)),
 CONSTRAINT [PK_RoleViews] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 10/22/2018 09:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientSearch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[Vorname] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[Geburtsdatum] [date] NULL,
	[ISH_PID] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[ISH_FID] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[BMBH_PID] [nchar](8) COLLATE Latin1_General_CI_AS NULL,
	[GUID] [uniqueidentifier] NULL,
	[Histo_Nr] [nvarchar](13) COLLATE Latin1_General_CI_AS NULL,
	[Status] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[Timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_PatientSearch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch] ON [dbo].[PatientSearch] 
(
	[GUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_1] ON [dbo].[PatientSearch] 
(
	[BMBH_PID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_2] ON [dbo].[PatientSearch] 
(
	[Histo_Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_3] ON [dbo].[PatientSearch] 
(
	[ISH_PID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PatientSearch_4] ON [dbo].[PatientSearch] 
(
	[ISH_FID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PANELS]    Script Date: 10/22/2018 09:12:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PANELS](
	[PanelID] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Heading] [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
	[SubHeading] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[Backcolor] [char](7) COLLATE Latin1_General_CI_AS NULL,
	[Textcolor] [char](7) COLLATE Latin1_General_CI_AS NULL CONSTRAINT [DF_PANELS_Textcolor]  DEFAULT ('#000000'),
	[Bordercolor] [char](7) COLLATE Latin1_General_CI_AS NULL CONSTRAINT [DF_PANELS_Bordercolor]  DEFAULT ('#FFFFFF'),
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Sorter] [int] NULL,
	[ShowPatientSearch] [bit] NULL CONSTRAINT [DF_PANELS_ShowPatientSearch]  DEFAULT ((0)),
 CONSTRAINT [PK_PANELS] PRIMARY KEY CLUSTERED 
(
	[PanelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 10/22/2018 09:12:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nID] [int] NOT NULL
) ON [PRIMARY]
GO
