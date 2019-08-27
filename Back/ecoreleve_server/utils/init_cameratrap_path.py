import os,sys
import shutil
import errno


def initialize_cameratrap_path( dbConfig, settings ):
    return NASHandleLogic ( settings )

class NASHandleLogic():

    NASObjServices = {}
    
    servicesNameMapping = {
        'camtrap' : 'camTrap.path' ,
        'mediafiles' : 'mediasFiles.path'
    }
    
    optionsServices = {
        'camtrap' : {
            'subDirectories' : ['export']
        },
        'mediafiles' : {
            'subDirectories' : None
        }
    }

    def __init__ ( self, settings ):

        self.initServices ( self.servicesNameMapping, settings )
        self.testAllServices ( )
        print("camtrap", self.getAvailableSpace ( 'camtrap' ) )
        print("mediafiles", self.getAvailableSpace ( 'mediafiles' ) )
        print("result")
    
    def initServices ( self, servicesName, settings ):
        for key in servicesName:
            newService = self.createAService( key, settings )
            self.NASObjServices.update( newService )      

    def createAService ( self, key, settings ):
        nameMapping = self.servicesNameMapping [ key ] 
        if nameMapping in settings :
            return {
                key : {
                    'url' : settings [ nameMapping ],
                    'exist' : None,
                    'hasAccess': None
                }
            }
        else :
            print( "something goes wrong ", nameMapping, "key is not present in settings" )
            return {}
    
    def testAllServices ( self ):
        for serviceName in self.NASObjServices:
            self.testExists ( serviceName )
            self.testRightsAcess ( serviceName )
            item = self.NASObjServices [ serviceName ]
            if item [ 'hasAccess' ] :
                if item [ 'exist' ] is not None and item [ 'exist' ] is not True:
                    pathTmp = item [ 'url' ]
                    self.createDir ( pathTmp )
                self.configureServiceWithOptions(serviceName)
            else:
                print( "Warning !!! it seem's that the user launching the application doesn't have access to :" )  
                print( "url :",item [ 'url' ], " please look in the *.ini file and check key :", self.servicesNameMapping [ serviceName ])
                print( "Then if the path is good for you, check right's access ")

    def testExists ( self , serviceName ):
        serviceItem = self.NASObjServices[ serviceName ]
        path = serviceItem [ 'url' ]
        serviceItem [ 'exist' ] = self.pathExists ( path )
    
    def pathExists (self, path ):
        return os.path.exists(path)

    def testRightsAcess ( self, serviceName ):
        serviceItem = self.NASObjServices [ serviceName ]
        path = serviceItem [ 'url' ]
        serviceItem [ 'hasAccess' ] = self.hasAccess ( path )
    
    def hasAccess ( self, path ):
        return os.access( path , os.W_OK ) 

    def createDir ( self, path ):
        if not self.pathExists( path ):
            try:
                print( "we try to create folder :" , path)
                os.makedirs ( path )
                print( "Creation : Ok")
            except Exception as e:
                print ( "Creation : Failed", e )
                raise
        else:
            print( "skip creation : " , path , "still exist" )

    def configureServiceWithOptions ( self, serviceName ):
        if serviceName in self.optionsServices:
            optionsTmp = self.optionsServices [ serviceName ]
            if 'subDirectories' in optionsTmp and optionsTmp [ 'subDirectories' ] is not None and optionsTmp [ 'subDirectories' ] != [] :
                rootDir = self.NASObjServices  [ serviceName ] [ 'url' ]
                subDirList = optionsTmp [ 'subDirectories' ]
                self.createSubDirectoriesFromRoot ( rootDir , subDirList )

    def createSubDirectoriesFromRoot ( self, rootDir, listDir ):
        for item in listDir:
            self.createDir ( os.path.join ( rootDir , item ) )

    def serviceIsOnline ( self, serviceName ):
        urlToTest = self.NASObjServices [ serviceName ] [ 'url' ]
        toRet = self.testExists( urlToTest )
        self.NASObjServices [ serviceName ] [ 'status' ] = toRet
        return toRet

    def getAvailableSpace ( self, serviceName ):
        path = self.NASObjServices [serviceName] ['url']
        ( total , used, free) = shutil.disk_usage ( path )
        return {
            'total' : str(total),
            'used' : str(used),
            'free' : str(free)
        }
        