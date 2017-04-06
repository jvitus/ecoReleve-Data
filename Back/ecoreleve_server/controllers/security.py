"""
Created on Mon Aug 25 13:00:16 2014
@author: Natural Solutions (Thomas)
"""

from ..Models import DBSession , User, userOAuthDict
import transaction 
from pyramid.httpexceptions import HTTPUnauthorized,HTTPForbidden
from pyramid_jwtauth import * 
from pyramid.security import (
    ALL_PERMISSIONS,
    DENY_ALL,
    Allow,
    Authenticated,
)

# Root class security #
class SecurityRoot(object):
    __acl__ = [
        (Allow, Authenticated, 'read'),
        (Allow, Authenticated, 'all'),
        (Allow, 'group:admins', 'admin'),
        (Allow, 'group:admins', 'superUser'),
        (Allow, 'group:admins', 'all'),
        (Allow, 'group:superUsers', 'superUser'),
        (Allow, 'group:superUsers', 'all'),
        # DENY_ALL
    ]
    
    def __init__(self, request):
        self.request = request


class myJWTAuthenticationPolicy(JWTAuthenticationPolicy):


    def get_userID(self, request):
        try :
            token = request.cookies.get("ecoReleve-Core")
            claims = self.decode_jwt(request, token)
            userid = claims['iss']
            return userid
        except: 
            return
    def get_userInfo(self, request):
        try :
            token = request.cookies.get("ecoReleve-Core")
            claims = self.decode_jwt(request, token, verify=True)
            return claims, True
        except: 
            try:
                token = request.cookies.get("ecoReleve-Core")
                claims = self.decode_jwt(request, token, verify=False)
                return claims,False
            except:
                return None, False

    def user_info(self, request):
        claim,verify_okay = self.get_userInfo(request)
        if claim is None:
            return None
        return claim

    def authenticated_userid(self, request):
        userid = self.get_userID(request)
        claim = self.user_info(request)

        if userid is None:
            return None
        return claim

    def unauthenticated_userid(self, request):
        userid = self.get_userID(request)
        return userid

    def remember(self, response, principal, **kw):
        response.set_cookie('ecoReleve-Core', principal, max_age = 100000)

    def forget(self, request):
        request.response.delete_cookie('ecoReleve-Core')

    def _get_credentials(self, request):
        return self.get_userID(request)

    def _check_signature(self, request):
        if request.environ.get('jwtauth.signature_is_valid', False):
            return True

    def challenge(self, request, content="Unauthorized"):
        if self.authenticated_userid(request):
            return HTTPUnauthorized(content, headers=self.forget(request))

        return HTTPForbidden(content, headers=self.forget(request))


routes_permission = {
    'stations' : {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'admin'
    },
    'protocols' : {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'sensors' : {
        'GET': 'all',
        'POST': 'admin',
        'PUT': 'admin',
        'DELETE': 'admin'
    },
    'individuals' : {
        'GET': 'all',
        'POST': 'admin',
        'PUT': 'superUser',
        'DELETE': 'noONe'
    },
    'monitoredSites' : {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'admin'
    },
    'release' : {
        'GET': 'admin',
        'POST': 'admin',
        'PUT': 'admin',
        'DELETE': 'admin'
    },
    'export' : {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'rfid' : {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'argos' : {
        'GET': 'superUser',
        'POST': 'superUser',
        'PUT': 'superUser',
        'DELETE': 'superUser'
    },
    'gsm' : {
        'GET': 'superUser',
        'POST': 'superUser',
        'PUT': 'superUser',
        'DELETE': 'superUser'
    },
}




