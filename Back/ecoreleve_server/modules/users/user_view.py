import json
from sqlalchemy import select
from pyramid.security import NO_PERMISSION_REQUIRED, remember
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.interfaces import IAuthenticationPolicy

from .user_model import User
from ecoreleve_server.core.security import groupfinder


@view_config(
    route_name='core/user',
    permission=NO_PERMISSION_REQUIRED,
    renderer='json'
)
def users(request):
    """Return the list of all the users with their ids.
    """
    session = request.dbsession
    query = select([
        User.id.label('PK_id'),
        User.Login.label('fullname')
    ]).order_by(User.Lastname, User.Firstname)
    return [dict(row) for row in session.execute(query).fetchall()]


@view_config(
    route_name='core/currentUser',
    renderer='json'
)
def current_user(request, user_id=None):
    """Return the list of all the users with their ids.
    """
    session = request.dbsession

    authenticatedTmp = request.authenticated_userid

    if user_id is not None:
        userid = user_id
    else:
        userid = int(authenticatedTmp['iss'])
    currentUserRole = groupfinder(userid, request)

    response = {
        'PK_id'     : int(authenticatedTmp['iss']),
        'fullname'  : authenticatedTmp['username'],
        'Language'  : authenticatedTmp['userlanguage']
    }
    response['role'] = currentUserRole[0].replace('group:', '')
    return response



def make_jwt(request, claims):
    policy = request.registry.queryUtility(IAuthenticationPolicy)
    return policy.encode_jwt(request, claims)


@view_config(
    route_name='users/id',
    renderer='json'
)
def getUser(request):
    user_id = int(request.matchdict['id'])
    return current_user(request, user_id=user_id)
