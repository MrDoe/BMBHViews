
-- Note: 'GBA' needs to be replaced by the according linked server name

USE [BMBH-Views]
GO

/****** Object:  View [dbo].[V_DONORS]    Script Date: 18.04.2018 17:24:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_DONORS] as
select * from OPENQUERY(GBA, 'select * from samplystore.public.donors');
GO

/****** Object:  View [dbo].[V_DONORS_NOJSON]    Script Date: 18.04.2018 17:24:59 ******/
CREATE VIEW [dbo].[V_DONORS_NOJSON] as
select id, 
transaction_id, 
samply_store_unique_name as 'Donor-ID', 
[urn:gba:dataelement:25:1] as 'Geschlecht',
[urn:gba:dataelement:29:1] as 'Geburtsdatum'
from V_DONORS v
cross apply OPENJSON(data)
with (samply_store_unique_name char(8),
	  [urn:gba:dataelement:25:1] nvarchar(6),
	  [urn:gba:dataelement:29:1] char(10) )
GO

/****** Object:  View [dbo].[V_EVENTS]    Script Date: 18.04.2018 17:25:10 ******/
CREATE VIEW [dbo].[V_EVENTS] as
select * from OPENQUERY(GBA, 'select * from samplystore.public.events');
GO

/****** Object:  View [dbo].[V_SAMPLECONTEXTS]    Script Date: 18.04.2018 17:25:21 ******/
CREATE VIEW [dbo].[V_SAMPLECONTEXTS] as
select * from OPENQUERY(GBA, 'select * from samplystore.public."sampleContexts"');
GO
USE [master]
GO

/****** Object:  View [dbo].[V_SAMPLECONTEXTS_NOJSON]    Script Date: 18.04.2018 17:25:33 ******/
CREATE VIEW [dbo].[V_SAMPLECONTEXTS_NOJSON] as
select id, 
donor_id, 
transaction_id, samply_store_unique_name as 'Context-ID', [urn:gba:dataelement:24:2] as 'ICD-10'
from V_SAMPLECONTEXTS v
cross apply OPENJSON(data)
with (samply_store_unique_name nvarchar(100),
	  [urn:gba:dataelement:24:2] nvarchar(10) )
GO

/****** Object:  View [dbo].[V_Samples]    Script Date: 18.04.2018 17:25:46 ******/
CREATE VIEW [dbo].[V_Samples] as
select * from OPENQUERY(GBA, 'select * from samplystore.public.samples');
GO

/****** Object:  View [dbo].[V_SAMPLES_NOJSON]    Script Date: 18.04.2018 17:25:56 ******/
CREATE VIEW [dbo].[V_SAMPLES_NOJSON] as
select id, 
sampleContext_id, 
collection_id, 
transaction_id, samply_store_unique_name as 'Proben-ID', [urn:gba:dataelement:22:1] as 'Eingangsdatum'
from V_Samples v
cross apply OPENJSON(data)
with (samply_store_unique_name nvarchar(100),
	  [urn:gba:dataelement:22:1] char(10) )
GO
