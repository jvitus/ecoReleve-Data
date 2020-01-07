from ecoreleve_server.modules.permissions import context_permissions
from pyramid.httpexceptions import HTTPBadRequest
from ecoreleve_server.traversal.core import (
    MetaCollectionRessource,
    MetaItemRessource,
    MetaEmptyNodeRessource
)
from ecoreleve_server.database.sensor_db import (
    Gsm,
    ArgosGps
)
from ecoreleve_server.database.main_db import (
    Station
)
from ecoreleve_server.modules.permissions import (
    context_permissions
)
from sqlalchemy import asc, and_, exists
from sqlalchemy.orm import aliased
from webargs.pyramidparser import parser
from ecoreleve_server.utils.decorator import timing


class StationsCollection(MetaCollectionRessource):

    __from_model__ = Station

    def __acl__(self):
        return context_permissions.get('stations')
