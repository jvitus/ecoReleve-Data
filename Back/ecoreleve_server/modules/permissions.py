from pyramid.security import (
    Allow,
    Authenticated,
    ALL_PERMISSIONS,
    Everyone,
    Deny
)

context_permissions = {
    'regions': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        # (Allow, Authenticated, ALL_PERMISSIONS),
        (Allow, 'group:superUser', ('create', 'update', 'read')),
        (Allow, 'group:user', ('read'))
    ],

    'import': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', ('create', 'update', 'read')),
        (Allow, 'group:user', ('create', 'update', 'read'))
    ],

    'stations': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', ('create', 'update', 'read')),
        (Allow, 'group:user', ('create', 'update', 'read'))
    ],

    'observations': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', ALL_PERMISSIONS),
        (Allow, 'group:user', ALL_PERMISSIONS)
    ],

    'individuals': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', ('update', 'read')),
        (Allow, 'group:user', 'read')
    ],

    'monitoredSites': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', ('create', 'update', 'read')),
        (Allow, 'group:user', ('create', 'update', 'read'))
    ],

    'sensors': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUser', 'read'),
        (Allow, 'group:user', 'read')
    ],

    'release': [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Deny, 'group:superUser', ALL_PERMISSIONS),
        (Deny, 'group:user', ALL_PERMISSIONS),
    ],
    'dashboard' : [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUsers', 'read'),
        (Allow, 'group:users', 'read')
    ],
    'mediasfiles' : [
        (Allow, 'group:Administrateur', ALL_PERMISSIONS),
        (Allow, 'group:superUsers', ('create', 'update', 'read')),
        (Allow, 'group:users', 'read')
    ]
}


routes_permission = {
    'stations': {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'Administrateur'
    },
    'protocols': {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'sensors': {
        'GET': 'all',
        'POST': 'Administrateur',
        'PUT': 'Administrateur',
        'DELETE': 'Administrateur'
    },
    'individuals': {
        'GET': 'all',
        'POST': 'Administrateur',
        'PUT': 'superUser',
        'DELETE': 'noONe'
    },
    'monitoredSites': {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'Administrateur'
    },
    'release': {
        'GET': 'Administrateur',
        'POST': 'Administrateur',
        'PUT': 'Administrateur',
        'DELETE': 'Administrateur'
    },
    'export': {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'rfid': {
        'GET': 'all',
        'POST': 'all',
        'PUT': 'all',
        'DELETE': 'all'
    },
    'argos': {
        'GET': 'superUser',
        'POST': 'superUser',
        'PUT': 'superUser',
        'DELETE': 'superUser'
    },
    'gsm': {
        'GET': 'superUser',
        'POST': 'superUser',
        'PUT': 'superUser',
        'DELETE': 'superUser'
    },
    'dashboard': {
        'GET': 'all',
        'POST': 'superUser',
        'PUT': 'superUser',
        'DELETE': 'superUser'
    },
    'mediasfiles': {
        'GET': 'all',
        'POST': 'Administrateur',
        'PUT': 'Administrateur',
        'DELETE': 'Administrateur'
    },
}
