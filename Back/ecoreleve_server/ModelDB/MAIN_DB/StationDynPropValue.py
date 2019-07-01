from sqlalchemy import (
    Column,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    Numeric,
    String,
    Sequence,
    func
    )
from sqlalchemy.orm import relationship
from ecoreleve_server.ModelDB.meta import MAIN_DB_BASE

from sqlalchemy.ext.hybrid import hybrid_property


class StationDynPropValue(MAIN_DB_BASE):

    __tablename__ = 'StationDynPropValue'

    ID = Column(Integer,
                Sequence('StationDynPropValue__id_seq'),
                primary_key=True)
    StartDate = Column(DateTime,
                       nullable=False)
    ValueInt = Column(Integer,
                      nullable=True)
    ValueString = Column(String(255),
                         nullable=True)
    ValueDate = Column(DateTime,
                       nullable=True)
    ValueFloat = Column(Float,
                        nullable=True)
    FK_StationDynProp = Column(Integer,
                               ForeignKey('StationDynProp.ID'),
                               nullable=False)
    FK_Station = Column(Integer,
                        ForeignKey('Station.ID'),
                        nullable=False)

    station = relationship("Station",back_populates="dynPropsValues")
    dynProp = relationship("StationDynProp",back_populates="Stations")   