from sqlalchemy import (
    Column,
    Integer,
    Sequence,
    Unicode
    )

from ecoreleve_server.ModelDB import MAIN_DB_BASE



class ObservationDynProp (MAIN_DB_BASE):

    __tablename__ = 'ObservationDynProp'


    ID = Column(Integer, Sequence('ObservationDynProp__id_seq'), primary_key=True)
    Name = Column(Unicode(250), nullable=True)
    TypeProp = Column(Unicode(250), nullable=True)




