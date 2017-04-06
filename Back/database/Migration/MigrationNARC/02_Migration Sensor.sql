
SET IDENTITY_INSERT  Sensor ON

-------------- INSERT  sensor Argos and GSM -------------------------------------------------------------------
INSERT INTO Sensor(
	ID
	,UnicIdentifier
      ,[Model]
      ,[Compagny]
      ,[SerialNumber]
      ,[creationDate]
      ,[FK_SensorType]
      ,Original_ID
)
SELECT  
Trx_Sat_Obj_PK,
[id19@TCarac_PTT],
[id41@TCaracThes_Model_Precision],
[id42@TCaracThes_Company_Precision],
[id6@TCarac_Transmitter_Serial_Number],
GETDATE(),
CASE WHEN [id41@TCaracThes_Model_Precision] like '%solar%' THEN  1 
	else 
		2
	END,
[Trx_Sat_Obj_PK]  
FROM [NARC_eReleveData].[dbo].[TViewTrx_Sat]
where [id41@TCaracThes_Model_Precision] not like '%RI%'

-------------- INSERT  RFID -------------------------------------------------------------------

INSERT INTO Sensor(
	ID
	,UnicIdentifier
      ,[Model]
      ,[Compagny]
      ,[SerialNumber]
      ,[creationDate]
      ,[FK_SensorType]
      ,Original_ID
)
SELECT 
	PK_id
      ,[identifier]
	  ,model
      ,[manufacturer]
      ,[serial_number]
	  ,[creation_date]
	  , 3
	, PK_id
  FROM [NARC_eReleveData].[dbo].[T_Object]

   SET IDENTITY_INSERT  Sensor OFF

-------------- INSERT  VHF not finished  -------------------------------------------------------------------
INSERT INTO Sensor(
	
	UnicIdentifier
      ,[Model]
      ,[Compagny]
      ,[SerialNumber]
      ,[creationDate]
      ,[FK_SensorType]
      ,Original_ID
)

SELECT DISTINCT 
 CASE 
		WHEN v4.value IS NOT NULL 
		THEN v1.value+'_'+v4.value 
		ELSE v1.value+'_NULL' 
		END as UnicIdentifier,
		NULL,
		NULL,
		v4.value,
		GETDATE(),
		4,
		'VHF_'+CONVERT(VARCHAR,r.Trx_Radio_Obj_PK)

  FROM [NARC_eReleveData].[dbo].[TObj_Carac_value] v1 
  LEFT JOIN [NARC_eReleveData].[dbo].[TObj_Carac_value] v2 on v1.fk_object = v2.fk_object
		 and v2.Fk_carac = 3 and CONVERT(DATE,v1.begin_date) = CONVERT(DATE,v2.begin_date)
  
  LEFT JOIN [NARC_eReleveData].[dbo].[TObj_Carac_value] v3 on v1.fk_object = v3.fk_object 
		and v3.Fk_carac = 4 and CONVERT(DATE,v1.begin_date) = CONVERT(DATE,v3.begin_date)
  
  LEFT JOIN [NARC_eReleveData].[dbo].[TObj_Carac_value] v4 on v1.fk_object = v4.fk_object 
		and v4.Fk_carac = 6 and CONVERT(DATE,v1.begin_date) = CONVERT(DATE,v4.begin_date)
	
  LEFT JOIN [NARC_eReleveData].[dbo].TViewTrx_Radio r on v4.value = r.id6@TCarac_Transmitter_Serial_Number
  where v1.Fk_carac = 5 
  --order by v4.value
 GO

 
WITH toto as (
SELECT 
	cv.begin_date as StartDate,
	dp.TypeProp,
	s.ID as SensorID,
	dp.Name as dynPropName,
	dp.ID as dynPopID,
	typ.name, 
	CASE 
		WHEN cv.value_precision is not null then  cv.value_precision 
		ELSe cv.value
		END as Value,
	s.Original_ID 
  FROM [NARC_eReleveData].[dbo].[TObj_Carac_value] cv
  JOIN [NARC_eReleveData].[dbo].[TObj_Carac_type] typ 
		ON cv.Fk_carac = typ.Carac_type_Pk 
  JOIN dbo.SensorDynProp dp 
		ON 'TCaracThes_'+dp.Name = typ.name 
		or 'TCarac_'+dp.Name = typ.name 
		or dp.Name = typ.name 
		or 'Thes_'+dp.Name = typ.name 
		or 'Thes_txt_'+dp.Name = typ.name
		or 'TCaracThes_txt_'+dp.Name = typ.name
  JOIN dbo.Sensor s on cv.fk_object = s.ID
  where [object_type] in ('Trx_Radio','Trx_Sat' ) )
  
  


INSERT INTO [dbo].[SensorDynPropValue]
	([StartDate]
      ,[ValueInt]
      ,[ValueString]
      ,[ValueDate]
      ,[ValueFloat]
      ,[FK_SensorDynProp]
      ,[FK_Sensor]
)
SELECT 
	toto.StartDate,
	CASE WHEN toto.TypeProp = 'Integer' THEN toto.value else NULL end as ValueInt,
	CASE WHEN toto.TypeProp = 'String' THEN toto.value else NULL end as ValueString,
	CASE WHEN toto.TypeProp = 'Date' THEN toto.value else NULL end as ValueDate,
	CASE WHEN toto.TypeProp = 'Float' THEN toto.value else NULL end as ValueFloat,
	toto.dynPopID,
	toto.SensorID
FROM toto
