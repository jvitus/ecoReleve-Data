from sqlalchemy import (Column,
                        DateTime,
                        ForeignKey,
                        Integer,
                        Numeric,
                        String,
                        Sequence,
                        orm,
                        Table,
                        cast,
                        Date,
                        select,
                        or_,
                        and_,
                        func,
                        text,
                        bindparam)

from sqlalchemy.ext.hybrid import hybrid_property
from sqlalchemy.orm import relationship
from sqlalchemy.ext.associationproxy import association_proxy

from ecoreleve_server.database.meta import Main_Db_Base
from ecoreleve_server.core.base_model import HasDynamicProperties
from ecoreleve_server.core.base_types import IntegerDateTime


class ErrorCheckIndividualCodes(Exception):

    def __init__(self, propertyName):
        self.propertyName = propertyName
        self.value = self.propertyName+' already exists'

    def __str__(self):
        return self.value


class Individual (HasDynamicProperties, Main_Db_Base):

    __tablename__ = 'Individual'

    moduleFormName = 'IndivForm'
    moduleGridName = 'IndivFilter'

    ID = Column(Integer, Sequence('Individual__id_seq'), primary_key=True)
    creationDate = Column(DateTime, nullable=False, default=func.now())
    Species = Column(String(250))
    Age = Column(String(250))
    Birth_date = Column(Date)
    Death_date = Column(Date)
    Original_ID = Column(String(250), default='0')

    Locations = relationship('Individual_Location',
                             cascade="all, delete-orphan")
    Equipments = relationship('Equipment',
                              cascade="all, delete-orphan",
                              primaryjoin='Individual.ID==' +
                                'Equipment' + '.FK_Individual')

    _Status_ = relationship(
        'IndividualStatus', uselist=False, backref="Individual")
    observations = relationship(
        'Observation',
        back_populates="individuals")

    Status_ = association_proxy('_Status_', 'Status_')

    def as_dict(self):
        values = HasDynamicProperties.as_dict(self)
        values['Status_'] = self.Status_
        return values

class Individual_Location(Main_Db_Base):
    __tablename__ = 'Individual_Location'

    ID = Column(Integer, Sequence(
        'Individual_Location__id_seq'), primary_key=True)
    LAT = Column(Numeric(9, 5))
    LON = Column(Numeric(9, 5))
    ELE = Column(Integer)
    Date = Column(DateTime)
    Precision = Column(Integer)
    FK_Sensor = Column(Integer, ForeignKey('Sensor.ID'))
    FK_Individual = Column(Integer, ForeignKey('Individual.ID'))
    # FK_Region = Column(Integer, ForeignKey('Region.ID'))
    FK_FieldworkArea = Column(Integer, ForeignKey('FieldworkArea.ID'))

    creator = Column(Integer)
    creationDate = Column(DateTime)
    type_ = Column(String(10))

    @hybrid_property
    def date_timestamp(self):
        return self.Date.timestamp()

    @date_timestamp.expression
    def date_timestamp(cls):
        return cast(cls.Date, IntegerDateTime).label('timestamp')


class IndividualStatus(Main_Db_Base):
    __table__ = Table(
                    'IndividualStatus', Main_Db_Base.metadata,
                    Column(
                        'FK_Individual',
                        Integer,
                        ForeignKey('Individual.ID'),
                        primary_key=True
                    ),
                    Column('Status_', String)
                )
    FK_Individual = __table__.c['FK_Individual']
    Status_ = __table__.c['Status_']
