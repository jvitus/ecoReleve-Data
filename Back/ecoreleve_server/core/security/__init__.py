import json
from pyramid.authorization import ACLAuthorizationPolicy
from sqlalchemy import select

from .jwt_security import myJWTAuthenticationPolicy
from .. import Base, get_redis_con

localRedis = get_redis_con()

USERS = {
            1   :   'Administrateur',
            2   :   'superUser',
            3   :   'user'
        } 

GROUPS = {
        'Administrateur'    : ['group:Administrateur'],
        'superUser'         : ['group:superUser'],
        'user'              : ['group:user']
        }


def groupfinder(userid, request):
    role = []
    claims = request.authenticated_userid

    ##FIX
    # we can access to registry.settings everywhere in app 
    # IF IT'S FOR READ!!!!! IT'S OK 
    ##

    instanceNameApp = request.registry.settings.get('RENECO.SECURITE.TIns_Label')
    instanceNameApp = instanceNameApp.encode('latin1').decode('utf-8') # youhouuu vive les accents!!!!!

    if 'roles' in claims and instanceNameApp in claims['roles']:
        curRole = request.authenticated_userid['roles'][instanceNameApp]
        role = GROUPS.get(curRole)

    return role

def include_jwt_policy(config):
    authz_policy = ACLAuthorizationPolicy()
    config.set_authorization_policy(authz_policy)

    settings = config.get_settings()
    authn_policy = myJWTAuthenticationPolicy.from_settings(settings)
    authn_policy.find_groups = groupfinder
    config.set_authentication_policy(authn_policy)
    config.set_default_permission('read')
    config.add_forbidden_view(authn_policy.challenge)