IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_MessageExportProtoEntomo]') AND type in (N'P', N'PC'))
DROP PROCEDURE pr_MessageExportProtoEntomo
GO


CREATE PROCEDURE pr_MessageExportProtoEntomo
(
@ProtocoleID INT  = NULL
)
AS
BEGIN

	BEGIN TRY
	BEGIN TRAN
	
	
		IF OBJECT_ID('tempdb..#ProtocoleID') IS NOT NULL
		DROP TABLE #ProtocoleID

		CREATE TABLE #ProtocoleID
		(ID INT NOT NULL)

		IF @ProtocoleID IS NULL 
		BEGIN 

			IF OBJECT_ID('tempdb..#ExistsingID') IS NOT NULL
			DROP TABLE #ExistsingID

			SELECT ID into #ExistsingID
			FROM ExistingSampleEntomoECol

			CREATE CLUSTERED INDEX PK_TmpExistsingID on #ExistsingID(ID)


			INSERT INTO #ProtocoleID
			SELECT O.ID
			FROM Observation  O JOIN ProtocoleType PT ON o.FK_ProtocoleType = PT.ID AND PT.Name ='Entomo_Pop_Census'
			WHERE NOT EXISTS (select * FROM #ExistsingID E where e.ID = o.ID)
		END
		ELSE
		BEGIN
			INSERT INTO #ProtocoleID VALUES (@ProtocoleID)
		END

		IF OBJECT_ID('tempdb..#StationID') IS NOT NULL
		DROP TABLE #StationID

		CREATE TABLE #StationID
		(ID INT NOT NULL)

		INSERT INTO #StationID
		SELECT DISTINCT S.ID FROM Station  S JOIN Observation O on o.FK_Station = s.ID JOIN ProtocoleType PT ON o.FK_ProtocoleType = PT.ID AND PT.Name ='Entomo_Pop_Census'
		


		IF OBJECT_ID('tempdb..#MessageIDs') IS NOT NULL
		DROP TABLE #MessageIDs


		CREATE TABLE #MessageIDs(
			ID INT
		)

	

		/*********************************** Exporting Stations  */

		
		INSERT INTO [dbo].[TMessageSend]
			   ([ObjectType]
			   ,[ObjectId]
			   ,[ObjectOriginalID]
			   ,[Operation]
			   ,[CreationDate]
			   ,[SendDate]
			   ,[Comment]
			   )
		OUTPUT INSERTED.pk_MessageSend INTO #MessageIDs	
		SELECT DISTINCT 'Station',S.id,dbo.GetProvenance() + '_' + convert(varchar,S.id),'Create',getdate(),NULL,NULL
		FROM Station  S 
		WHERE s.id  IN (select ID FROM #StationID)
		


		INSERT INTO [dbo].[TMessageSendDetail]
				   ([fk_MessageSend]
				   ,[PropName]
				   ,[PropValue]
				   ,[Parametre])
		select m.pk_MessageSend,C.PropName,PropValue,NULL
		from Station S JOIN [TMessageSend]  M on m.[ObjectId] = S.ID LEFT JOIN fieldActivity F ON S.fieldActivityId = F.ID LEFT JOIN Region R ON S.FK_Region = R.ID
		CROSS APPLY
		(
			values	
			('StationDate',convert(varchar,S.StationDate,120))
			,('StationName',convert(varchar,S.Name))
			,('LAT',convert(varchar,S.LAT))
			,('LON',convert(varchar,S.LON))
			,('ELE',convert(varchar,S.ELE))
			,('precision',convert(varchar,S.precision))
			,('fieldActivity',F.Name)
			,('Place',S.place)
			,('Region',R.Region)
		) C (PropName,PropValue)
		WHERE M.pk_MessageSend IN (SELECT ID FROM #MessageIDs)

		TRUNCATE TABLE #MessageIDs

		/**************** Exporting Protocole  ********************/

		INSERT INTO [dbo].[TMessageSend]
			   ([ObjectType]
			   ,[ObjectId]
			   ,[ObjectOriginalID]
			   ,[Operation]
			   ,[CreationDate]
			   ,[SendDate]
			   ,[Comment]
			   )
		OUTPUT INSERTED.pk_MessageSend INTO #MessageIDs	
		SELECT Pt.Name,o.id,dbo.GetProvenance() + '_' + convert(varchar,o.Parent_Observation),'Create',getdate(),NULL,NULL
		FROM Observation  O JOIN ProtocoleType PT ON o.FK_ProtocoleType = PT.ID AND PT.Name ='Entomo_Pop_Census'
			WHERE o.ID  IN (select ID FROM #ProtocoleID)
		
		

		INSERT INTO [dbo].[TMessageSendDetail]
				   ([fk_MessageSend]
				   ,[PropName]
				   ,[PropValue]
				   ,[Parametre])
		select m.pk_MessageSend,C.PropName,PropValue,NULL
		from Observation O JOIN [TMessageSend]  M on m.[ObjectId] = O.ID 
		CROSS APPLY
		(
			values	
			('ECol_id',replace(convert(varchar,O.original_id),'Fichier_Alex_ss_Prot_',''))
			,('Comments',O.Comments)
			,('FK_Station',convert(varchar,O.FK_Station))
			
		) C (PropName,PropValue)
		WHERE M.pk_MessageSend IN (SELECT ID FROM #MessageIDs)



		INSERT INTO [dbo].[TMessageSendDetail]
           ([fk_MessageSend]
           ,[PropName]
           ,[PropValue]
           ,[Parametre])
		SELECT m.pk_MessageSend,v.Name,CASE WHEN TYPEPROP ='STring' THEN ValueString WHEN Typeprop ='Integer' THEN convert(varchar,valueint) ELSE ValueString END,NULL
		FROM ObservationDynPropValuesNow V JOIN [TMessageSend]  M on convert(int,m.[ObjectId]) = V.FK_Observation
		WHERE M.pk_MessageSend in (SELECT ID FROM #MessageIDs)

		print 'COMMIT TRAN'
		IF @@TRANCOUNT > 0 COMMIT TRAN

	END TRY
		BEGIN CATCH
			print 'CATCH'
			print @@TRANCOUNT
			IF @@TRANCOUNT >0  ROLLBACK TRAN;
			print @@TRANCOUNT
			
			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;
			
			SELECT 
				@ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();
			
			RAISERROR (@ErrorMessage, -- Message text.
					   @ErrorSeverity, -- Severity.
					   @ErrorState -- State.
					   );
		END CATCH	

END