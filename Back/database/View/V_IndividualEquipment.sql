CREATE VIEW IndividualEquipment as 

SELECT e.FK_Sensor,e.FK_Individual,e.StartDate as StartDate,e1.StartDate as EndDate
  FROM [EcoReleve_ECWP].[dbo].[Equipment] e 
 LEFT JOIN Equipment e1 
	ON e.FK_Individual = e1.FK_Individual 
	and e.FK_Sensor = e1.FK_Sensor 
	and e.ID!=e1.ID 
	and e.StartDate < e1.StartDate 
	and e1.Deploy = 0
	AND NOT exists (
			SELECT * 
			FROM Equipment ee
			WHERE ee.FK_Sensor = e1.FK_Sensor and ee.FK_Individual = e1.FK_Individual and ee.StartDate<e1.StartDate and e.StartDate<ee.StartDate
	)
WHERE e.Deploy = 1 AND e.FK_Individual is not null