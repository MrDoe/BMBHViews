USE [BMBH_Views]
GO
/****** Object:  Table [dbo].[IDTable]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookups]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[PANELS]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[PatientSearch]    Script Date: 11.01.2019 13:40:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleViews]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](50) NOT NULL,
	[RoleId] [nvarchar](50) NULL,
	[AllowPatientSearch] [nchar](1) NULL,
 CONSTRAINT [PK_UserRoles_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Recursive_Log]    Script Date: 11.01.2019 13:40:38 ******/
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_Recursive_Temp]    Script Date: 11.01.2019 13:40:38 ******/
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
/****** Object:  Table [dbo].[V_Save_Ext_Search]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[V_Save_Search]    Script Date: 11.01.2019 13:40:38 ******/
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
	[SearchName] [nvarchar](50) NULL,
	[Logic] [nvarchar](4) NULL,
	[Sorter] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[V_VALUECNT]    Script Date: 11.01.2019 13:40:38 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [IX_V_VALUECNT] UNIQUE NONCLUSTERED 
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VIEW_SETTINGS]    Script Date: 11.01.2019 13:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VIEW_SETTINGS](
	[VIEW_NAME] [nvarchar](50) NOT NULL,
	[VIEW_CAPTION] [nvarchar](50) NULL,
	[PANEL_NAME] [nvarchar](50) NULL,
	[USE_LOOKUPS] [bit] NOT NULL,
 CONSTRAINT [PK_VIEW_SETTINGS] PRIMARY KEY CLUSTERED 
(
	[VIEW_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Lookups_Attribute_ViewName]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_Lookups_Attribute_ViewName] ON [dbo].[Lookups]
(
	[Attribute] ASC,
	[ViewName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PatientSearch]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PatientSearch] ON [dbo].[PatientSearch]
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_1]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PatientSearch_1] ON [dbo].[PatientSearch]
(
	[BMBH_PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_2]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PatientSearch_2] ON [dbo].[PatientSearch]
(
	[Histo_Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_3]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PatientSearch_3] ON [dbo].[PatientSearch]
(
	[ISH_PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PatientSearch_4]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_PatientSearch_4] ON [dbo].[PatientSearch]
(
	[ISH_FID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_V_VALUECNT_1]    Script Date: 11.01.2019 13:40:38 ******/
CREATE NONCLUSTERED INDEX [IX_V_VALUECNT_1] ON [dbo].[V_VALUECNT]
(
	[ViewName] ASC,
	[Attribut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_Textcolor]  DEFAULT ('#000000') FOR [Textcolor]
GO
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_Bordercolor]  DEFAULT ('#FFFFFF') FOR [Bordercolor]
GO
ALTER TABLE [dbo].[PANELS] ADD  CONSTRAINT [DF_PANELS_ShowPatientSearch]  DEFAULT ((0)) FOR [ShowPatientSearch]
GO
ALTER TABLE [dbo].[RoleViews] ADD  CONSTRAINT [DF_RoleViews_Permitted]  DEFAULT ((0)) FOR [Permission]
GO
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_AllowPatientSearch]  DEFAULT (N'N') FOR [AllowPatientSearch]
GO
ALTER TABLE [dbo].[VIEW_SETTINGS] ADD  CONSTRAINT [DF_VIEW_SETTINGS_USE_LOOKUPS]  DEFAULT ((0)) FOR [USE_LOOKUPS]
GO
ALTER TABLE [dbo].[Lookups]  WITH CHECK ADD  CONSTRAINT [FK_Lookups_Lookups] FOREIGN KEY([ID])
REFERENCES [dbo].[Lookups] ([ID])
GO
ALTER TABLE [dbo].[Lookups] CHECK CONSTRAINT [FK_Lookups_Lookups]
GO
