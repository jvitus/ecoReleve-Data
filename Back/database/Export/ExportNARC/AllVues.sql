USE [EcoReleve_Export_NARC]
GO
/****** Object:  View [dbo].[VWildlife_EnjilDam]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VWildlife_EnjilDam]
GO
/****** Object:  View [dbo].[VTrapping_Houbara_all]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VTrapping_Houbara_all]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_5j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_Last_5j]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_45j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_Last_45j]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_10j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_Last_10j]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_45j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_FromToday_45j]
GO
/****** Object:  View [dbo].[VSCO_ObsPoint]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_ObsPoint]
GO
/****** Object:  View [dbo].[VSCO_Houbara]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_Houbara]
GO
/****** Object:  View [dbo].[VSCO_Gazelles]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_Gazelles]
GO
/****** Object:  View [dbo].[VSCO_Anthropogenic_Impact]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_Anthropogenic_Impact]
GO
/****** Object:  View [dbo].[VReleased_OtherSpecies_FirstStation]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VReleased_OtherSpecies_FirstStation]
GO
/****** Object:  View [dbo].[VReleased_Houbara_FirstStation]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VReleased_Houbara_FirstStation]
GO
/****** Object:  View [dbo].[VNestHoubara_AllStations_RelatedFemaleData]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VNestHoubara_AllStations_RelatedFemaleData]
GO
/****** Object:  View [dbo].[VNestAllSpeciesNest_EggsData]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VNestAllSpeciesNest_EggsData]
GO
/****** Object:  View [dbo].[VMonitoredSiteLastPosition]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VMonitoredSiteLastPosition]
GO
/****** Object:  View [dbo].[VMonitoredSiteEquipementHisto_SensorInformation]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VMonitoredSiteEquipementHisto_SensorInformation]
GO
/****** Object:  View [dbo].[VMonitoredSiteEquipement_SensorInformation]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VMonitoredSiteEquipement_SensorInformation]
GO
/****** Object:  View [dbo].[VMonitoredSiteEquipement]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VMonitoredSiteEquipement]
GO
/****** Object:  View [dbo].[VMicrochipScanning_all]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VMicrochipScanning_all]
GO
/****** Object:  View [dbo].[VIndividuEquipementHisto]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndividuEquipementHisto]
GO
/****** Object:  View [dbo].[VIndiv_Historical_Sensor_Info]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndiv_Historical_Sensor_Info]
GO
/****** Object:  View [dbo].[VDisplay_Houbara_all]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VDisplay_Houbara_all]
GO
/****** Object:  View [dbo].[VDeath_AllIndiv_FirstStaData]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VDeath_AllIndiv_FirstStaData]
GO
/****** Object:  View [dbo].[VSCO_Simplified_Habitat]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_Simplified_Habitat]
GO
/****** Object:  View [dbo].[VSensor_FirstAndLastData]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_FirstAndLastData]
GO
/****** Object:  View [dbo].[VIndividuLastLocationBySensorType]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndividuLastLocationBySensorType]
GO
/****** Object:  View [dbo].[VIndiv_Current_Sensor_Info]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndiv_Current_Sensor_Info]
GO
/****** Object:  View [dbo].[VIndivVHF_LastStation]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndivVHF_LastStation]
GO
/****** Object:  View [dbo].[VBirthYearWildJuvenile]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VBirthYearWildJuvenile]
GO
/****** Object:  View [dbo].[VSCO_Wildlife]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSCO_Wildlife]
GO
/****** Object:  View [dbo].[VStations_ForMap]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VStations_ForMap]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_5j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_FromToday_5j]
GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_10j]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VSensor_GPSLoc_FromToday_10j]
GO
/****** Object:  View [dbo].[VIndividuEquipement]    Script Date: 22/03/2016 13:57:34 ******/
DROP VIEW [dbo].[VIndividuEquipement]
GO
/****** Object:  View [dbo].[VIndividuEquipement]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VIndividuEquipement]
AS
SELECT E.ID,E.FK_Sensor,E.FK_Individual,FK_Observation 
FROM [EcoReleve_NARC].dbo.Equipment E
WHERE E.FK_Individual IS NOT NULL
AND NOT EXISTS (SELECT *  FROM [EcoReleve_NARC].dbo.Equipment E2 where E2.FK_Individual = E.FK_Individual and E2.StartDate > E.StartDate)
AND E.Deploy =1



GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_10j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VSensor_GPSLoc_FromToday_10j]
AS
SELECT IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType, i.Sex, i.Release_Ring_Code AS ReleaSeRing, 
                  i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, IL1.ID AS Sta_ID, IL1.Date AS StaDate, CONVERT(time, IL1.Date) AS StaHour, IL1.LAT, IL1.LON, 
                  IL1.Precision, IL1.creationDate, CONVERT(VARCHAR(50), s.UnicIdentifier) AS Sensor_Station, CONVERT(VARCHAR(255), RIGHT(s.Model, CHARINDEX('>', REVERSE(s.Model)) 
                  - 1)) AS SensorModel_Station, CONVERT(VARCHAR(255), RIGHT(s.Compagny, CHARINDEX('>', REVERSE(s.Compagny)) - 1)) AS SensorCompagny_Station, 
                  CONVERT(VARCHAR(50), e.UnicIdentifier) AS CurrentSensor, CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.Model)) - 1)) AS CurrentSensorModel, 
                  CONVERT(VARCHAR(255), RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny)) - 1)) AS CurrentSensorCompany, CONVERT(VARCHAR(255), e.SerialNumber) 
                  AS CurrentSensorSN, CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
FROM     (SELECT FK_Individual, Date, type_, LAT, LON, Precision, ID, creationDate, FK_Sensor
                  FROM      EcoReleve_NARC.dbo.Individual_Location AS IL
                  WHERE   (type_ IN ('gps', 'GSM')) AND (Date > GETDATE() - 10)) AS IL1 INNER JOIN
                  dbo.TIndividu AS i ON IL1.FK_Individual = i.ID AND i.Monitoring_Status IS NOT NULL AND i.Monitoring_Status <> 'Retiré' INNER JOIN
                  dbo.TSensor AS s ON IL1.FK_Sensor = s.ID INNER JOIN
                      (SELECT ie.FK_Sensor, ie.FK_Individual, ts.ID, ts.UnicIdentifier, ts.Model, ts.Compagny, ts.SerialNumber, ts.creationDate, ts.FK_SensorType, ts.OldID, ts.Original_ID, 
                                         ts.Weight, ts.Status, ts.BatteryType, ts.Harness, ts.InitialLivespan, ts.Argos_DutyCycle, ts.Argos_TransmissionFrequency, ts.Transmitter_Frequency, 
                                         ts.Comments, ts.Shape
                       FROM      dbo.VIndividuEquipement AS ie INNER JOIN
                                         dbo.TSensor AS ts ON ie.FK_Sensor = ts.ID) AS e ON IL1.FK_Individual = e.FK_Individual

GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_5j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create view [dbo].[VSensor_GPSLoc_FromToday_5j] as

SELECT  IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType,
		 i.Sex AS Sex, i.Release_Ring_Code AS ReleaSeRing, i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, 
		il1.ID AS Sta_ID,IL1.Date AS StaDate, CONVERT(time, il1.date) AS StaHour,IL1.LAT  ,IL1.LON , il1.Precision, il1.creationDate,
	   CONVERT(VARCHAR(50),s.UnicIdentifier) AS Sensor_Station,
	   CONVERT(VARCHAR(255),RIGHT(s.Model, CHARINDEX('>', REVERSE(s.model))-1)) AS SensorModel_Station, 
	   CONVERT(VARCHAR(255), RIGHT (s.Compagny, CHARINDEX('>', REVERSE(s.compagny))-1)) as SensorCompagny_Station,
	   CONVERT(VARCHAR(50),e.UnicIdentifier) AS CurrentSensor, 
	   CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.model))-1)) AS CurrentSensorModel, 
	   CONVERT(VARCHAR(255),RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny))-1)) AS CurrentSensorCompany, 
	   CONVERT(VARCHAR(255),e.SerialNumber) AS CurrentSensorSN
      ,CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
		FROM (
			 SELECT Il.FK_Individual, il.Date, il.type_, il.LAT, il.LON, il.Precision, il.ID, il.creationDate, il.FK_Sensor
			 
			 FROM [EcoReleve_NARC].dbo.Individual_Location IL
			 WHERE  IL.Type_ in ( 'gps','GSM') and il.Date>GETDATE()-5) IL1 
					 JOIN TIndividu i 
					 ON IL1.FK_Individual =i.ID AND i.Monitoring_Status is not null AND  i.Monitoring_Status != 'Retiré'
					 JOIN [TSensor] s 
					 ON il1.FK_sensor = s.ID 
					 join 
						(SELECT ie.FK_Sensor, ie.FK_Individual, ts.* 
						FROM VIndividuEquipement ie 
						inner join TSensor ts 
						ON ie.FK_Sensor = ts.ID) e
					 ON il1.FK_Individual = e.FK_Individual
					

GO
/****** Object:  View [dbo].[VStations_ForMap]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VStations_ForMap]
AS
SELECT s.ID AS Sta_ID, CONVERT(VARCHAR(255), s.Name) AS Name, s.StationDate AS Date, s.LAT AS Lat, s.LON AS Lon, f.Name AS FieldActivity, s.Place, CONVERT(varchar(255), 
                  r.Region) AS Region, s.precision, s.ELE, s.creator, s.creationDate, CONVERT(VARCHAR(255), m.Name) AS MonitoredSite_Name, s.Comments AS Sta_Comments, 
                  m.Category AS MonitoredSite_Category, s.original_id, CONVERT(VARCHAR(255), replace('@' +
                      (SELECT ',' + Tuse_FirstName + ' ' + Tuse_LAStname
                       FROM      EcoReleve_NARC.[dbo].[Station_FieldWorker] SF JOIN
                                         SECURITE.dbo.TUsers U ON SF.FK_FieldWorker = u.[TUse_PK_ID]
                       WHERE   S.ID = SF.fk_station
                       ORDER BY Tuse_LAStname FOR xml path('')), '@,', '')) FieldWorkers, s.NbFieldWorker, s.FK_MonitoredSite
FROM     Tstation S 
		LEFT OUTER JOIN
        EcoReleve_NARC.dbo.fieldActivity f 
        ON s.fieldActivityId = f.ID 
        LEFT OUTER JOIN
        EcoReleve_NARC.dbo.Region r 
        ON s.FK_Region = r.ID LEFT OUTER JOIN
        EcoReleve_NARC.dbo.MonitoredSite m 
        ON s.FK_MonitoredSite = m.ID




GO
/****** Object:  View [dbo].[VSCO_Wildlife]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[VSCO_Wildlife] AS
SELECT o.fk_monitoredsite as MS_ID,O.MonitoredSite_Name AS MS_Name,o.MS_LAT AS MS_Lat, o.MS_LON AS MS_Lon, 
		o.OFA AS ObsPt_FA,o.Region, o.Place,O.OStaID AS ObsPt_StaID, 
		CAST(REPLACE(o.original_id, 'eReleve_','') AS real) AS ObsPt_Sta_eR_ID,
		O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,
		O.OLat AS ObsPt_Lat, O.OLon AS ObsPt_Lon, o.OEle AS ObsPt_Elev, O.FieldWorkers AS FW, CONVERT(time,o.Start_time) AS ObsPt_Start_Time,
		CONVERT(time,o.Observation_Duration) AS ObsPt_Duration, H.HFA AS Obj_FA,H.HDate AS Obj_Date,
		H.HStaID AS Obj_StaId,
		CAST(REPLACE(H.original_id, 'eReleve_','') AS real) AS Obj_Sta_eRID,
		H.HName AS Obj_Name,  H.HLat AS Obj_Lat, H.HLon AS Obj_Lon, H.HEle AS Obj_Elev , H.Taxon AS Taxon_Name,
		h.NbInd AS Nb,h.Behaviour , h.Distance,  H.ObsTime,  H.HPK AS VertGroup_PK, h.Comments AS Obj_Comments
		FROM
				(SELECT MonitoredSite_Name,p.LAT AS MS_LAT, p.LON AS MS_LON, s.Name AS true_Obs_point,  FieldActivity AS OFA, date AS Odate,  CONVERT(date, DATE) AS truedate,
						CASE WHEN CONVERT(time, date) < '13:00:00' then 'AM' ELSE 'PM' END AS 'time', s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers,
						Region, Place, s.ELE AS OEle, c.Start_time, c.Observation_Duration, s.original_id, s.fk_monitoredsite
				FROM VStations_ForMap s 
				INNER JOIN
				VMonitoredSiteLAStPosition p
				on s.fk_monitoredsite = p.MonitoredSiteID
				INNER JOIN
				tprotocol_sighting_conditions AS c
				ON s.sta_id = c.FK_Station
					WHERE MonitoredSite_Category = 'SCO' and c.ID is not null and c.Observation_Incomplete = 0  ) AS O
		LEFT OUTER JOIN 
				(SELECT MonitoredSite_Name, name AS HName,  FieldActivity AS HFA,  CONVERT(date, date, 103) AS truedate, 
						CASE WHEN CONVERT(time, date, 108) < '13:00:00' 
						then 'AM' 
						ELSE 'PM' END AS 'time', Lat AS HLat, Lon AS HLon, ELE AS HEle,date AS HDate, sta_id AS HStaID, V.meASured_distance AS distance, v.Nb_Total AS NbInd, v.Taxon, 
						v.observation_time AS ObsTime, v.ID AS HPK, v.Comments, v.Behaviour, s1.original_id
				FROM VStations_ForMap AS S1 
				INNER JOIN TProtocol_Vertebrate_Group AS V 
				ON S1.sta_id = v.FK_Station
					WHERE   MonitoredSite_Category = 'SCO' and V.ID is not null and v.taxon not like '%undulata') AS H
		ON (O.MonitoredSite_Name = H.MonitoredSite_Name and O.truedate = H.truedate and O.time = H.time)


 



















GO
/****** Object:  View [dbo].[VBirthYearWildJuvenile]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[VBirthYearWildJuvenile] as
SELECT i.id as Ind_ID, YEAR(s.Date) as YearofBirth
FROM VStations_ForMap s
INNER JOIN
TIndividualFirstStation c
ON s.Sta_ID = c.FirstStation_ID 
INNER JOIN TProtocol_Bird_Biometry b
ON c.FirstStation_ID = b.FK_Station and c.FK_Individual = b.FK_Individual
INNER JOIN
TIndividu i
ON c.FK_Individual = i.ID
WHERE b.Age in ( 'juvénile' , 'poussin') and Origin = 'sauvage'


GO
/****** Object:  View [dbo].[VIndivVHF_LastStation]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIndivVHF_LastStation] as
SELECT s.sta_id, s.Name, s.Date, s.Region, s.Place, s.Lat, s.Lon, s.FieldActivity, s.FieldWorkers, s.MonitoredSite_Category, s.MonitoredSite_Name, s.Sta_Comments,
		il.Source, i.Ind_ID, [Species],[Age],[Birth_date],[Death_date],[Release_Ring_Position],[Release_Ring_Color],[Release_Ring_Code],[Breeding_Ring_Position],
		[Breeding_Ring_Color],[Breeding_Ring_Code],[Chip_Code],[Mark_Color_1],[Mark_Position_1],[Mark_Color_2],[Mark_Position_2],[Origin],i.[Comments] as Ind_Comments,[Mark_code_1],
		[Mark_code_2],[Individual_Status],[Monitoring_Status],[Survey_type],[Sex], i.UnicIdentifier as Sensor_Station, i.SensorFrequency as SensorFrequency_Station,
		i.sensorCompany as SensorCompany_Station, i.SensorModel as SensorModel_Station, 
		CASE WHEN i.Origin = 'relaché' then YEAR(i.Birth_date) 
			 WHEN i.Origin = 'sauvage' and juv.yearofbirth IS NOT NULL THEN juv.yearofbirth ELSE NULL END AS Cohort
FROM 
	VStations_ForMap s
INNER JOIN
	TIndividualLastLocationAllSource il
ON s.sta_id = il.fk_station
INNER JOIN
	VIndiv_Current_Sensor_Info i
ON il.FK_Individual = i.ind_id
LEFT OUTER JOIN
VBirthYearWildJuvenile juv
ON i.ind_id = juv.ind_id
WHERE i.SensorType = 'vhf'

GO
/****** Object:  View [dbo].[VIndiv_Current_Sensor_Info]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VIndiv_Current_Sensor_Info]
AS
SELECT i.ID as Ind_ID, i.creationDate, i.Species, i.Age, i.Birth_date, i.Death_date, i.FK_IndividualType, i.Original_ID, i.Caisse_ID, i.UnicIdentifier, i.Release_Ring_Position, i.Release_Ring_Color, 
                  i.Release_Ring_Code, i.Breeding_Ring_Position, i.Breeding_Ring_Color, i.Breeding_Ring_Code, i.Chip_Code, i.Mark_Color_1, i.Mark_Position_1, i.Mark_Color_2, 
                  i.Mark_Position_2, i.Origin, i.Comments, i.Mark_code_1, i.Mark_code_2, i.Individual_Status, i.Monitoring_Status, i.Survey_type, i.Sex, i.Poids, i.Date_Sortie, s.ID AS SensorID, 
                  s.UnicIdentifier AS SensorIdentifier, s.Transmitter_Frequency AS SensorFrequency, s.Compagny AS SensorCompany, s.Model AS SensorModel, 
                  s.SerialNumber AS SensorSN, s.Shape AS SensorShape, s.Weight AS SensorWeight, s.Argos_DutyCycle AS Argos_DutyCycle, 
                  s.Argos_TransmissionFrequency AS Argos_TransmissionFrequency, s.BatteryType AS BatteryType, s.Comments AS SensorComments, s.InitialLivespan AS InitialLivespan, 
                  s.Status AS SensorStatus, s.creationDate AS SensorCreationDate, t.Name AS SensorType
FROM     
TIndividu AS i 
LEFT OUTER JOIN
VIndividuEquipement AS e 
ON i.ID = e.FK_Individual 
LEFT OUTER JOIN
TSensor AS s 
ON e.FK_Sensor = s.ID LEFT OUTER JOIN
 EcoReleve_NARC.dbo.SensorType AS t ON s.FK_SensorType = t.ID



GO
/****** Object:  View [dbo].[VIndividuLastLocationBySensorType]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIndividuLastLocationBySensorType]
AS
SELECT TOP (100) PERCENT ind.ID AS 'ID Individu', MAX(CASE WHEN indloc.type_ = 'gps' THEN indloc.ID ELSE NULL END) AS [ID GPS], 
                  MAX(CASE WHEN indloc.type_ = 'gps' THEN indloc.LAT ELSE NULL END) AS [LAT GPS], MAX(CASE WHEN indloc.type_ = 'gps' THEN indloc.LON ELSE NULL END) 
                  AS [LON GPS], MAX(CASE WHEN indloc.type_ = 'gps' THEN indloc.DATE ELSE NULL END) AS [DATE GPS], 
                  MAX(CASE WHEN indloc.type_ = 'gps' THEN CONVERT(NVARCHAR(255), reg.Region) ELSE NULL END) AS [Region GPS], 
                  MAX(CASE WHEN indloc.type_ = 'gps' THEN CONVERT(NVARCHAR(255), reg.Country) ELSE NULL END) AS [Country GPS], 
                  MAX(CASE WHEN indloc.type_ = 'gps' THEN indloc.FK_Sensor ELSE NULL END) AS [SENSOR GPS], MAX(CASE WHEN indloc.type_ = 'argos' THEN indloc.ID ELSE NULL END) 
                  AS [ID ARGOS], MAX(CASE WHEN indloc.type_ = 'argos' THEN indloc.LAT ELSE NULL END) AS [LAT ARGOS], 
                  MAX(CASE WHEN indloc.type_ = 'argos' THEN indloc.LON ELSE NULL END) AS [LON ARGOS], MAX(CASE WHEN indloc.type_ = 'argos' THEN indloc.DATE ELSE NULL END) 
                  AS [DATE ARGOS], MAX(CASE WHEN indloc.type_ = 'argos' THEN CONVERT(NVARCHAR(255), reg.Region) ELSE NULL END) AS [Region ARGOS], 
                  MAX(CASE WHEN indloc.type_ = 'argos' THEN CONVERT(NVARCHAR(255), reg.Country) ELSE NULL END) AS [Country ARGOS], 
                  MAX(CASE WHEN indloc.type_ = 'argos' THEN indloc.FK_Sensor ELSE NULL END) AS [SENSOR ARGOS], MAX(CASE WHEN indloc.type_ = 'GSM' THEN indloc.ID ELSE NULL 
                  END) AS [ID GSM], MAX(CASE WHEN indloc.type_ = 'GSM' THEN indloc.LAT ELSE NULL END) AS [LAT GSM], 
                  MAX(CASE WHEN indloc.type_ = 'GSM' THEN indloc.LON ELSE NULL END) AS [LON GSM], MAX(CASE WHEN indloc.type_ = 'GSM' THEN indloc.DATE ELSE NULL END) 
                  AS [DATE GSM], MAX(CASE WHEN indloc.type_ = 'GSM' THEN reg.Region ELSE NULL END) AS [Region GSM], 
                  MAX(CASE WHEN indloc.type_ = 'GSM' THEN CONVERT(NVARCHAR(255), reg.Country) ELSE NULL END) AS [Country GSM], 
                  MAX(CASE WHEN indloc.type_ = 'GSM' THEN CONVERT(NVARCHAR(255), indloc.FK_Sensor) ELSE NULL END) AS [SENSOR GSM], 
                  MAX(CASE WHEN indloc.type_ = 'RFID' THEN indloc.ID ELSE NULL END) AS [ID RFID], MAX(CASE WHEN indloc.type_ = 'RFID' THEN indloc.LAT ELSE NULL END) AS [LAT RFID], 
                  MAX(CASE WHEN indloc.type_ = 'RFID' THEN indloc.LON ELSE NULL END) AS [LON RFID], MAX(CASE WHEN indloc.type_ = 'RFID' THEN indloc.DATE ELSE NULL END) 
                  AS [DATE RFID], MAX(CASE WHEN indloc.type_ = 'RFID' THEN reg.Region ELSE NULL END) AS [Region RFID], 
                  MAX(CASE WHEN indloc.type_ = 'RFID' THEN CONVERT(NVARCHAR(255), reg.Country) ELSE NULL END) AS [Country RFID], 
                  MAX(CASE WHEN indloc.type_ = 'RFID' THEN CONVERT(NVARCHAR(255), indloc.FK_Sensor) ELSE NULL END) AS [SENSOR RFID]
FROM     EcoReleve_NARC.dbo.Individual AS ind LEFT OUTER JOIN
                  EcoReleve_NARC.dbo.Individual_Location AS indloc LEFT OUTER JOIN
                  EcoReleve_NARC.dbo.Region AS reg ON reg.ID = indloc.FK_Region ON indloc.FK_Individual = ind.ID AND NOT EXISTS
                      (SELECT NULL AS Expr1
                       FROM      EcoReleve_NARC.dbo.Individual_Location AS indloc2
                       WHERE   (FK_Individual = indloc.FK_Individual) AND (type_ = indloc.type_) AND (Date > indloc.Date))
WHERE  (indloc.ID IS NOT NULL)
GROUP BY ind.ID
ORDER BY 'ID Individu'

GO
/****** Object:  View [dbo].[VSensor_FirstAndLastData]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VSensor_FirstAndLastData]
AS
SELECT ind.ID AS [ID Individu], sens.SensorIdentifier AS PTT, CASE WHEN ind.Release_Ring_Code IS NULL THEN ind.Chip_Code ELSE ind.Release_Ring_Code END AS RelCaptTag, 
                  ind.Breeding_Ring_Code AS BreedingRing, ind.Sex, ind.Age, ind.Origin, ind.Monitoring_Status AS MonitoringStatus, ind.Birth_date AS BirthDate, 
                  CASE WHEN ind.Origin = 'relaché' THEN YEAR(ind.Birth_date) ELSE CASE WHEN ind.Origin = 'sauvage' THEN CASE WHEN EXISTS
                      (SELECT NULL
                       FROM      [VBirthYearWildJuvenile] birth
                       WHERE   birth.Ind_ID = ind.ID) THEN
                      (SELECT TOP 1 birth.YearofBirth
                       FROM      [VBirthYearWildJuvenile] birth
                       WHERE   birth.Ind_ID = ind.ID) ELSE NULL END ELSE NULL END END AS 'Cohorte', ind.Survey_type AS SurveyType, ind.Species, las.[DATE ARGOS] AS LastARGOSDate, 
                  las.[LAT ARGOS] AS LastARGOSLat, las.[LON ARGOS] AS 'LastARGOSLon', las.[Region ARGOS] AS 'LastARGOSRegion', las.[Country ARGOS] AS 'LastARGOSCountry', 
                  las.[DATE GSM] AS LastGSMDate, las.[LAT GSM] AS LastGSMLat, las.[LON GSM] AS LastGSMLon, las.[Region GSM] AS 'LastGSMRegion', 
                  las.[Country GSM] AS 'LastGSMCountry', las.[DATE GPS] AS LastGPSDate, las.[LAT GPS] AS LastGPSLat, las.[LON GPS] AS LastGPSLon, 
                  las.[Region GPS] AS 'LastGPSRegion', las.[Country GPS] AS 'LastGPSCountry', fir.FirstStation_ID AS firStaID, sta.Name AS FirstStaName, 
                  CASE WHEN fir.FirstStation_ID = fir.Capture_Individual_Station_ID THEN 'Capture' ELSE CASE WHEN FirstStation_ID = fir.Release_Individual_Station_ID THEN 'Release' ELSE
                   NULL END END AS FirstStaType, sta.StationDate AS FirstStaDate, sta.Place AS FirstStaPlace, reg.Region AS FirstStaRegion, sta.LAT AS FirstStaLat, 
                  sta.LON AS FirstStaLon, sta.precision AS FirstStaPrecision, fw.FieldWorkers AS FirstStaFW, fw.FieldActivity AS FirstStaFA, 
                  CASE WHEN las.[DATE ARGOS] > ISNULL(las.[DATE GPS], '01/01/1900') AND las.[DATE ARGOS] > ISNULL(las.[DATE GSM], '01/01/1900') AND 
                  las.[DATE ARGOS] > ISNULL(sta.StationDate, '01/01/1900') THEN las.[LAT ARGOS] ELSE CASE WHEN las.[DATE GPS] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND 
                  las.[DATE GPS] > ISNULL(las.[DATE GSM], '01/01/1900') AND las.[DATE GPS] > ISNULL(Sta.StationDate, '01/01/1900') 
                  THEN las.[LAT GPS] ELSE CASE WHEN las.[DATE GSM] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND las.[DATE GSM] > ISNULL(las.[DATE GPS], '01/01/1900') AND 
                  las.[DATE GSM] > ISNULL(Sta.StationDate, '01/01/1900') THEN las.[LAT GSM] ELSE Sta.LAT END END END AS MostRecentLat, 
                  CASE WHEN las.[DATE ARGOS] > ISNULL(las.[DATE GPS], '01/01/1900') AND las.[DATE ARGOS] > ISNULL(las.[DATE GSM], '01/01/1900') AND 
                  las.[DATE ARGOS] > ISNULL(sta.StationDate, '01/01/1900') THEN las.[LON ARGOS] ELSE CASE WHEN las.[DATE GPS] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND 
                  las.[DATE GPS] > ISNULL(las.[DATE GSM], '01/01/1900') AND las.[DATE GPS] > ISNULL(Sta.StationDate, '01/01/1900') 
                  THEN las.[LON GPS] ELSE CASE WHEN las.[DATE GSM] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND las.[DATE GSM] > ISNULL(las.[DATE GPS], '01/01/1900') AND 
                  las.[DATE GSM] > ISNULL(Sta.StationDate, '01/01/1900') THEN las.[LON GSM] ELSE Sta.LON END END END AS MostRecentLon, 
                  CASE WHEN las.[DATE ARGOS] > ISNULL(las.[DATE GPS], '01/01/1900') AND las.[DATE ARGOS] > ISNULL(las.[DATE GSM], '01/01/1900') AND 
                  las.[DATE ARGOS] > ISNULL(sta.StationDate, '01/01/1900') THEN las.[Region ARGOS] ELSE CASE WHEN las.[DATE GPS] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND 
                  las.[DATE GPS] > ISNULL(las.[DATE GSM], '01/01/1900') AND las.[DATE GPS] > ISNULL(Sta.StationDate, '01/01/1900') 
                  THEN las.[Region GPS] ELSE CASE WHEN las.[DATE GSM] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND las.[DATE GSM] > ISNULL(las.[DATE GPS], '01/01/1900') AND 
                  las.[DATE GSM] > ISNULL(Sta.StationDate, '01/01/1900') THEN las.[Region GSM] ELSE reg.Region END END END AS MostRecentRegion, 
                  CASE WHEN las.[DATE ARGOS] > ISNULL(las.[DATE GPS], '01/01/1900') AND las.[DATE ARGOS] > ISNULL(las.[DATE GSM], '01/01/1900') AND 
                  las.[DATE ARGOS] > ISNULL(sta.StationDate, '01/01/1900') THEN las.[Country ARGOS] ELSE CASE WHEN las.[DATE GPS] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND 
                  las.[DATE GPS] > ISNULL(las.[DATE GSM], '01/01/1900') AND las.[DATE GPS] > ISNULL(Sta.StationDate, '01/01/1900') 
                  THEN las.[Country GPS] ELSE CASE WHEN las.[DATE GSM] > ISNULL(las.[DATE ARGOS], '01/01/1900') AND las.[DATE GSM] > ISNULL(las.[DATE GPS], '01/01/1900') AND 
                  las.[DATE GSM] > ISNULL(Sta.StationDate, '01/01/1900') THEN las.[Country GSM] ELSE reg.Country END END END AS MostRecentCountry, DATEDIFF(DAY, las.[DATE ARGOS], 
                  GETUTCDATE()) AS DateDiffARGOS, DATEDIFF(DAY, las.[DATE GPS], GETUTCDATE()) AS DateDiffGPS, DATEDIFF(DAY, las.[DATE GSM], GETUTCDATE()) 
                  AS DateDiffGSM
FROM     dbo.TIndividu AS ind INNER JOIN
                  dbo.VIndiv_Current_Sensor_Info AS sens ON sens.Ind_ID = ind.ID AND sens.SensorID IS NOT NULL INNER JOIN
                  dbo.VIndividuLastLocationBySensorType AS las ON las.[ID Individu] = ind.ID INNER JOIN
                  dbo.TIndividualFirstStation AS fir INNER JOIN
                  dbo.TStation AS sta LEFT OUTER JOIN
                  EcoReleve_NARC.dbo.Region AS reg ON reg.ID = sta.FK_Region ON sta.ID = fir.FirstStation_ID ON fir.FK_Individual = ind.ID INNER JOIN
                  dbo.VStations_ForMap AS fw ON fw.Sta_ID = fir.FirstStation_ID

GO
/****** Object:  View [dbo].[VSCO_Simplified_Habitat]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[VSCO_Simplified_Habitat] AS
SELECT o.fk_monitoredsite as MS_ID,O.MonitoredSite_Name AS MS_Name,o.MS_LAT, o.MS_LON, o.OFA AS ObsPt_FA, 
		o.Region, o.Place,O.OStaID AS ObsPt_StaID,
		CAST(REPLACE(o.original_id, 'eReleve_','') AS REAL) AS ObsPt_Sta_eR_ID,
		O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,O.OLat AS ObsPt_Lat, 
		O.OLon AS ObsPt_Lon, o.OEle AS ObsPt_Elev, 
		O.FW,convert(time,o.Start_time) AS ObsPt_Start_time, convert(time,o.Observation_Duration) AS ObsPt_Duration,
		AI.AIFA AS Obj_FA,AI.AIdate AS Obj_Date,AI.AIStaID AS Obj_StaID, 
		CAST(REPLACE(AI.original_id, 'eReleve_','') AS REAL) AS Obj_Sta_eRID,AI.AIName AS Obj_Name, 
		AI.AILat AS Obj_Lat, 
		AI.AILon AS Obj_Lon, AI.AIEle AS Obj_Elev , 
		AI.habitat, ai.habitat2, ai.flora_main_species_1, ai.flora_main_species_2,ai.flora_main_species_3,
		ai.vegetation_cover, ai.perennial_cover,AI.AIPK AS Habitat_PK,
		ai.AIComments AS Obj_Comments
FROM
		(SELECT s.MonitoredSite_Name,p.LAT AS MS_LAT, p.LON AS MS_LON, s.Name AS true_Obs_point,  
				FieldActivity AS OFA, date AS Odate,  CONVERT(date, date, 103) AS truedate,
				CASe when CONVERT(time, date, 108) < '13:00:00' then 'AM' else 'PM' end AS 'time', 
				s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers AS FW, 
				Region, Place, s.ELE AS OEle, c.Start_time, c.Observation_Duration, s.original_id, s.fk_monitoredsite
				FROM VStations_ForMap s
		INNER JOIN
		VMonitoredSiteLAStPosition  p
		ON s.fk_monitoredsite = p.MonitoredSiteID
		INNER JOIN
		tprotocol_sighting_conditions AS c
		ON s.sta_id = c.FK_Station
				WHERE  MonitoredSite_Category = 'sco' and c.ID IS NOT NULL ) AS O
LEFT OUTER JOIN 
		(SELECT MonitoredSite_Name, name AS AIName,  
				FieldActivity AS AIFA, DATE,  CONVERT(date, date, 103) AS truedate, 
				CASe when CONVERT(time, date, 108) < '13:00:00' 
				then 'AM' 
				else 'PM' end AS 'time', Lat AS AILat, Lon AS AILon, ELE AS AIEle,date AS AIDate, 
				sta_id AS AIStaID, a.habitat, a.habitat2,
				a.flora_main_species_1, a.flora_main_species_2, a.flora_main_species_3, 
				a.vegetation_cover, a.perennial_cover,
				a.Comments AS AIComments, a.ID AS AIPK, S1.original_id
			FROM VStations_ForMap AS S1 
			INNER JOIN 
			TProtocol_Simplified_habitat AS A 
			ON S1.sta_id = A.FK_Station
					WHERE  MonitoredSite_Category = 'sco' and A.ID is not null) AS AI
ON (O.MonitoredSite_Name = AI.MonitoredSite_Name and O.truedate = AI.truedate and O.time = AI.time)


 
















GO
/****** Object:  View [dbo].[VDeath_AllIndiv_FirstStaData]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[VDeath_AllIndiv_FirstStaData] as
SELECT  i.ID AS Ind_ID, i.Breeding_Ring_Code AS BreedRing, 
			CASE WHEN i.Origin = 'relaché' then year(i.Birth_date) WHEN i.Origin = 'wild' AND juv.yearofbirth IS not null then yearofbirth end AS Cohort
			,i.Chip_Code AS ChipCode,
			i.ReleASe_Ring_Code AS RelRing,i.Origin AS Origin, i.Sex AS Sex,
			fe.UnicIdentifier AS SensorFirstSta,fe.Transmitter_Frequency AS FrequencyFirstSta, fe.Compagny AS SensorCompanyFirstSta,fe.Model AS SensorModelFirstSta,
			i.Birth_date AS BirthDate, i.Death_date AS DeathDate,
			de.SensorIdentifier AS DeathStaPTT, de.SensorFrequency AS DeathStaVHF, de.SensorCompany AS SensorCompanyDeathtSta,de.SensorModel AS SensorModelDeathSta,
			s.Sta_ID AS DeathStaID,s.Name , s.DATE , s.LAT , s.LON ,
			s.Precision , s.Region , s.Place, d.Taxon AS Taxon, 
			d.death_reASon , d.Death_Time , d.Sure_reASon AS Sure, d.Sampled, d.Comments AS DeathComments,
			f.FirstStation_ID AS FirstStaID, f.Name AS FirstStaName, f.Date AS FirstStaDate,f.Region AS FirstStaRegion, f.LAT AS FirstStaLAT, f.LON AS FirstStaLON,
			d.ID AS DeathPK
	FROM 
		VStations_ForMap s
	INNER JOIN 
		TProtocol_Vertebrate_Individual_Death d
	ON s.Sta_ID = d.FK_Station
	LEFT OUTER JOIN
		TIndividu i
	INNER JOIN 
		(SELECT *
			FROM 
				VStations_ForMap s2
			INNER JOIN 
				TIndividualFirstStation AS f1
			ON s2.Sta_ID = f1.FirstStation_ID AND f1.FirstStation_ID is not null) f
		ON i.ID = f.FK_Individual
		ON d.FK_Individual = i.ID
	LEFT OUTER JOIN
		TSensor fe
	ON f.FK_Sensor_FirstStation = fe.ID
	LEFT OUTER JOIN
		VBirthYearWildJuvenile juv
	ON f.FK_Individual = juv.ind_id
	LEFT OUTER JOIN
		VIndiv_Historical_Sensor_Info de
	ON (d.FK_Individual = de.Ind_ID
				AND NOT EXISTS ( SELECT NULL 
									FROM VIndiv_Historical_Sensor_Info de2
									WHERE de2.ind_ID = de.ind_ID AND de2.StartDate>de.StartDate
									AND de2.StartDate<= s.Date) AND de.StartDate<=s.Date AND de.Deploy = 1) 










GO
/****** Object:  View [dbo].[VDisplay_Houbara_all]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[VDisplay_Houbara_all] as
SELECT    sta.*,ind.Ind_ID, ind.SensorIdentifier,
			ind.SensorFrequency , ind.SensorCompany, ind.SensorModel, 
			ind.SensorSN , 
			ind.Monitoring_Status,
			ind.Survey_type,
			ind.Age, ind.Release_Ring_Code, ind.Chip_Code , 
			ind.Breeding_Ring_Code , ind.Sex, ind.Origin, 
			ind.Birth_date , ind.Death_date , pri.Behaviour AS Individual_behaviour, 
			prg.Measured_Distance, 
			pri.ID AS PK_VIndiv
FROM        
	(SELECT    pr.ID,  pr.frequency, pr.sex,  pr.age, pr.signal_type,  
				  pr.Posture,  pr.Behaviour,    pr.Comments, pr.Sampled, 
				  pr.Disturbed, pr.FK_Station, pr.Parent_Observation, pr.FK_Individual
		FROM         
			TProtocol_Vertebrate_Individual AS pr 
		WHERE      (pr.behaviour like 'interaction sexuelle%')) AS pri 
INNER JOIN
	(SELECT * 
		FROM  
			TProtocol_Vertebrate_Group 
		WHERE Taxon LIKE '%undulata') prg 
ON pri.Parent_Observation = prg.ID 
LEFT OUTER JOIN
	VIndiv_Historical_Sensor_Info AS ind 
ON pri.FK_Individual = ind.Ind_ID 
INNER JOIN
	VStations_ForMap AS sta 
ON pri.FK_Station = sta.Sta_ID






GO
/****** Object:  View [dbo].[VIndiv_Historical_Sensor_Info]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[VIndiv_Historical_Sensor_Info] AS
SELECT i.ID as Ind_ID,i.[Species],i.[Age],i.[Birth_date],i.[Death_date],i.[FK_IndividualType],i.[Original_ID],i.[Release_Ring_Position],i.[Release_Ring_Color],i.[Release_Ring_Code]
		,i.[Breeding_Ring_Position], i.[Breeding_Ring_Color],i.[Breeding_Ring_Code],i.[Chip_Code],i.[Mark_Color_1],i.[Mark_Position_1],i.[Mark_Color_2],i.[Mark_Position_2],i.[Origin]
        ,i.[Comments], i.[Mark_code_1],i.[Mark_code_2],i.Status_,i.[Monitoring_Status],i.[Survey_type],i.[Sex] , 
		s.ID AS SensorID, s.UnicIdentifier AS SensorIdentifier, s.Transmitter_Frequency AS SensorFrequency, s.Compagny AS SensorCompany, 
		s.Model AS SensorModel, s.SerialNumber AS SensorSN, s.Shape AS SensorShape, s.Weight AS SensorWeight, s.Argos_DutyCycle, s.Argos_TransmissionFrequency, s.BatteryType,
		s.Comments AS SensorComments, s.InitialLivespan, s.Status AS SensorStatus, s.creationDate AS SensorCreationDate, e.StartDate, e.Deploy, t.Name AS SensorType
FROM 
	TIndividu i
LEFT OUTER JOIN 
	VIndividuEquipementHisto e
ON i.ID = e.FK_Individual
LEFT OUTER JOIN 
	TSensor s
ON e.FK_Sensor = s.ID
LEFT OUTER JOIN
	EcoReleve_NARC.dbo.SensorType t
ON s.FK_SensorType = t.ID






GO
/****** Object:  View [dbo].[VIndividuEquipementHisto]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIndividuEquipementHisto]
AS
SELECT *
FROM [EcoReleve_NARC].dbo.Equipment E
WHERE E.FK_Individual IS NOT NULL


GO
/****** Object:  View [dbo].[VMicrochipScanning_all]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[VMicrochipScanning_all] as
SELECT e.Sensor AS RFIDModule, m.Name AS Site_Name, e.StartDate,  a.FK_Individual AS Ind_ID, 
		a.date AS ReadingDate,a.LAT, a.LON,i.Species AS Taxon,
		i.Origin ,i.Sex, i.Age,
		i.Chip_Code, i.Breeding_Ring_Code , 
		i.Release_Ring_Code , s.SensorIdentifier AS CurrentSensor, s.SensorFrequency AS CurrentSensorFrequency,
		s.SensorCompany AS CurrentSensorCompany, s.SensorModel AS CurrentSensorModel, s.SensorID,
		i.Individual_Status AS IndStatus, i.Monitoring_Status AS MonStatus, 
		i.Survey_type AS SurveyType, i.Birth_date , i.Death_date ,
		i.Comments AS IndComments, 
		CASE WHEN f.FirstStation_ID = f.Release_Individual_Station_ID THEN 'Release'
		WHEN f.FirstStation_ID = f.Capture_Individual_Station_ID THEN 'Capture' END AS RelCapStatype, 
		sta.Date AS RelCapStaDate, sta.Region AS RelCapStaRegion
FROM 
	EcoReleve_NARC.dbo.Individual_Location a
INNER JOIN
	TIndividualFirstStation f
ON a.FK_Individual = f.FK_Individual and a.type_ = 'rfid'
INNER JOIN
	VMonitoredSiteEquipementHisto_SensorInformation e
ON (a.FK_Sensor = e.sensorid
				AND NOT EXISTS ( SELECT NULL 
									FROM VMonitoredSiteEquipementHisto_SensorInformation e2
									WHERE e2.SensorID = e.SensorID AND e2.StartDate>e.StartDate
									AND e2.StartDate<= a.Date) AND e.StartDate<=a.Date AND e.Deploy = 1) 
INNER JOIN 
	VMonitoredSiteLAStPosition m
ON e.MonitoredSite_ID = m.MonitoredSiteID
INNER JOIN
	TIndividu i
ON a.FK_Individual = i.ID
LEFT OUTER JOIN
	VIndiv_Current_Sensor_Info s
ON a.FK_Individual = s.Ind_ID 
LEFT OUTER JOIN
	VStations_ForMap sta
ON f.FirstStation_ID = sta.Sta_ID
				


GO
/****** Object:  View [dbo].[VMonitoredSiteEquipement]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VMonitoredSiteEquipement]
AS
SELECT E.ID,E.FK_Sensor,E.FK_MonitoredSite,FK_Observation 
FROM [EcoReleve_NARC].dbo.Equipment E
WHERE E.FK_MonitoredSite IS NOT NULL
AND NOT EXISTS (SELECT *  FROM [EcoReleve_NARC].dbo.Equipment E2 where E2.FK_MonitoredSite = E.FK_MonitoredSite and E2.StartDate > E.StartDate)
AND E.Deploy =1


GO
/****** Object:  View [dbo].[VMonitoredSiteEquipement_SensorInformation]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VMonitoredSiteEquipement_SensorInformation] AS
SELECT m.Name AS MS_Name, m.Category AS MS_Category, t.Name AS Sensor_Type, s.UnicIdentifier AS Sensor, s.Compagny AS SensorCompany, s.Model AS SensorModel, s.SerialNumber AS SensorSN,
		s.Comments AS SensorComments, e.StartDate, e.Deploy, s.ID as SensorID, m.ID as MonitoredSite_ID
FROM 
(SELECT * 
	FROM EcoReleve_NARC.dbo.Equipment e 
	WHERE FK_MonitoredSite is not null and NOT EXISTS (SELECT *  
														FROM [EcoReleve_NARC].dbo.Equipment E2 
														WHERE E2.FK_MonitoredSite = E.FK_MonitoredSite and E2.StartDate > E.StartDate)AND E.Deploy =1 )e

INNER JOIN 
EcoReleve_NARC.dbo.MonitoredSite m
on e.FK_MonitoredSite = m.ID
INNER JOIN
TSensor s
on e.FK_Sensor = s.ID
INNER JOIN 
EcoReleve_NARC.dbo.SensorType t
on s.FK_SensorType = t.ID



GO
/****** Object:  View [dbo].[VMonitoredSiteEquipementHisto_SensorInformation]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VMonitoredSiteEquipementHisto_SensorInformation] AS
SELECT m.Name AS MS_Name, m.Category AS MS_Category, t.Name AS Sensor_Type, s.UnicIdentifier AS Sensor, s.Compagny AS SensorCompany, s.Model AS SensorModel, s.SerialNumber AS SensorSN,
		s.Comments AS SensorComments, e.StartDate, e.Deploy, s.ID as SensorID, m.ID as MonitoredSite_ID
FROM EcoReleve_NARC.dbo.Equipment e
INNER JOIN 
 EcoReleve_NARC.dbo.MonitoredSite m
ON e.FK_MonitoredSite = m.ID
INNER JOIN
TSensor s
ON e.FK_Sensor = s.ID
INNER JOIN 
EcoReleve_NARC.dbo.SensorType t
ON s.FK_SensorType = t.ID


GO
/****** Object:  View [dbo].[VMonitoredSiteLastPosition]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[VMonitoredSiteLastPosition] as
select m.*, p.LAT, p.LON, p.ELE, p.Precision, p.Comments, p.StartDate, p.ModificationDate, m.ID as MonitoredSiteID
from EcoReleve_NARC.dbo.MonitoredSite m
inner join 
EcoReleve_NARC.dbo.MonitoredSitePosition p
on m.ID = p.FK_MonitoredSite
where not exists (select * from EcoReleve_NARC.dbo.MonitoredSitePosition p2 where p2.StartDate>p.StartDate and p2.FK_MonitoredSite = p.FK_MonitoredSite)

GO
/****** Object:  View [dbo].[VNestAllSpeciesNest_EggsData]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VNestAllSpeciesNest_EggsData] as
SELECT s.sta_id, s.MonitoredSite_Name, s.Name, s.Date, s.Lat, s.Lon, s.Region, s.Place, s.FieldWorkers,
		n.Name_Taxon,n.Name_Clutch_Description, n.Name_Clutch_Size,n.Comments as NestComments, c.Egg_code, c.weight, c.Length, c.Width, 
		c.Name_EggStatus, u.Observer as MeasuredBy, c.Comments as EggComments, c.sampled, c.Collected
FROM VStations_ForMap s
INNER JOIN 
TProtocol_Nest_description  n
ON s.sta_id = n.FK_Station
INNER JOIN
TProtocol_Clutch_description c
ON n.ID = c.Parent_Observation
LEFT OUTER JOIN
EcoReleve_NARC.dbo.[User] u
ON c.Measured_by = u.ID


GO
/****** Object:  View [dbo].[VNestHoubara_AllStations_RelatedFemaleData]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VNestHoubara_AllStations_RelatedFemaleData] as
SELECT  DISTINCT 
		  sta.MonitoredSite_Name AS [Site_name], sta.sta_id, sta.name, sta.FieldWorkers,
		  sta.Region, sta.Place, sta.date, sta.Lat, 
		  sta.Lon, sta.FieldActivity, 
		  nest.Name_Taxon,
		  nest.Name_Clutch_Description, 
		  nest.Name_Clutch_Size, 
		  nest.Dummy_egg , 
		  Eggs.Nb_Item,
		  g.Nb_NewBorn_Indeterminate AS NB_newborn_alive, d.NbDeadChick as Nb_newborn_dead,
		  (COALESCE(g.Nb_NewBorn_Indeterminate,0) + COALESCE(d.NbDeadChick,0)) as TotNbNewborn,
		  ind.Ind_ID, 
		  Ind.Individual_Status AS CurrentIndividualStatus,
		  ind.Survey_type AS CurrentSurveyType, ind.Monitoring_Status AS CurrentMonitoringStatus, 
		  ind.Age, 
		  ind.Origin, ind.SensorIdentifier AS CurrentTrx,ind.SensorFrequency AS  CurrentTrxFrequency,   
		  ind.SensorModel AS CurrentTrx_model, ind.SensorCompany AS TrxCompany,
		  ind.SensorSN AS TrxSerial_number,  
		  sensor.SensorIdentifier as Trx_Station, sensor.SensorFrequency as TrxFreq_Station,  
		  sensor.SensorCompany as TrxCompany_Station, sensor.SensorModel as TrxModel_Station,
		  ind.Sex, 
		  ind.Release_ring_code, ind.Breeding_ring_code, 
		  ind.Chip_code, ind.Birth_date AS Birth_date, 
		  ind.Death_date AS Death_date, ind.Comments AS IndivComments, 
		  nest.FK_Individual 
	FROM  
		(SELECT * 
			FROM TProtocol_Nest_Description
			WHERE Name_Taxon like '%undulata') nest
	LEFT OUTER JOIN 
	VIndiv_Current_Sensor_Info  ind
	ON ind.ind_ID = nest.FK_Individual 
	INNER JOIN  
		(SELECT * 
			FROM VStations_ForMap 
			WHERE  (MonitoredSite_category='nest')) sta
	ON nest.FK_Station = sta.sta_id
	LEFT OUTER JOIN  TProtocol_Vertebrate_Group g
	ON  sta.sta_id = g.ID AND nest.Name_Taxon  = g.taxon
	LEFT OUTER JOIN 
		(SELECT COUNT(*) as Nb_Item, Fk_nest, FK_Station 
			FROM TProtocol_Clutch_Description 
			GROUP BY fk_nest, FK_Station) as Eggs
	ON nest.ID = Eggs.FK_Nest
	LEFT OUTER JOIN
	VIndiv_Historical_Sensor_Info sensor
	ON (nest.FK_Individual = sensor.Ind_ID
		and NOT EXISTS ( SELECT * FROM VIndiv_Historical_Sensor_Info sensor2
							where sensor2.ind_ID = sensor.ind_ID and sensor2.StartDate>sensor.StartDate
							and sensor2.StartDate<= sta.Date) and sensor.StartDate<=sta.Date and sensor.Deploy = 1)
	LEFT OUTER JOIN
		(SELECT s.*, d.NbDeadChick
			FROM VStations_ForMap s
			INNER JOIN 
					(SELECT nd.sta_id, COUNT(nd.age) as NbDeadChick
						FROM 
							(SELECT s.MonitoredSite_Name, s.sta_id, name,s.FieldWorkers,  s.date, g.Taxon, 
								CASE WHEN identification_criteria like '%18877%' then 'chick' 
								WHEN identification_criteria like '%18878%' then 'juvenile' 
								WHEN identification_criteria like '%18879%' then 'adulte' 
								WHEN Identification_criteria like '18880%' then 'unknown' end as Age
							FROM VStations_ForMap s
							INNER JOIN 
							TProtocol_Vertebrate_Individual_Death g
							ON s.sta_id = g.FK_Station
								WHERE MonitoredSite_category = 'nest' and g.Taxon like '%undulata' and (CASE WHEN identification_criteria like '%18877%' then 'chick' 
								WHEN identification_criteria like '%18878%' then 'juvenile' 
								WHEN identification_criteria like '%18879%' then 'adulte' 
								WHEN Identification_criteria like '18880%' then 'unknown' end) = 'chick')nd
					GROUP BY sta_id) d
			ON s.sta_id = d.sta_id) d
	ON sta.sta_id = d.sta_id
	where sensor.SensorIdentifier is not null

















GO
/****** Object:  View [dbo].[VReleased_Houbara_FirstStation]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VReleased_Houbara_FirstStation] as
SELECT i.Ind_ID, i.Origin, i.Species as Taxon, i.Individual_Status as CurrentIndividualStatus, i.Survey_type as CurrentSurveyType, i.Monitoring_Status as CurrentMonitoringStatus, 
		i.SensorIdentifier as CurrentSensor, i.SensorFrequency as CurrentSensorFrequency, i.SensorCompany as CurrentSensorCompany, i.SensorModel as CurrentSensorModel, 
		sensor.SensorIdentifier as Sensor_Station,sensor.SensorFrequency as Frequency_Station , sensor.SensorCompany as SensorCompany_Station, sensor.SensorModel as SensorModel_Station,
		sensor.SensorSN as SensorSN_Station,
		i.Sex, i.Breeding_Ring_Code,
		i.Release_Ring_Code, i.Chip_Code, i.Mark_Color_1, i.Mark_Position_1, i.Mark_code_1, i.Mark_Color_2, i.Mark_Position_2, i.Mark_code_2, i.Birth_date, i.Death_date,
		b.weight as WeightGrs, b.skull, b.tarso_Metatarsus, rg.release_method, ri.Comments, 'Release' as StaType, sta_id, name, date, DATEDIFF(day,date,getdate()) as DaysSinceRelease,
		s.Region, s.Place, s.Lat, Lon, precision, FieldWorkers, FieldActivity, creator, s.creationDate, i.Comments as IndivComments, b.Comments as BiometryComments
	FROM 
		(SELECT * from VStations_ForMap s1
			WHERE s1.sta_id IN (SELECT FirstStation_id 
								FROM TIndividualFirstStation where Release_Individual_Station_ID IS NOT NULL )) s
	INNER JOIN
		(SELECT taxon, release_method, FK_Station, ID
				FROM TProtocol_Release_Group 
				WHERE taxon LIKE '%undulata')rg
	ON s.sta_id = rg.FK_Station
	INNER JOIN
		TProtocol_Release_Individual ri
	ON rg.ID = ri.Parent_Observation
	LEFT OUTER JOIN
		TProtocol_Bird_Biometry b
	ON ri.FK_Individual = b.FK_Individual AND s.sta_id = b.FK_Station
	LEFT OUTER JOIN
		VIndiv_Current_Sensor_Info i
	ON i.Ind_ID = ri.FK_Individual
	LEFT OUTER JOIN
		VIndiv_Historical_Sensor_Info sensor 
	ON (ri.FK_Individual = sensor.ind_ID 
				AND NOT EXISTS ( SELECT NULL FROM VIndiv_Historical_Sensor_Info sensor2
									where sensor2.ind_ID = sensor.ind_ID AND sensor2.StartDate>sensor.StartDate
									AND sensor2.StartDate<= s.Date) AND sensor.StartDate<=s.Date AND sensor.Deploy = 1) 
		



GO
/****** Object:  View [dbo].[VReleased_OtherSpecies_FirstStation]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[VReleased_OtherSpecies_FirstStation] as
SELECT i.Ind_ID, i.Origin, i.Species as Taxon, i.Individual_Status as CurrentIndividualStatus, i.Survey_type as CurrentSurveyType, i.Monitoring_Status as CurrentMonitoringStatus, 
		i.SensorIdentifier as CurrentSensor, i.SensorFrequency as CurrentSensorFrequency, i.SensorCompany as CurrentSensorCompany, i.SensorModel as CurrentSensorModel, 
		sensor.SensorIdentifier as Sensor_Station,sensor.SensorFrequency as Frequency_Station , sensor.SensorCompany as SensorCompany_Station, sensor.SensorModel as SensorModel_Station,
		sensor.SensorSN as SensorSN_Station,
		i.Sex, i.Breeding_Ring_Code,
		i.Release_Ring_Code, i.Chip_Code, i.Mark_Color_1, i.Mark_Position_1, i.Mark_code_1, i.Mark_Color_2, i.Mark_Position_2, i.Mark_code_2, i.Birth_date, i.Death_date,
		b.weight as WeightGrs, b.skull, b.tarso_Metatarsus, rg.release_method, ri.Comments, 'Release' as StaType, sta_id, name, date, DATEDIFF(day,date,getdate()) as DaysSinceRelease,
		s.Region, s.Place, s.Lat, Lon, precision, FieldWorkers, FieldActivity, creator, s.creationDate, i.Comments as IndivComments, b.Comments as BiometryComments
	FROM 
		(SELECT * FROM VStations_ForMap s1
			WHERE s1.sta_id IN (SELECT FirstStation_id FROM TIndividualFirstStation)) s
	INNER JOIN
		(SELECT *
				FROM TProtocol_Release_Group 
				WHERE taxon NOT LIKE '%undulata')rg
	ON s.sta_id = rg.FK_Station
	INNER JOIN
		TProtocol_Release_Individual ri
	ON rg.ID = ri.Parent_Observation
	LEFT OUTER JOIN
		TProtocol_Bird_Biometry b
	ON ri.FK_Individual = b.FK_Individual AND s.sta_id = b.FK_Station
	LEFT OUTER JOIN
		VIndiv_Current_Sensor_Info i
	ON i.Ind_ID = ri.FK_Individual
	LEFT OUTER JOIN
		VIndiv_Historical_Sensor_Info sensor 
	ON (ri.FK_Individual = sensor.ind_ID 
				AND NOT EXISTS ( SELECT * FROM VIndiv_Historical_Sensor_Info sensor2
									where sensor2.ind_ID = sensor.ind_ID AND sensor2.StartDate>sensor.StartDate
									AND sensor2.StartDate<= s.Date) AND sensor.StartDate<=s.Date AND sensor.Deploy = 1) 
		


GO
/****** Object:  View [dbo].[VSCO_Anthropogenic_Impact]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[VSCO_Anthropogenic_Impact] AS
SELECT o.fk_monitoredsite as MS_ID,o.MonitoredSite_Name AS MS_Name,o.MS_LAT, o.MS_LON, o.OFA AS ObsPt_FA, 
		o.Region, o.Place,O.OStaID AS ObsPt_StaID, CAST(REPLACE(o.original_id, 'eReleve_','') AS REAL) AS ObsPt_Sta_eR_ID,
		 O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,O.OLat AS ObsPt_Lat, 
		 O.OLON AS ObsPt_Lon, o.OEle AS ObsPt_Elev, 
		 O.FW,CONVERT(time, o.Start_time) AS ObsPt_Start_time, CONVERT(time,o.observation_duration) AS ObsPt_Duration,
		 AI.AIFA AS Obj_FA,AI.AIdate AS Obj_Date,AI.AIStaID AS Obj_StaID, CAST(REPLACE(AI.original_id, 'eReleve_','') AS REAL) AS Obj_Sta_eRID,AI.AIName AS Obj_Name, 
		 AI.AILat AS Obj_Lat, 
		 AI.AILon AS Obj_Lon, AI.AIEle AS Obj_Elev , 
		 AI.Name_Impact AS Anthropogenic_Name,AI.Nb_Impact AS Nb,AI.AIPK AS Anthropogenic_PK,
		 ai.AIComments AS Obj_Comments
		FROM
				(SELECT s.MonitoredSite_Name,p.LAT AS MS_LAT, p.Lon AS MS_LON, s.Name AS true_Obs_point,  
						FieldActivity AS OFA, date AS Odate,  CONVERT(date, date, 103) AS truedate,
						CASE WHEN CONVERT(time, date, 108) < '13:00:00' THEN 'AM' ELSE 'PM' end AS 'time', 
						s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers AS FW, 
						 Region, Place, s.ELE AS OEle, c.Start_time, c.observation_duration, s.original_id, s.fk_monitoredsite
						 FROM VStations_ForMap s
						 INNER JOIN
						 VMonitoredSiteLastPosition  p
						 ON s.fk_monitoredsite = p.MonitoredSiteID
						 INNER JOIN
						 TProtocol_Sighting_conditions AS c
						 ON s.sta_id = c.FK_Station
						 WHERE  MonitoredSite_Category = 'sco' and c.ID IS NOT NULL) AS O																		
		 LEFT OUTER JOIN 
						(SELECT MonitoredSite_Name, name AS AIName,  
						FieldActivity AS AIFA, DATE,  CONVERT(DATE, date, 103) AS truedate, 
						CASE WHEN CONVERT(TIME, date, 108) < '13:00:00' 
						THEN 'AM' 
						ELSE 'PM' end AS 'time', 
						Lat AS AILat, Lon AS AILon, ELE AS AIEle,date AS AIDate, 
						sta_id AS AIStaID, a.Element_Nb AS Nb_Impact, a.Impact AS Name_Impact, 
						a.Comments AS AIComments, a.ID AS AIPK, S1.original_id
						FROM VStations_ForMap AS S1 
						INNER JOIN 
						TProtocol_Building_and_Activities AS A 
						ON S1.sta_id = A.FK_Station
						WHERE  MonitoredSite_Category = 'sco' and A.ID IS NOT NULL) AS AI
		ON (O.MonitoredSite_Name = AI.MonitoredSite_Name and O.truedate = AI.truedate and O.time = AI.time)


 
















GO
/****** Object:  View [dbo].[VSCO_Gazelles]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE View [dbo].[VSCO_Gazelles] AS
		SELECT o.fk_monitoredsite as MS_ID,O.MonitoredSite_Name AS MS_Name,o.MS_LAT AS MS_Lat, o.MS_LON AS MS_Lon, 
		o.OFA AS ObsPt_FA,o.Region, o.Place,O.OStaID AS ObsPt_StaID,
		CAST(REPLACE(o.original_id, 'eReleve_','') AS REAL) AS ObsPt_Sta_eR_ID, 
		O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,
		O.OLat AS ObsPt_Lat, O.OLon AS ObsPt_Lon, o.OEle AS ObsPt_Elev, 
		O.FieldWorkers AS FW, convert(time,o.Start_time) AS ObsPt_Start_Time,
		convert(time,o.Observation_Duration) AS ObsPt_Duration, 
		H.HFA AS Obj_FA,H.HDate AS Obj_Date,H.HStaID AS Obj_StaId,
		CAST(REPLACE(H.original_id, 'eReleve_','') AS REAL) AS Obj_Sta_eRID,
		H.HName AS Obj_Name,  H.HLat AS Obj_Lat, H.HLon AS Obj_Lon, 
		H.HEle AS Obj_Elev , H.Taxon AS Taxon_Name,
		h.NbInd AS Nb,h.Behaviour , h.Distance,  H.ObsTime,  
		H.HPK AS VertGroup_PK, h.Comments AS Obj_Comments
		FROM
				(SELECT MonitoredSite_Name,p.LAT AS MS_LAT, p.LON AS MS_LON, s.name AS true_Obs_point, 
				FieldActivity AS OFA, date AS Odate,  CONVERT(date, DATE) AS truedate,
				CASE WHEN CONVERT(time, date) < '13:00:00' THEN 'AM' ELSE 'PM' end AS 'time',
				s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers,
				 Region, Place, s.ELE AS OEle,  Start_time, 
				Observation_duration, s.original_id, s.fk_monitoredsite
				FROM VStations_ForMap s 
				INNER JOIN
				VMonitoredSiteLAStPosition p
				ON s.fk_monitoredsite = p.MonitoredSiteID
				INNER JOIN
				tprotocol_sighting_conditions AS c
				ON s.sta_id = c.FK_Station
				WHERE MonitoredSite_Category = 'SCO' AND c.ID is not null AND c.Observation_Incomplete = 0  ) AS O		
		LEFT OUTER JOIN 
				(SELECT MonitoredSite_Name, name AS HName,  FieldActivity AS HFA,  CONVERT(date, date, 103) AS truedate, 
				CASE WHEN CONVERT(time, date, 108) < '13:00:00' 
				THEN 'AM' 
				ELSE 'PM' end AS 'time', Lat AS HLat, Lon AS HLon, ELE AS HEle,date AS HDate, sta_id AS HStaID, V.meASured_distance AS distance, v.Nb_Total AS NbInd, v.Taxon, 
				v.observation_time AS ObsTime, v.ID AS HPK, v.Comments, v.Behaviour, S1.original_id
				FROM VStations_ForMap AS S1
				INNER JOIN TProtocol_Vertebrate_Group AS V 
				ON S1.sta_id = v.FK_Station
				WHERE   MonitoredSite_Category = 'SCO' AND V.ID IS NOT NULL AND v.taxon LIKE 'Mammalia>Artiodactyla>%') AS H
		ON (O.MonitoredSite_Name = H.MonitoredSite_Name AND O.truedate = H.truedate AND O.time = H.time)


 





















GO
/****** Object:  View [dbo].[VSCO_Houbara]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[VSCO_Houbara] AS
	SELECT o.fk_monitoredsite as MS_ID,O.MonitoredSite_Name AS MS_Name,o.MS_LAT AS MS_Lat, o.MS_LON AS MS_Lon, 
	o.OFA AS ObsPt_FA,o.Region, o.Place,O.OStaID AS ObsPt_StaID,
	CAST(REPLACE(o.original_id, 'eReleve_','') AS real) AS ObsPt_Sta_eR_ID ,
	O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,
	O.OLat AS ObsPt_Lat, O.OLon AS ObsPt_Lon, o.OEle AS ObsPt_Elev, 
	O.FieldWorkers AS FW, convert(time,o.Start_time) AS ObsPt_Start_Time,
	convert(time,o.Observation_Duration) AS ObsPt_Duration, 
	H.HFA AS Obj_FA,H.HDate AS Obj_Date,H.HStaID AS Obj_StaId,
	CAST(REPLACE(H.original_id, 'eReleve_','') AS real) AS  Obj_Sta_eRID,
	H.HName AS Obj_Name,  H.HLat AS Obj_Lat, H.HLon AS Obj_Lon, 
	H.HEle AS Obj_Elev , H.Taxon AS Taxon_Name,
	h.NbInd AS Nb,h.Behaviour , h.Distance,  H.ObsTime,  
	H.HPK AS VertGroup_PK, h.Comments AS Obj_Comments
		FROM
				(SELECT MonitoredSite_Name,p.LAT AS MS_LAT, p.LON AS MS_LON, s.name AS true_Obs_point, 
					FieldActivity AS OFA, date AS Odate,  CONVERT(date, DATE) AS truedate,
					CASE WHEN CONVERT(time, date) < '13:00:00' THEN 'AM' else 'PM' END AS 'time',
					s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers,
					Region, Place, s.ELE AS OEle,  Start_time, 
					Observation_duration, s.original_id, s.fk_monitoredsite
				FROM VStations_ForMap s 
				INNER JOIN
				VMonitoredSiteLAStPosition p
				ON s.fk_monitoredsite = p.MonitoredSiteID
				INNER JOIN
				tprotocol_sighting_conditions AS c
				ON s.sta_id = c.FK_Station
					WHERE MonitoredSite_Category = 'SCO' and c.ID is not null and c.Observation_Incomplete = 0 ) AS O
		LEFT OUTER JOIN 
				(SELECT MonitoredSite_Name, name AS HName,  FieldActivity AS HFA,  CONVERT(date, date, 103) AS truedate, 
					CASE WHEN CONVERT(time, date, 108) < '13:00:00' 
					THEN 'AM' 
					else 'PM' END AS 'time', Lat AS HLat, Lon AS HLon, ELE AS HEle,date AS HDate, sta_id AS HStaID, V.meASured_distance AS distance, 
					(v.nb_adult_female+v.nb_juvenile_female) AS NbFemale,
					(v.nb_adult_male + v.nb_juvenile_male) AS NbMale, (v.nb_adult_indeterminate + v.nb_juvenile_indeterminate + v.nb_indeterminate) AS NbIndet,v.Nb_Total AS NbInd, v.Taxon, 
					v.observation_time AS ObsTime, v.ID AS HPK, v.Comments, v.Behaviour, S1.original_id
				FROM VStations_ForMap AS S1 
				INNER JOIN TProtocol_Vertebrate_Group AS V 
				ON S1.sta_id = v.FK_Station
					WHERE   MonitoredSite_Category = 'SCO' and V.ID is not null and v.taxon like '%undulata') AS H
		ON (O.MonitoredSite_Name = H.MonitoredSite_Name and O.truedate = H.truedate and O.time = H.time)


 





















GO
/****** Object:  View [dbo].[VSCO_ObsPoint]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[VSCO_ObsPoint] AS
	SELECT o.fk_monitoredsite as MS_ID,O.MonitoredSite_Name AS MS_Name,o.MS_LAT, o.MS_LON, 
			o.OFA AS ObsPt_FA,o.Region, o.Place,O.OStaID AS ObsPt_StaID, 
			CAST(REPLACE(o.original_id, 'eReleve_','') AS real) AS ObsPt_Sta_eR_ID,O.true_Obs_point AS ObsPt_Name, O.ODATE AS ObsPt_Date,
			O.OLat AS ObsPt_Lat, O.OLon AS ObsPt_Lon, o.OEle AS ObsPt_Elev, O.FW, 
			CONVERT(time,o.Start_time)  AS ObsPt_Start_Time,
			CONVERT(time, o.Observation_Duration) AS ObsPt_Duration
	FROM
			(SELECT s.MonitoredSite_Name,p.lat AS MS_LAT, p.LON AS MS_LON, s.Name AS true_Obs_point,  
			FieldActivity AS OFA, date AS Odate, CONVERT(date, date) AS truedate,
			CASE WHEN CONVERT(time, date) < '13:00:00' then 'AM' else 'PM' end AS 'time', 
			s.Lat AS OLat, s.Lon AS OLon, sta_id AS OStaID,FieldWorkers AS FW ,
			Region, Place, s.ELE AS OEle, c.Start_time, c.Observation_Duration, s.original_id, s.fk_monitoredsite
			FROM VStations_ForMap s
			INNER JOIN
			VMonitoredSiteLAStPosition p
			ON s.fk_monitoredsite = p.MonitoredSiteID
			INNER JOIN
			tprotocol_sighting_conditions AS c
			ON s.sta_id = c.FK_Station
			WHERE  MonitoredSite_Category = 'sco' AND c.ID IS NOT NULL
					AND c.Observation_Incomplete = 0 ) AS O












GO
/****** Object:  View [dbo].[VSensor_GPSLoc_FromToday_45j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VSensor_GPSLoc_FromToday_45j] as

SELECT  IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType,
		 i.Sex AS Sex, i.Release_Ring_Code AS ReleaSeRing, i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, 
		il1.ID AS Sta_ID,IL1.Date AS StaDate, CONVERT(time, il1.date) AS StaHour,IL1.LAT  ,IL1.LON , il1.Precision, il1.creationDate,
	   CONVERT(VARCHAR(50),s.UnicIdentifier) AS Sensor_Station,
	   CONVERT(VARCHAR(255),RIGHT(s.Model, CHARINDEX('>', REVERSE(s.model))-1)) AS SensorModel_Station, 
	   CONVERT(VARCHAR(255), RIGHT (s.Compagny, CHARINDEX('>', REVERSE(s.compagny))-1)) as SensorCompagny_Station,
	   CONVERT(VARCHAR(50),e.UnicIdentifier) AS CurrentSensor, 
	   CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.model))-1)) AS CurrentSensorModel, 
	   CONVERT(VARCHAR(255),RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny))-1)) AS CurrentSensorCompany, 
	   CONVERT(VARCHAR(255),e.SerialNumber) AS CurrentSensorSN
      ,CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
		FROM (
			 SELECT Il.FK_Individual, il.Date, il.type_, il.LAT, il.LON, il.Precision, il.ID, il.creationDate, il.FK_Sensor
			 
			 FROM [EcoReleve_NARC].dbo.Individual_Location IL
			 WHERE  IL.Type_ in ( 'gps','GSM') and il.Date>GETDATE()-45) IL1 
					 JOIN TIndividu i 
					 ON IL1.FK_Individual =i.ID AND i.Monitoring_Status is not null AND  i.Monitoring_Status != 'Retiré'
					 JOIN [TSensor] s 
					 ON il1.FK_sensor = s.ID 
					 JOIN 
						(SELECT ie.FK_Sensor, ie.FK_Individual, ts.* 
						FROM VIndividuEquipement ie 
						INNER JOIN TSensor ts 
						ON ie.FK_Sensor = ts.ID) e
					 ON il1.FK_Individual = e.FK_Individual
					


GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_10j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[VSensor_GPSLoc_Last_10j] AS
SELECT  IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType,
		 i.Sex AS Sex, i.Release_Ring_Code AS ReleaSeRing, i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, 
		il1.ID AS Sta_ID,IL1.Date AS StaDate, CONVERT(time, il1.date) AS StaHour,IL1.LAT  ,IL1.LON , il1.Precision, il1.creationDate,
	   CONVERT(VARCHAR(50),s.UnicIdentifier) AS Sensor_Station,
	   CONVERT(VARCHAR(255),RIGHT(s.Model, CHARINDEX('>', REVERSE(s.model))-1)) AS SensorModel_Station, 
	   CONVERT(VARCHAR(255), RIGHT (s.Compagny, CHARINDEX('>', REVERSE(s.compagny))-1)) as SensorCompagny_Station,
	   CONVERT(VARCHAR(50),e.UnicIdentifier) AS CurrentSensor, 
	   CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.model))-1)) AS CurrentSensorModel, 
	   CONVERT(VARCHAR(255),RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny))-1)) AS CurrentSensorCompany, 
	   CONVERT(VARCHAR(255),e.SerialNumber) AS CurrentSensorSN
      ,CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
		FROM (
			 SELECT Il.FK_Individual, il.Date, il.type_, il.LAT, il.LON, il.Precision, il.ID, il.creationDate, il.FK_Sensor,ROW_NUMBER() OVER (PARTITION by FK_Individual,[date] order by FK_Individual,[date] DESC) Nb 
			 FROM [EcoReleve_NARC].dbo.Individual_Location IL
			 WHERE  IL.Type_ in ( 'gps','GSM') ) IL1 
					 JOIN TIndividu i 
					 ON IL1.FK_Individual =i.ID AND i.Monitoring_Status IS NOT NULL AND  i.Monitoring_Status != 'Retiré'
					 JOIN [TSensor] s 
					 ON il1.FK_sensor = s.ID 
					 JOIN 
						(SELECT ie.FK_Sensor, ie.FK_Individual, ts.* 
						FROM VIndividuEquipement ie 
						INNER JOIN TSensor ts 
						ON ie.FK_Sensor = ts.ID) e
					 ON il1.FK_Individual = e.FK_Individual
					WHERE Il1.Nb =1 
				  AND NOT EXISTS (
									SELECT * 
									FROM [EcoReleve_NARC].dbo.Individual_Location IL2 
									WHERE IL2.FK_Individual = IL1.FK_Individual AND il2.Date-10 > il1.Date
									AND IL2.Type_ in ( 'gps','GSM'))
						      
      






GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_45j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[VSensor_GPSLoc_Last_45j] AS
SELECT  IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType,
		 i.Sex AS Sex, i.Release_Ring_Code AS ReleaSeRing, i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, 
		il1.ID AS Sta_ID,IL1.Date AS StaDate, CONVERT(time, il1.date) AS StaHour,IL1.LAT  ,IL1.LON , il1.Precision, il1.creationDate,
	   CONVERT(VARCHAR(50),s.UnicIdentifier) AS Sensor_Station,
	   CONVERT(VARCHAR(255),RIGHT(s.Model, CHARINDEX('>', REVERSE(s.model))-1)) AS SensorModel_Station, 
	   CONVERT(VARCHAR(255), RIGHT (s.Compagny, CHARINDEX('>', REVERSE(s.compagny))-1)) as SensorCompagny_Station,
	   CONVERT(VARCHAR(50),e.UnicIdentifier) AS CurrentSensor, 
	   CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.model))-1)) AS CurrentSensorModel, 
	   CONVERT(VARCHAR(255),RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny))-1)) AS CurrentSensorCompany, 
	   CONVERT(VARCHAR(255),e.SerialNumber) AS CurrentSensorSN
      ,CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
		FROM (
			 SELECT Il.FK_Individual, il.Date, il.type_, il.LAT, il.LON, il.Precision, il.ID, il.creationDate, il.FK_Sensor,ROW_NUMBER() OVER (PARTITION by FK_Individual,[date] order by FK_Individual,[date] DESC) Nb 
			 FROM [EcoReleve_NARC].dbo.Individual_Location IL
			 WHERE  IL.Type_ in ( 'gps','GSM') ) IL1 
					 JOIN TIndividu i 
					 ON IL1.FK_Individual =i.ID AND i.Monitoring_Status IS NOT NULL AND  i.Monitoring_Status != 'Retiré'
					 JOIN [TSensor] s 
					 ON il1.FK_sensor = s.ID 
					 JOIN 
						(SELECT ie.FK_Sensor, ie.FK_Individual, ts.* 
						FROM VIndividuEquipement ie 
						INNER JOIN TSensor ts 
						ON ie.FK_Sensor = ts.ID) e
					 ON il1.FK_Individual = e.FK_Individual
					WHERE Il1.Nb =1 
				  AND NOT EXISTS (
									SELECT * 
									FROM [EcoReleve_NARC].dbo.Individual_Location IL2 
									WHERE IL2.FK_Individual = IL1.FK_Individual AND il2.Date-45 > il1.Date
									AND IL2.Type_ in ( 'gps','GSM'))
						      
      






GO
/****** Object:  View [dbo].[VSensor_GPSLoc_Last_5j]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[VSensor_GPSLoc_Last_5j] AS
SELECT  IL1.FK_Individual AS Ind_ID, i.Origin, i.Monitoring_Status AS CurrentMonitoringStatus, i.Survey_type AS CurrentSurveyType,
		 i.Sex AS Sex, i.Release_Ring_Code AS ReleaSeRing, i.Breeding_Ring_Code AS BreedingRing, i.Chip_Code AS ChipCode, 
		il1.ID AS Sta_ID,IL1.Date AS StaDate, CONVERT(time, il1.date) AS StaHour,IL1.LAT  ,IL1.LON , il1.Precision, il1.creationDate,
	   CONVERT(VARCHAR(50),s.UnicIdentifier) AS Sensor_Station,
	   CONVERT(VARCHAR(255),RIGHT(s.Model, CHARINDEX('>', REVERSE(s.model))-1)) AS SensorModel_Station, 
	   CONVERT(VARCHAR(255), RIGHT (s.Compagny, CHARINDEX('>', REVERSE(s.compagny))-1)) as SensorCompagny_Station,
	   CONVERT(VARCHAR(50),e.UnicIdentifier) AS CurrentSensor, 
	   CONVERT(VARCHAR(255), RIGHT(e.Model, CHARINDEX('>', REVERSE(e.model))-1)) AS CurrentSensorModel, 
	   CONVERT(VARCHAR(255),RIGHT(e.Compagny, CHARINDEX('>', REVERSE(e.Compagny))-1)) AS CurrentSensorCompany, 
	   CONVERT(VARCHAR(255),e.SerialNumber) AS CurrentSensorSN
      ,CASE WHEN s.FK_SensorType = 1 THEN 'Argos GPS' ELSE 'GSM' END AS Statype
		FROM (
			 SELECT Il.FK_Individual, il.Date, il.type_, il.LAT, il.LON, il.Precision, il.ID, il.creationDate, il.FK_Sensor,ROW_NUMBER() OVER (PARTITION by FK_Individual,[date] order by FK_Individual,[date] DESC) Nb 
			 FROM [EcoReleve_NARC].dbo.Individual_Location IL
			 WHERE  IL.Type_ in ( 'gps','GSM') ) IL1 
					 JOIN TIndividu i 
					 ON IL1.FK_Individual =i.ID AND i.Monitoring_Status IS NOT NULL AND  i.Monitoring_Status != 'Retiré'
					 JOIN [TSensor] s 
					 ON il1.FK_sensor = s.ID 
					 JOIN 
						(SELECT ie.FK_Sensor, ie.FK_Individual, ts.* 
						FROM VIndividuEquipement ie 
						INNER JOIN TSensor ts 
						ON ie.FK_Sensor = ts.ID) e
					 ON il1.FK_Individual = e.FK_Individual
					WHERE Il1.Nb =1 
				  AND NOT EXISTS (
									SELECT * 
									FROM [EcoReleve_NARC].dbo.Individual_Location IL2 
									WHERE IL2.FK_Individual = IL1.FK_Individual AND il2.Date-5 > il1.Date
									AND IL2.Type_ in ( 'gps','GSM'))
						      
      






GO
/****** Object:  View [dbo].[VTrapping_Houbara_all]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VTrapping_Houbara_all] as
SELECT DISTINCT s.MonitoredSite_Name AS MSName, s.MonitoredSite_Category,s.fk_monitoredsite AS MSID, s.Sta_ID,s.Name, s.DATE, s.FieldWorkers AS FW,
				s.NbFieldWorker AS NBFW, s.FieldActivity AS FA, s.LAT, s.LON, s.ELE AS Elevation,s.Region, s.Place, cg.ID AS CGPK, 
				cg.Name_Taxon, cg.Name_Capture_Method, cg.Nb_Individuals, cg.Nb_Operator, cg.Time_Begin, cg.Time_End,
				cg.Failure_reASon, cg.Comments CGComments, ci.ID AS CIPK, ci.FK_Individual, 
				i.SensorID AS NewSensorID,i.SensorIdentifier AS NewSensor,i.SensorFrequency AS NewSensorFrequency,i.SensorCompany AS NewSensorCompany,i.SensorModel AS NewSensorModel, 
				i2.SensorID AS CurrentSensorID,i2.SensorIdentifier AS CurrentSensor, i2.SensorFrequency AS CurrentSensorFrequency, i2.SensorCompany AS CurrentSensorCompany, 
				i2.SensorModel AS CurrentSensorModel, i.Sex, i.Origin, i.Individual_Status AS CurrentIndStatus,
				i.Monitoring_Status AS CurrentMonStatus,i.Survey_type AS CurrentSvType,
				i.Breeding_Ring_Code , i.ReleASe_Ring_Code , i.Chip_Code ,
				i.Mark_code_1, i.Mark_Color_1, i.Mark_Position_1,
				ci.Time_Capture, ci.Time_ReleASe,co.Observer AS CIObs, ca.Observer AS CIASsis,ci.Comments AS CIComments,b.Age AS AgeAtTrapping, b.Sex AS SexAtTrapping,
				b.Weight, b.Tarso_Metatarsus, b.Skull, b.Wings AS Wing, bo.Observer AS BioObs, ba.Observer AS BioASsis,b.Comments AS BioComment,
				i.Birth_date AS TrueBirthDate
FROM 
	VStations_ForMap s
INNER JOIN
	(SELECT ID, FK_Station, Name_Capture_Method, Name_Taxon, nb_individuals, Nb_Operator, g.Failure_reason, g.Time_Begin, g.Time_End, g.Comments
		FROM TProtocol_Capture_Group g WHERE Name_Taxon like '%undulata') cg
ON s.Sta_ID = cg.FK_Station
LEFT OUTER JOIN
	TProtocol_Capture_Individual ci
ON cg.ID = ci.Parent_Observation
LEFT OUTER JOIN
	TProtocol_Bird_Biometry b
ON s.Sta_ID = b.FK_Station and ci.FK_Individual = b.FK_Individual
LEFT OUTER JOIN
	VIndiv_Historical_Sensor_Info i
ON ci.FK_Individual = i.Ind_ID and CONVERT(date,s.Date) = CONVERT(date,i.StartDate)
LEFT OUTER JOIN
	VIndiv_Current_Sensor_Info i2
ON ci.FK_Individual = i2.Ind_ID
LEFT OUTER JOIN
	EcoReleve_NARC.dbo.[User] CO
ON ci.Id_Observer=co.ID
LEFT OUTER JOIN
	EcoReleve_NARC.dbo.[User] CA
ON ci.Id_ASsistant = ca.Id
LEFT OUTER JOIN
	EcoReleve_NARC.dbo.[User] BO
ON b.observer = bo.Id
LEFT OUTER JOIN	
	EcoReleve_NARC.dbo.[User] BA
ON b.ASsistant = BA.Id
WHERE cg.Name_Taxon like '%undulata'











GO
/****** Object:  View [dbo].[VWildlife_EnjilDam]    Script Date: 22/03/2016 13:57:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VWildlife_EnjilDam] as
SELECT     stMap.MonitoredSite_Name, stMap.Name AS Station_Name, stMap.DATE, Right(prg.taxon, charindex('>',reverse(prg.taxon)) -1 ) AS Scientific_name, T.TTop_DefinitionEn AS English_name, 
            prg.Nb_Total AS Number_of_individuals,  stMap.FieldWorkers, 
            stMap.FieldActivity, stMap.Region, stMap.Place, stMap.LAT, stMap.LON, stMap.Precision, stMap.ELE, stMap.Creator, stMap.Creationdate, 
            stMap.MonitoredSite_Category
FROM         VStations_ForMap AS stMap 
			INNER JOIN
            TProtocol_Vertebrate_Group AS prg 
            ON stMap.sta_id = prg.FK_Station 
            INNER JOIN
            THESAURUS.dbo.TTopic AS T ON prg.Taxon = t.TTop_FullPath
			WHERE     (stMap.MonitoredSite_Name = 'Barrage Enjil') AND (stMap.MonitoredSite_Category = 'dam')



GO