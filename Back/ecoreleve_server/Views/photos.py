from ..Models.Log import sendLog
from ..Models import Station as StationDb
from pyramid.view import view_config
from ..Models import dbConfig
import json
import base64
import os


@view_config(route_name='photos',
             renderer='json',
             request_method='POST')
def savephoto(request):
    session = request.dbsession
    base64img = request.POST['base64'].split(',')
    idStation = request.POST['idStation']
    fileName = request.POST['fileName']
    print('on va essayer de creer le dossier et le fichier')
    print(dbConfig['photos']['path']+'stations_'+str(idStation))
    print(dbConfig['photos']['path']+'stations_'+str(idStation)+'\\'+str(fileName))
    try:
        print("tentative dossier")
        if not os.path.isdir(dbConfig['photos']['path']+'stations_'+str(idStation)):
            print("le dossier n'existe pas on le créé")
            try:
                os.mkdir(dbConfig['photos']['path']+'stations_'+str(idStation))
            except OSError as e :
                if e.errno != errno.EEXISTS:
                    raise

        print("tentative fichier")
        with open(dbConfig['photos']['path']+'stations_'+str(idStation)+'/'+str(fileName), "wb") as fh:
            fh.write(base64.b64decode( base64img[1] ))
            #ratacher path a la station
            session.query(StationDb).filter(StationDb.ID == idStation).update({"Photos" : 'stations_'+str(idStation)+'\\'+str(fileName)})
            session.commit()
    except EnvironmentError as e:
        print(EnvironmentError)
        print (e.errno)
        print (e.filename)
        print (e.strerror)
        request.response.status_int = 500
        return ""
    #response.status_int = 200
    return "ok"

@view_config(route_name='photos',
             renderer='json',
             request_method='GET')
def getPhoto(request):
    return 200