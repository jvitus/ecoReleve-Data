from array import array

from pyramid.view import view_config
from pyramid.response import Response
from sqlalchemy import func, desc, select, union, union_all, and_, bindparam, update, or_, literal_column, join, text, update, Table,distinct
import json
from pyramid.httpexceptions import HTTPBadRequest
from ..utils.data_toXML import data_to_XML
import pandas as pd
import numpy as np
import transaction, time, signal

from ..utils.distance import haversine
import win32con, win32gui, win32ui, win32service, os, time, re
from win32 import win32api
import shutil
from time import sleep
import subprocess , psutil
from pyramid.security import NO_PERMISSION_REQUIRED
from datetime import datetime
from ..Models import Base, dbConfig, DBSession,ArgosGps,graphDataDate,CamTrap
from traceback import print_exc
from pyramid import threadlocal
from xml.etree.ElementTree import XMLParser

from ..controllers.security import routes_permission



route_prefix = 'sensors/'
def asInt(s):
    try:
        return int(s)
    except:
        return None

def error_response (err) :
    if err !=None :
        msg = err.args[0] if err.args else ""
        response=Response('Problem occurs : '+str(type(err))+' = '+msg)
    else :
        response=Response('No induvidual equiped')
    response.status_int = 500
    return response

ArgosDatasWithIndiv = Table('VArgosData_With_EquipIndiv', Base.metadata, autoload=True)
GsmDatasWithIndiv = Table('VGSMData_With_EquipIndiv', Base.metadata, autoload=True)
DataRfidWithSite = Table('VRfidData_With_equipSite', Base.metadata, autoload=True)
DataRfidasFile = Table('V_dataRFID_as_file', Base.metadata, autoload=True)
DataCamTrapFile = Table('V_dataCamTrap_With_equipSite', Base.metadata, autoload=True)


# ------------------------------------------------------------------------------------------------------------------------- #
# List all PTTs having unchecked locations, with individual id and number of locations.
@view_config(route_name=route_prefix+'uncheckedDatas',renderer='json',match_param='type=rfid',permission = routes_permission['rfid']['GET'])
@view_config(route_name=route_prefix+'uncheckedDatas',renderer='json',match_param='type=gsm',permission = routes_permission['gsm']['GET'])
@view_config(route_name=route_prefix+'uncheckedDatas',renderer='json',match_param='type=argos',permission = routes_permission['argos']['GET'])
@view_config(route_name=route_prefix+'uncheckedDatas',renderer='json',match_param='type=camtrap',permission = routes_permission['rfid']['GET'])
def type_unchecked_list(request):
    session = request.dbsession

    type_= request.matchdict['type']
    if type_ == 'argos' :
        unchecked = ArgosDatasWithIndiv
    elif type_ == 'gsm' :
        unchecked = GsmDatasWithIndiv
    elif type_ == 'rfid':
        return unchecked_rfid(request)
    elif type_ == 'camtrap':
        return unchecked_camtrap(request)

    selectStmt = select([unchecked.c['FK_Individual'],unchecked.c['Survey_type'],unchecked.c['FK_ptt'], unchecked.c['FK_Sensor'], unchecked.c['StartDate'], unchecked.c['EndDate'],

            func.count().label('nb'), func.max(unchecked.c['date']).label('max_date'),
            func.min(unchecked.c['date']).label('min_date')])

    queryStmt = selectStmt.where(unchecked.c['checked'] == 0
            ).group_by(unchecked.c['FK_Individual'],unchecked.c['Survey_type'],unchecked.c['FK_ptt'], unchecked.c['StartDate'], unchecked.c['EndDate'], unchecked.c['FK_Sensor'],
            ).order_by(unchecked.c['FK_ptt'].asc())
    data = session.execute(queryStmt).fetchall()
    dataResult = [dict(row) for row in data]
    result = [{'total_entries':len(dataResult)}]
    result.append(dataResult)
    return result

def unchecked_rfid(request):
    session = request.dbsession

    unchecked = DataRfidasFile
    queryStmt = select(unchecked.c)
    data = session.execute(queryStmt).fetchall()
    dataResult = [dict(row) for row in data]
    result = [{'total_entries':len(dataResult)}]
    result.append(dataResult)
    return result

def unchecked_camtrap(request):
    session = request.dbsession

    unchecked = DataCamTrapFile
    queryMoche = "SELECT equipID,UnicIdentifier,fk_sensor,site_name,FK_MonitoredSite,site_type,StartDate,EndDate,COUNT(DISTINCT pk_id) AS nb_photo FROM [dbo].V_dataCamTrap_With_equipSite WHERE checked IS NULL AND equipID IS NOT NULL GROUP BY UnicIdentifier, site_name, site_type, StartDate, EndDate, equipID, fk_sensor, FK_MonitoredSite;"
    #queryStmt = select(unchecked.c)
    #data = session.execute(queryStmt).fetchall()
    data2 = session.execute(queryMoche).fetchall()
    dataResult = [dict(row) for row in data2]
    result = [{'total_entries':len(dataResult)}]
    result.append(dataResult)
    return result

# ------------------------------------------------------------------------------------------------------------------------- #
@view_config(route_name=route_prefix+'uncheckedDatas/id_indiv/ptt',renderer='json',request_method = 'GET' )
def details_unchecked_indiv(request):
    session = request.dbsession

    type_= request.matchdict['type']
    id_indiv = request.matchdict['id_indiv']

    if(id_indiv == 'none'):
        id_indiv = None
    ptt = request.matchdict['id_ptt']

    if type_ == 'argos' :
        unchecked = ArgosDatasWithIndiv
    elif type_ == 'gsm' :
        unchecked = GsmDatasWithIndiv
    elif type_ == 'camtrap':
        return details_unchecked_camtrap(request)


    if 'geo' in request.params :
        queryGeo = select([unchecked.c['PK_id'],unchecked.c['type'],unchecked.c['lat'],unchecked.c['lon'],unchecked.c['date']]
            ).where(and_(unchecked.c['FK_ptt']== ptt
                ,and_(unchecked.c['checked'] == 0,unchecked.c['FK_Individual'] == id_indiv)))

        dataGeo = session.execute(queryGeo).fetchall()
        geoJson = []
        for row in dataGeo:
            geoJson.append({'type':'Feature', 'id': row['PK_id'], 'properties':{'type':row['type'], 'date':row['date']}
                , 'geometry':{'type':'Point', 'coordinates':[row['lat'],row['lon']]}})
        result = {'type':'FeatureCollection', 'features':geoJson}
    else :
        query = select([unchecked]
            ).where(and_(unchecked.c['FK_ptt']== ptt
                ,and_(unchecked.c['checked'] == 0,unchecked.c['FK_Individual'] == id_indiv))).order_by(desc(unchecked.c['date']))
        data = session.execute(query).fetchall()

        df = pd.DataFrame.from_records(data, columns=data[0].keys(), coerce_float=True)
        X1 = df.iloc[:-1][['lat', 'lon']].values
        X2 = df.iloc[1:][['lat', 'lon']].values
        df['dist'] = np.append(haversine(X1, X2), 0).round(3)
        # Compute the speed
        df['speed'] = (df['dist'] / ((df['date'] - df['date'].shift(-1)).fillna(1) / np.timedelta64(1, 'h'))).round(3)
        df['date'] = df['date'].apply(lambda row: np.datetime64(row).astype(datetime))
        # Fill NaN
        df.fillna(value={'ele':-999}, inplace=True)
        df.fillna(value={'speed':0}, inplace=True)
        df.replace(to_replace = {'speed': np.inf}, value = {'speed':9999}, inplace = True)
        df.fillna(value=0,inplace=True)
        # dataResult = [dict(row) for row in data]
        dataResult = df.to_dict('records')
        result = [{'total_entries':len(dataResult)}]
        result.append(dataResult)

    return result

@view_config(route_name=route_prefix+'uncheckedDatas/id_indiv/ptt/id_equip/pk_id',renderer='json',request_method = 'PATCH' )
def patchCamTrap(request):
    print(" Je vais traiter la requete")
    print(" type : "+str(request.method) )
    pk_id_patched = request.matchdict['pk_id']
    print(" on modifie la ressource : " + str(pk_id_patched) )
    print(" avec les valeurs : ")
    data = request.params.mixed()
    print(request.params)
    print(data)
    print(request.json_body['PK_id'])
    print(request.json_body['path'])
    print(request.json_body['name'])
    print(request.json_body['checked'])
    print(request.json_body['validated'])
    print(request.json_body['tags'])
    print(request.json_body['note'])

    session = request.dbsession


    curCameraTrap = session.query(CamTrap).get(pk_id_patched)
    curCameraTrap.validated = request.json_body['validated']
    if (str(request.json_body['tags']) not in   ['None', ''] ):
        listTags = str(request.json_body['tags']).split(",")
        XMLTags = "<TAGS>"
        for tag in listTags:
            XMLTags+= "<TAG>"+str(tag)+"</TAG>"
        XMLTags+= "</TAGS>"
        print(XMLTags)
    else:
        XMLTags = None
    curCameraTrap.tags = XMLTags
    curCameraTrap.note = request.json_body['note']
    print (curCameraTrap)
    # session.commit()
    return

# ------------------------------------------------------------------------------------------------------------------------- #

@view_config(route_name=route_prefix+'uncheckedDatas/id_indiv/ptt/id_equip',renderer='json',request_method = ('GET','PATCH') )
@view_config(route_name=route_prefix+'uncheckedDatas/id_indiv/ptt',renderer='json',request_method = 'GET',match_param='type=argos',permission = routes_permission['argos']['GET'])
@view_config(route_name=route_prefix+'uncheckedDatas/id_indiv/ptt',renderer='json',request_method = 'GET',match_param='type=gsm',permission = routes_permission['gsm']['GET'])
def details_unchecked_indiv(request):
    session = request.dbsession

    type_= request.matchdict['type']
    id_indiv = request.matchdict['id_indiv']
    id_equip = request.matchdict['id_equip']

    if(id_indiv == 'none'):
        id_indiv = None
    ptt = request.matchdict['id_ptt']


    if type_ == 'argos' :
        unchecked = ArgosDatasWithIndiv
    elif type_ == 'gsm' :
        unchecked = GsmDatasWithIndiv
    elif type_ == 'camtrap':
        return details_unchecked_camtrap(request)


    if 'geo' in request.params :
        queryGeo = select([unchecked.c['PK_id'],unchecked.c['type'],unchecked.c['lat'],unchecked.c['lon'],unchecked.c['date']]
            ).where(and_(unchecked.c['FK_ptt']== ptt
                ,and_(unchecked.c['checked'] == 0,unchecked.c['FK_Individual'] == id_indiv)))

        dataGeo = session.execute(queryGeo).fetchall()
        geoJson = []
        for row in dataGeo:
            geoJson.append({'type':'Feature', 'id': row['PK_id'], 'properties':{'type':row['type'], 'date':row['date']}
                , 'geometry':{'type':'Point', 'coordinates':[row['lat'],row['lon']]}})
        result = {'type':'FeatureCollection', 'features':geoJson}
    else :
        query = select([unchecked]
            ).where(and_(unchecked.c['FK_ptt']== ptt
                ,and_(unchecked.c['checked'] == 0,unchecked.c['FK_Individual'] == id_indiv))).order_by(desc(unchecked.c['date']))
        data = session.execute(query).fetchall()

        df = pd.DataFrame.from_records(data, columns=data[0].keys(), coerce_float=True)
        X1 = df.iloc[:-1][['lat', 'lon']].values
        X2 = df.iloc[1:][['lat', 'lon']].values
        df['dist'] = np.append(haversine(X1, X2), 0).round(3)
        # Compute the speed
        df['speed'] = (df['dist'] / ((df['date'] - df['date'].shift(-1)).fillna(1) / np.timedelta64(1, 'h'))).round(3)
        df['date'] = df['date'].apply(lambda row: np.datetime64(row).astype(datetime))
        # Fill NaN
        df.fillna(value={'ele':-999}, inplace=True)
        df.fillna(value={'speed':0}, inplace=True)
        df.replace(to_replace = {'speed': np.inf}, value = {'speed':9999}, inplace = True)
        df.fillna(value=0,inplace=True)
        # dataResult = [dict(row) for row in data]
        dataResult = df.to_dict('records')
        result = [{'total_entries':len(dataResult)}]
        result.append(dataResult)

    return result

def details_unchecked_camtrap(request):
    if( request.method == 'PATCH'):
        print(" on recoit une requete de validation")
        print(" type : " + str(request.method) + " authorized" )
    else:
        session = threadlocal.get_current_request().dbsession
        result = []
        id_indiv = request.matchdict['id_indiv']
        if(id_indiv == 'none'):
            id_indiv = None
        ptt = request.matchdict['id_ptt']
        id_equip = request.matchdict['id_equip']

        unchecked = DataCamTrapFile
        """query = select([unchecked]
            ).where(and_(unchecked.c['FK_sensor']== ptt
                ,and_(unchecked.c['checked'] == 0,unchecked.c['FK_MonitoredSite'] == id_indiv))).order_by(desc(unchecked.c['date']))"""

        query = 'select PK_id,path,name,checked,validated,tags,note,date_creation from ecoReleve_Sensor.dbo.TcameraTrap where pk_id in (select pk_id from [dbo].V_dataCamTrap_With_equipSite where fk_sensor = '+str(id_indiv)+' AND FK_MonitoredSite = '+str(ptt)+' AND equipID ='+str(id_equip)+' ) ORDER BY date_creation ASC;'
        data = session.execute(query).fetchall()
        dataResults = [dict(row) for row in data]
        for tmp in dataResults:
            varchartmp = tmp['path'].split('\\')
            tmp['path']="imgcamtrap/"+str(varchartmp[len(varchartmp)-2])+"/"
            tmp['name'] = tmp['name'].replace(" ","%20")
            tmp['id'] = tmp['PK_id']
            tmp['date_creation'] = str(tmp['date_creation'])
            tmp['date_creation'] = tmp['date_creation'][:len(tmp['date_creation'])-3]
            if( str(tmp['tags']) != 'None'):
                strTags = tmp['tags'].replace("<TAGS>","")
                strTags = strTags.replace("<TAG>","")
                strTags = strTags.replace("</TAGS>","")
                strTags = strTags.replace("</TAG>",",")
                strTags = strTags[:len(strTags)-1] #del the last ","
                if( strTags != 'None' ):
                    tmp['tags'] = strTags
                else:
                    tmp['tags'] = "";


        result = [{'total_entries':len(dataResults)}]
        result.append(dataResults)
        ''' todo '''
        return dataResults
# ------------------------------------------------------------------------------------------------------------------------- #

@view_config(route_name = route_prefix+'uncheckedDatas/id_indiv/ptt', renderer = 'json' , request_method = 'POST',permission = routes_permission['gsm']['POST'] )
def manual_validate(request) :
    global graphDataDate
    session = request.dbsession

    ptt = asInt(request.matchdict['id_ptt'])
    ind_id = asInt(request.matchdict['id_indiv'])
    type_ = request.matchdict['type']
    user = request.authenticated_userid['iss']

    data = json.loads(request.params['data'])

    procStockDict = {
    'argos': '[sp_validate_Argos_GPS]',
    'gsm': '[sp_validate_GSM]'
    }

    try :
        if isinstance( ind_id, int ):
            xml_to_insert = data_to_XML(data)
            # validate unchecked ARGOS_ARGOS or ARGOS_GPS data from xml data PK_id.
            start = time.time()
            # push xml data to insert into stored procedure in order ==> create stations and protocols if not exist
            stmt = text(""" DECLARE @nb_insert int , @exist int, @error int;
                exec """+ dbConfig['data_schema'] + """."""+procStockDict[type_]+""" :id_list, :ind_id , :user , :ptt, @nb_insert OUTPUT, @exist OUTPUT , @error OUTPUT;
                    SELECT @nb_insert, @exist, @error; """
                ).bindparams(bindparam('id_list', xml_to_insert),bindparam('ind_id', ind_id),bindparam('ptt', ptt)
                ,bindparam('user', user))
            nb_insert, exist , error = session.execute(stmt).fetchone()
            transaction.commit()

            stop = time.time()
            graphDataDate['pendingSensorData'] = None
            graphDataDate['indivLocationData'] = None
            return { 'inserted' : nb_insert, 'existing' : exist, 'errors' : error}
        else :
            return error_response(None)
    except  Exception as err :
        print_exc()
        return error_response(err)

@view_config(route_name = route_prefix+'uncheckedDatas', renderer = 'json' , request_method = 'POST',match_param='type=rfid',permission = routes_permission['rfid']['POST'] )
@view_config(route_name = route_prefix+'uncheckedDatas', renderer = 'json' , request_method = 'POST',match_param='type=gsm',permission = routes_permission['gsm']['POST'] )
@view_config(route_name = route_prefix+'uncheckedDatas', renderer = 'json' , request_method = 'POST' ,match_param='type=argos',permission = routes_permission['argos']['POST'])
@view_config(route_name = route_prefix+'uncheckedDatas', renderer = 'json' , request_method = 'POST',match_param='type=camtrap',permission = routes_permission['rfid']['POST'] )
def auto_validation(request):
    session = request.dbsession
    global graphDataDate
    #lancer procedure stocke
    type_ = request.matchdict['type']

    if type_ == 'camtrap':
        return validateCamTrap(request)
    # print ('\n*************** AUTO VALIDATE *************** \n')

    param = request.params.mixed()
    freq = param['frequency']
    listToValidate = json.loads(param['toValidate'])
    user = request.authenticated_userid['iss']

    if freq == 'all' :
        freq = 1

    Total_nb_insert = 0
    Total_exist = 0
    Total_error = 0

    if listToValidate == 'all':
        Total_nb_insert,Total_exist,Total_error = auto_validate_ALL_stored_procGSM_Argos(user,type_,freq,session)
    else :
        if type_ == 'rfid':
            for row in listToValidate :
                equipID = row['equipID']
                sensor = row['FK_Sensor']
                if equipID == 'null' or equipID is None:
                    equipID = None
                else :
                    equipID = int(equipID)
                nb_insert, exist, error = auto_validate_proc_stocRfid(equipID,sensor,freq,user,session)
                session.commit()
                Total_exist += exist
                Total_nb_insert += nb_insert
                Total_error += error
        else:
            for row in listToValidate :
                ind_id = row['FK_Individual']
                ptt = row['FK_ptt']

                try :
                    ind_id = int(ind_id)
                except TypeError:
                    ind_id = None

                nb_insert, exist, error = auto_validate_stored_procGSM_Argos(ptt,ind_id,user, type_,freq,session)
                session.commit()

                Total_exist += exist
                Total_nb_insert += nb_insert
                Total_error += error

    graphDataDate['pendingSensorData'] = None
    graphDataDate['indivLocationData'] = None
    return { 'inserted' : Total_nb_insert, 'existing' : Total_exist, 'errors' : Total_error}

def auto_validate_stored_procGSM_Argos(ptt, ind_id,user,type_,freq,session):
    procStockDict = {
    'argos': '[sp_auto_validate_Argos_GPS]',
    'gsm': '[sp_auto_validate_GSM]'
    }

    if type_ == 'argos' :
        table = ArgosDatasWithIndiv
    elif type_ == 'gsm' :
        table = GsmDatasWithIndiv

    if ind_id is None:
        stmt = update(table).where(and_(table.c['FK_Individual'] == None, table.c['FK_ptt'] == ptt)
            ).where(table.c['checked'] == 0).values(checked =1)

        session.execute(stmt)
        nb_insert = exist = error = 0
    else:
        stmt = text(""" DECLARE @nb_insert int , @exist int , @error int;
        exec """+ dbConfig['data_schema'] + """."""+procStockDict[type_]+""" :ptt , :ind_id , :user ,:freq , @nb_insert OUTPUT, @exist OUTPUT, @error OUTPUT;
        SELECT @nb_insert, @exist, @error; """
        ).bindparams(bindparam('ind_id', ind_id),bindparam('user', user),bindparam('freq', freq),bindparam('ptt', ptt))
        nb_insert, exist , error= session.execute(stmt).fetchone()

    return nb_insert, exist , error

def auto_validate_proc_stocRfid(equipID,sensor,freq,user,session):
    if equipID is None :
        stmt = update(DataRfidWithSite).where(and_(DataRfidWithSite.c['FK_Sensor'] == sensor, DataRfidWithSite.c['equipID'] == equipID)).values(checked =1)
        session.execute(stmt)
        nb_insert = exist = error = 0
    else :
        stmt = text(""" DECLARE @nb_insert int , @exist int , @error int;
            exec """+ dbConfig['data_schema'] + """.[sp_validate_rfid]  :equipID,:freq, :user , @nb_insert OUTPUT, @exist OUTPUT, @error OUTPUT;
            SELECT @nb_insert, @exist, @error; """
            ).bindparams(bindparam('equipID', equipID),bindparam('user', user),bindparam('freq', freq))
        nb_insert, exist , error= session.execute(stmt).fetchone()

    return nb_insert, exist , error

def auto_validate_ALL_stored_procGSM_Argos(user,type_,freq,session):
    procStockDict = {
    'argos': '[sp_auto_validate_ALL_Argos_GPS]',
    'gsm': '[sp_auto_validate_ALL_GSM]',
    'rfid' : '[sp_validate_ALL_rfid]'
    }

    stmt = text(""" DECLARE @nb_insert int , @exist int , @error int;
    exec """+ dbConfig['data_schema'] + """."""+procStockDict[type_]+""" :user ,:freq , @nb_insert OUTPUT, @exist OUTPUT, @error OUTPUT;
    SELECT @nb_insert, @exist, @error; """
    ).bindparams(bindparam('user', user),bindparam('freq', freq))
    nb_insert, exist , error= session.execute(stmt).fetchone()

    return nb_insert, exist , error

def deletePhotoOnSQL(request ,fk_sensor):
    session = request.dbsession
    #currentPhoto = CamTrap(fk_sensor = fk_sensor)
    currentPhoto = session.query(CamTrap).get(fk_sensor)
    session.delete(currentPhoto)
    return True

def validateCamTrap(request):
    session = request.dbsession
    #appel de la procedure stocké

    # supression des photos rejete
    print("route atteinte")
    data = request.params.mixed()
    #data = json.loads(data['data'])
    pathPrefix = dbConfig['camTrap']['path']
    fkMonitoredSite =  data['fk_MonitoredSite']
    fkEquipmentId = data['fk_EquipmentId']
    fkSensor = data['fk_Sensor']
    print( "site :" +str(fkMonitoredSite) )
    print( "equip: "+str(fkEquipmentId))
    print( "sensor :"+str(fkSensor))

    #query = "EXECUTE [EcoReleve_ECWP].[dbo].[pr_ValidateCameraTrapSession] "+str(fkSensor)+", "+str(fkMonitoredSite)+", "+str(fkEquipmentId)+";"


    query = text("""
     EXEC [EcoReleve_ECWP].[dbo].[pr_ValidateCameraTrapSession] :fkSensor, :fkMonitoredSite, :fkEquipmentId
    """).bindparams(
    bindparam('fkSensor', value=fkSensor),
    bindparam('fkMonitoredSite', value=fkMonitoredSite),
    bindparam('fkEquipmentId', value=fkEquipmentId)
    )

    #+str(fkSensor)+", "+str(fkMonitoreSite)+", "+str(fkEquipmentId)+";"
    # query = text(""" SELECT TOP 10 * FROM Station""")
    # query = text(""" SELECT 'toto'""")
    result  = session.execute(query)
    print ("resultat")
    print (result.rowcount)
    if result.rowcount > 0 :
        print("procedure a retourne des row")
        print("appel de la vue pour redimensioner et supprimer")
        query2 = text("""
        select path, name, validated from [ecoReleve_Sensor].[dbo].[TcameraTrap]
        where pk_id in (
        select pk_id
        from V_dataCamTrap_With_equipSite
        where
        fk_sensor = :fkSensor
        AND FK_MonitoredSite = :fkMonitoredSite
        AND equipID = :fkEquipmentId)""").bindparams(
        bindparam('fkSensor', value=fkSensor),
        bindparam('fkMonitoredSite', value=fkMonitoredSite),
        bindparam('fkEquipmentId', value=fkEquipmentId)
        )
        resultat = session.execute(query2).fetchall();
        print("les photos a traiter")
        print(resultat)



    #
    # for row in result :
    #     print(row)
    #for index in data2:
    #    print (index)


    # for index in data:
    #     """if ( index['checked'] == None ):
    #         print( " la photo id :"+str(index['PK_id'])+" "+str(index['name'])+" est a check" )
    #         #changer status
    #         request.response.status_code = 510
    #         return {'message': ""+str(index['name'])+" not checked yet"}
    #     else :# photo check"""
    #     if (index['validated'] == 4):
    #         pathSplit = index['path'].split('/')
    #         destfolder = str(pathPrefix)+"\\"+str(pathSplit[1])+"\\"+str(index['name'])
    #         print (" la photo id :"+str(index['PK_id'])+" "+str(index['name'])+" est a supprimer")
    #         print("on va supprimer :" +str(destfolder))
    #         #if os.path.isfile(destfolder):
    #         #    os.remove(destfolder)
    #         #deletePhotoOnSQL(request,str(index['PK_id']))
    #     else:
    #         print (" la photo id :"+str(index['PK_id'])+" "+str(index['name'])+" est a sauvegarder")
    #             #inserer en base
    #     """for key in index:
    #         if ( str(key) =='checkedvalidated'   )
    #         print ( str(key)+":"+str(index[key]))"""
    return 10
