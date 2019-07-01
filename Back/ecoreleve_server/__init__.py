import datetime
from decimal import Decimal
import exiftool
from urllib.parse import quote_plus
from sqlalchemy import engine_from_config
from pyramid.config import Configurator
from pyramid.renderers import JSON
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.events import NewRequest
from sqlalchemy.orm import sessionmaker, scoped_session

# from .core import SecurityRoot
from .core.init_db import initialize_engines, dbConfig
# from .core.security import include_jwt_policy
from .utils import loadThesaurusTrad
from .utils.callback import add_cors_headers_response_callback, session_callback
from .utils.init_cameratrap_path import initialize_cameratrap_path
from .modules.url_dispatch import add_routes

from .renderers.csvrenderer import CSVRenderer
from .renderers.pdfrenderer import PDFrenderer
from .renderers.gpxrenderer import GPXRenderer

from pyramid.view import view_config
from pyramid.security import NO_PERMISSION_REQUIRED
from ecoreleve_server.Resources import Root, Home, StationsContainer, ObservationsContainer



# mySubExif = exiftool.ExifTool()
# mySubExif.start()


def datetime_adapter(obj, request):
    """Json adapter for datetime objects."""
    try:
        return obj.strftime('%d/%m/%Y %H:%M:%S')
    except:
        return obj.strftime('%d/%m/%Y')

def date_adapter(obj, request):
    """Json adapter for datetime objects."""
    try:
        return obj.strftime('%d/%m/%Y')
    except:
        return obj

def time_adapter(obj, request):
    """Json adapter for datetime objects."""
    try:
        return obj.strftime('%H:%M')
    except:
        return obj.strftime('%H:%M:%S')

def decimal_adapter(obj, request):
    """Json adapter for Decimal objects."""
    return float(obj)

def initialize_exiftool():
    mySubExif = exiftool.ExifTool()
    mySubExif.start()



    
def myRootFactory(request):

    root = Home('',None,request)
    setattr(root,'stations',StationsContainer('stations',root,request))
    setattr(root,'observations',ObservationsContainer('observations',StationsContainer('stations',root,request),request))

    return root





def main(global_config, **settings):
    """ This function initialze DB conection and returns a Pyramid WSGI application. """
    # ENTRY POINT
    # settings = Python dictionnary representing deployment settings
    config = Configurator(settings=settings)  

    # include mandatory packages for the application
    # 1)transaction_manager
    config.include('pyramid_tm')
    # 2)for jwt security (maybe need to be replace)
    config.include('pyramid_jwtauth')

    # will create engine and add it to registry 
    engines = initialize_engines(settings, config)

    # use engine for model 

    config.include('.ModelDB')
    config.add_request_method(session_callback, name='dbsession', reify=True)

    # Add renderer for JSON objects
    json_renderer = JSON()
    json_renderer.add_adapter(datetime.datetime, datetime_adapter)
    # json_renderer.add_adapter(datetime.date, datetime_adapter)
    json_renderer.add_adapter(Decimal, decimal_adapter)
    json_renderer.add_adapter(datetime.time, time_adapter)
    json_renderer.add_adapter(datetime.date, date_adapter)
    config.add_renderer('json', json_renderer)

    # Add renderer for CSV, PDF,GPX files.
    config.add_renderer('csv', CSVRenderer)
    config.add_renderer('pdf', PDFrenderer)
    config.add_renderer('gpx', GPXRenderer)

    # include_jwt_policy(config)
    # config.set_root_factory(SecurityRoot)

    config.add_subscriber(add_cors_headers_response_callback, NewRequest)

    ''' 
    initialize_cameratrap_path(dbConfig, settings)
    loadThesaurusTrad(config)
    '''

    config.set_root_factory(myRootFactory)
    config.scan('ecoreleve_server.core.base_view')

    # config.add_route('homePerso', '/')
    # config.add_route('testPerso', '/test')
    # config.add_view( home, route_name='homePerso',renderer= 'json' )
    # config.add_view( testPerso, route_name='testPerso',renderer='json' )
    # config.scan()

    return config.make_wsgi_app()

def home(request):
    return {
        'ok' : 'yoloooo',
        'non': 'et ouais'
    }


def testPerso(request):
    return 'ok'







