from ecoreleve_server.traversal.core import (
    MetaRootRessource,
    MetaCollectionRessource,
    MetaItemRessource,
    MetaEmptyNodeRessource
)
from ecoreleve_server.traversal.formbuilder import (
    FieldActivityCollection,
    FieldActivityProtocoleTypeCollection,
    ProtocoleTypeCollection
)
from ecoreleve_server.traversal.importdatas import (
    GSMImport,
    ARGOSImport
)
from ecoreleve_server.traversal.stations import (
    StationsCollection
)

from ecoreleve_server.traversal.validate import (
    Validate
)
from ecoreleve_server.modules.permissions import (
    context_permissions
)


class FormBuilderRessource(MetaEmptyNodeRessource):
    __ROUTES__ = {
        'FieldActivity':                FieldActivityCollection,
        'FieldActivity_ProtocoleType':  FieldActivityProtocoleTypeCollection,
        'ProtocoleType':                ProtocoleTypeCollection,
        }

    def __acl__(self):
        return context_permissions.get('formbuilder')


class ImportRessource(MetaEmptyNodeRessource):

    __ROUTES__ = {
        'gsm':      GSMImport,
        'argos':    ARGOSImport
        }

    def __acl__(self):
        return context_permissions.get('formbuilder')


class TraversalRessource(MetaRootRessource):

    __ROUTES__ = {
        'formbuilder':  FormBuilderRessource,
        'import':       ImportRessource,
        'stations':     StationsCollection,
        'validate':     Validate
        }

    def __acl__(self):
        return context_permissions.get('formbuilder')
