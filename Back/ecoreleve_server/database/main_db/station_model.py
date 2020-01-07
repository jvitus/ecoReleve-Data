from sqlathanor import (
    Column,
    relationship
)
from sqlalchemy import (
    DateTime,
    Float,
    ForeignKey,
    Integer,
    Numeric,
    String,
    Sequence,
    func
)
from sqlalchemy.ext.hybrid import hybrid_property


from ecoreleve_server.database.meta import Main_Db_Base
from ecoreleve_server.core.base_model import HasDynamicProperties
from ecoreleve_server.utils.parseValue import dateParser


# class Station(HasDynamicProperties, Main_Db_Base):

#     __tablename__ = 'Station'

#     moduleFormName = 'StationForm'
#     moduleGridName = 'StationGrid'

#     ID = Column(Integer, Sequence('Stations__id_seq'), primary_key=True)
#     StationDate = Column(DateTime, index=True, nullable=False)
#     Name = Column(String(250))
#     LAT = Column(Numeric(9, 5))
#     LON = Column(Numeric(9, 5))
#     ELE = Column(Integer)
#     precision = Column(Integer)
#     fieldActivityId = Column(Integer, ForeignKey(
#         'fieldActivity.ID'), nullable=True)
#     creator = Column(Integer)
#     creationDate = Column(DateTime, default=func.now())
#     original_id = Column(String(250))
#     Comments = Column(String(250))
#     Place = Column(String(250))
#     FK_MonitoredSite = Column(Integer, ForeignKey(
#         'MonitoredSite.ID'), nullable=True)
#     Comments = Column(String(250))
#     FK_Region = Column(Integer, ForeignKey('Region.ID'), nullable=True)

#     Observations = relationship(
#         'Observation', back_populates='Station', cascade="all, delete-orphan")
#     # FK_Region = Column(Integer, ForeignKey('Region.ID'), nullable=True)
#     FK_FieldworkArea = Column(Integer, ForeignKey('FieldworkArea.ID'), nullable=True)

#     Station_FieldWorkers = relationship(
#         'Station_FieldWorker', backref='Station', cascade="all, delete-orphan")

#     MediasFiles = relationship(
#         'MediasFiles', back_populates='Station', cascade="all, delete-orphan")

#     ''' hybrid property on relationship '''
#     @hybrid_property
#     def FieldWorkers(self):
#         if self.Station_FieldWorkers:
#             fws = []
#             for curFW in self.Station_FieldWorkers:
#                 fws.append(
#                     {'FieldWorker': curFW.FK_FieldWorker, 'ID': curFW.ID})
#             return fws
#         else:
#             return []

#     ''' Configure a setter for this hybrid property '''
#     @FieldWorkers.setter
#     def FieldWorkers(self, values):
#         fws = []
#         if len(values) != 0:
#             for item in values:
#                 if 'ID' in item and item['ID']:

#                     curFW = list(filter(lambda x: x.ID == item[
#                                  'ID'], self.Station_FieldWorkers))[0]
#                     curFW.FK_FieldWorker = int(item['FieldWorker'])
#                 else:
#                     curFW = Station_FieldWorker(FK_FieldWorker=int(
#                         item['FieldWorker']), FK_Station=self.ID)
#                 fws.append(curFW)
#         self.Station_FieldWorkers = fws

#     @FieldWorkers.expression
#     def FieldWorkers(cls):
#         return Station_FieldWorker.id


class Station_FieldWorker (Main_Db_Base):

    __tablename__ = 'Station_FieldWorker'

    ID = Column(Integer, Sequence(
        'Station_FieldWorker__id_seq'), primary_key=True)
    FK_Station = Column(Integer, ForeignKey('Station.ID'))
    FK_FieldWorker = Column(Integer, ForeignKey('User.ID'))

    FieldWorker = relationship('User')

    @hybrid_property
    def FieldWorkerName(self):
        if self.FieldWorker:
            return self.FieldWorker.Login
        else:
            return None

    @hybrid_property
    def FieldWorkerID(self):
        if self.FieldWorker:
            return self.FieldWorker.id
        else:
            return None


class Station(Main_Db_Base):

    __tablename__ = 'Station'

    ID = Column(
        Integer,
        Sequence('Stations__id_seq'),
        primary_key=True
        )
    StationDate = Column(
        DateTime,
        index=True,
        nullable=False
        )
    Name = Column(
        String(250),
        nullable=True
        )
    LAT = Column(
        Numeric(9, 5),
        nullable=True
        )
    LON = Column(
        Numeric(9, 5),
        nullable=True
        )
    ELE = Column(
        Integer,
        nullable=True
        )
    precision = Column(
        Integer,
        nullable=True
        )
    creator = Column(
        Integer,
        nullable=True
        )
    creationDate = Column(
        DateTime,
        default=func.now(),
        nullable=True
        )
    original_id = Column(
        String(250),
        nullable=True
        )
    Comments = Column(
        String(250),
        nullable=True
        )
    Place = Column(
        String(250),
        nullable=True
        )

    fieldActivityId = Column(
        Integer,
        ForeignKey('fieldActivity.ID'),
        nullable=True
        ) #TODO rename to fk_fiekdActivity
    FK_StationType = Column(
        Integer,
        ForeignKey('StationType.ID'),
        nullable=False
        )
    FK_MonitoredSite = Column(
        Integer,
        ForeignKey('MonitoredSite.ID'),
        nullable=True
        )
    FK_Region = Column(
        Integer,
        ForeignKey('Region.ID'),
        nullable=True
        )
    FK_FieldworkArea = Column(
        Integer,
        nullable=True
        )
    FK_AdministrativeArea = Column(
        Integer,
        nullable=True
        )
    FK_GridCell = Column(
        Integer,
        nullable=True
        )

    stationTypes = relationship(
        'StationType',
        # back_populates="stations",
        lazy="select",
        innerjoin=True
        )
    stationDynPropValues = relationship(
        "StationDynPropValue",
        # back_populates="stations",
        lazy="select",
        innerjoin=False
        )

    observations = relationship(
        "Observation",
        # back_populates="stations",
        lazy="select",
        innerjoin=True
    )


class StationType(Main_Db_Base):

    __tablename__ = 'StationType'

    ID = Column(
        Integer,
        Sequence('StationType__id_seq'),
        primary_key=True
        )
    Name = Column(
        String(250),
        nullable=True
        )
    Status = Column(
        Integer,
        nullable=True
        )

    stations = relationship(
        'Station',
        lazy="select",
        # back_populates="stationTypes"
        )
    stationType_StationDynProps = relationship(
        "StationType_StationDynProp",
        lazy="select",
        # back_populates="stationTypes"
        )


class StationType_StationDynProp(Main_Db_Base):

    __tablename__ = 'StationType_StationDynProp'

    ID = Column(
        Integer,
        Sequence('StationType_StationDynProp__id_seq'),
        primary_key=True
        )
    Required = Column(
        Integer,
        server_default='0'
        )
    FK_StationType = Column(
        Integer,
        ForeignKey('StationType.ID'),
        nullable=False
        )
    FK_StationDynProp = Column(
        Integer,
        ForeignKey('StationDynProp.ID'),
        nullable=False
        )

    stationTypes = relationship(
        "StationType",
        # back_populates="stationType_StationDynProps"
        )
    stationDynProps = relationship(
        "StationDynProp",
        # back_populates="stationTypes"
        )


class StationDynProp(Main_Db_Base):

    __tablename__ = 'StationDynProp'

    ID = Column(Integer, Sequence('StationDynProp__id_seq'), primary_key=True)
    Name = Column(String(250), nullable=True)
    TypeProp = Column(String(250), nullable=True)

    stationTypes = relationship(
        "StationType_StationDynProp",
        # back_populates="stationDynProps"
        )

    stationDynPropValues = relationship(
        "StationDynPropValue",
        # back_populates="dynProps"
        )


class StationDynPropValue(Main_Db_Base):

    __tablename__ = 'StationDynPropValue'

    ID = Column(
        Integer,
        Sequence('StationDynPropValue__id_seq'),
        primary_key=True
        )
    StartDate = Column(
        DateTime,
        nullable=False
        )
    ValueInt = Column(
        Integer,
        nullable=True
        )
    ValueString = Column(
        String(255),
        nullable=True
        )
    ValueDate = Column(
        DateTime,
        nullable=True
        )
    ValueFloat = Column(
        Float,
        nullable=True
        )
    FK_StationDynProp = Column(
        Integer,
        ForeignKey('StationDynProp.ID'),
        nullable=False
        )
    FK_Station = Column(
        Integer,
        ForeignKey('Station.ID'),
        nullable=False
        )

    stations = relationship(
        "Station",
        # back_populates="stationDynPropValues"
        )
    dynProps = relationship(
        "StationDynProp",
        # back_populates="stationDynPropValues"
        )
