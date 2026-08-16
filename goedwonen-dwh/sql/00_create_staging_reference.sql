-- =====================================================================
-- Staging-tabel voor weerdata. Alle objecten van GoedWonen Zuid liggen in
-- Zuid-Limburg, dus geen locatie-koppeling nodig: 1 rij per dag, opgehaald
-- voor een vast punt (Heerlen) als representatief voor de regio.
-- =====================================================================

CREATE SCHEMA stg
GO

-- Staging-mirror van de OLTP-tabellen (zelfde kolommen/types als de bron,
-- geen constraints — dat is de rol van dbo.* in het sterretjesmodel)
CREATE TABLE [stg].[ADRES]
(
    ADRES_ID    INT,
    POSTCODE    NVARCHAR(MAX),
    HUISNUMMER  INT,
    STRAATNAAM  NVARCHAR(MAX),
    WOONPLAATS  NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[COMPLEX]
(
    BOT_ID              BIGINT,
    OBJECTINGANGSDATUM  NVARCHAR(MAX),
    INGANGSDATUM        NVARCHAR(MAX),
    VOLGNUMMER          NVARCHAR(MAX),
    TYPEN               NVARCHAR(MAX),
    DATUMEINDE          NVARCHAR(MAX),
    SUBCOMPLEX          NVARCHAR(MAX),
    ETAGE               FLOAT,
    GANG                FLOAT,
    COMPLEX_STATUS      NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[WERKSOORT]
(
    SOORT_ID        BIGINT,
    CODE            BIGINT,
    OMSCHRIJVING    NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[OBJECTEN]
(
    BOT_ID          BIGINT,
    INGANGSDATUM    NVARCHAR(MAX),
    OBJECT_TYPE     NVARCHAR(MAX),
    DAEB_YN         NVARCHAR(MAX),
    ADRES_ID        INT,
    NAAM            NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[PROJECT]
(
    PROJECT_ID          BIGINT,
    OMSCHRIJVING        NVARCHAR(MAX),
    BEGROTEBEDRAGBTW    FLOAT,
    STARTDATUM          NVARCHAR(MAX),
    EINDDATUM           NVARCHAR(MAX),
    MEMO                NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[PROJECTREGEL]
(
    PROJECTREGEL_ID BIGINT,
    BOT_ID          BIGINT,
    PROJECT_ID      BIGINT,
    BEGROTEBEDRAG   FLOAT,
    STARTDATUM      NVARCHAR(MAX),
    EINDDATUM       NVARCHAR(MAX),
    JAAR            NVARCHAR(MAX),
    MEMO            NVARCHAR(MAX),
    OMSCHRIJVING    NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[WERKVERZOEK]
(
    WERKVERZOEK_ID  BIGINT,
    OMSCHRIJVING    NVARCHAR(MAX),
    PROJECT_ID      BIGINT,
    AFGEROND        NVARCHAR(MAX),
    MELDDATUM       NVARCHAR(MAX),
    MEMO            NVARCHAR(MAX),
    BONJAAR         NVARCHAR(MAX),
    BONNMMR         BIGINT,
    CST_ID_INVOER   BIGINT,
    BOT_ID          BIGINT
)
GO

CREATE TABLE [stg].[WERKOPDRACHT]
(
    OPDRACHT_ID     BIGINT,
    SOORT_ID        BIGINT,
    WERKVERZOEK_ID  BIGINT,
    OPDRACHTDATUM   NVARCHAR(MAX),
    STARTDATUM      NVARCHAR(MAX),
    EINDDATUM       NVARCHAR(MAX),
    BON             BIGINT,
    AFGEROND        NVARCHAR(MAX)
)
GO

CREATE TABLE [stg].[WEER]
(
    DATUM               DATE NOT NULL,
    GEM_TEMPERATUUR_C   DECIMAL(5,1),
    MIN_TEMPERATUUR_C   DECIMAL(5,1),
    MAX_TEMPERATUUR_C   DECIMAL(5,1),
    NEERSLAG_MM         DECIMAL(6,1),
    WINDKRACHT_BFT      INT,
    MAX_WINDSTOOT_KMH   DECIMAL(5,1),
    WEERTYPE            VARCHAR(50)
)
GO
