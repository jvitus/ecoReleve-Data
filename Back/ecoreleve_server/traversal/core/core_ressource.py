from webargs import fields
from webargs.pyramidparser import parser
from ecoreleve_server.database.main_db import (
    Observation
)
from ecoreleve_server.database.main_db import (
    Station,
    StationType,
    StationType_StationDynProp,
    StationDynProp,
    StationDynPropValue,
    Individual
)
from sqlalchemy.orm import (
    contains_eager,
    aliased
)
from sqlalchemy import asc, inspect, and_
import copy
from collections import namedtuple, deque


class MetaRootRessource (dict):
    __name__ = ''
    __parent__ = None
    __specialKey__ = None

    __ROUTES__ = {}

    def __init__(self, name, parent, request):
        self.__name__ = name
        self.__parent__ = parent
        # DON'T CHANGE THIS :)
        # webargs expect 'request' key in object for parsing
        # for now i don't know another or workaround
        self.request = request

    def __acl__(self):
        return []

    @property
    def __routes__(self):
        return self.__ROUTES__

    def __getitem__(self, name):
        '''
        get item
        '''
        toRet = None

        if isinstance(self, MetaCollectionRessource):
            '''
            If the current node is a Collection
            the next node should be an instance of this collection
            by default REST say collection/{id}
            in most cases {id} = int
            so we have to check if the name is an int first
            but keep in min that Traversal use __getitem__
            and we can't populate all items with id
            so we need a special key {int} in our __routes__ dict

            TODO __specialKey__ should be declare is type
            and we check if name is same type
            '''
            try:
                int(name)
                toRet = self.__routes__.get(self.__specialKey__, None)
            except ValueError:
                raise KeyError(f'the key for item should be and int: {self.__name__}')
        else:
            nextNode = name.lower()
            if nextNode != self.__specialKey__:
                toRet = self.__routes__.get(nextNode, None)

        if toRet is None:
            raise KeyError(f'__getitem__ for Ressource: {self.__name__}')
        else:
            return toRet(name=nextNode, parent=self, request=self.request)

    def retrieve(self):
        raise NotImplementedError(f'retrieve for Ressource: {self.__name__}')

    def create(self):
        raise NotImplementedError(f'create for Ressource: {self.__name__}')

    def delete(self):
        raise NotImplementedError(f'delete for Ressource: {self.__name__}')

    def options(self):
        raise NotImplementedError(f'options for Ressource: {self.__name__}')

    def patch(self):
        raise NotImplementedError(f'patch for Ressource: {self.__name__}')

    def update(self):
        raise NotImplementedError(f'update for Ressource: {self.__name__}')


class MetaEmptyNodeRessource (MetaRootRessource):
    pass


class MetaCollectionRessource (MetaRootRessource):

    __from_model__ = Station
    __with_relationships__ = [
        'Station.stationTypes',
        'Station.stationDynPropValues',
        'Station.observations',
        'Observation.individuals'
        ]
    __with_models__ = [StationType, Observation, StationDynPropValue] #, Individual]
    __specialKey__ = '{int}'

    __serializerOutput__ = None

    # Should have a limitParams too
    # If we want to paginate EVERY request it's for limit number of objects
    # you can fetch in one
    # query client can't ask offset = 0 and limit = 5 000 000

    # We could by default overwrite the offset and limit params for request
    # But we need to have control in the ressource
    # TODO: Create a class with LimitQuery and NoLimitQuerry
    missing = {
        'offset':   0,
        'limit': 500
    }
    defaultParams = {
        'offset': fields.Int(missing=missing.get('offset')),
        'limit': fields.Int(missing=missing.get('limit'))
    }

    paramsForContext = {
    }

    def __init__(self, name, parent, request):
        super().__init__(name=name, parent=parent, request=request)
        self.defaultParams = self._setDefaultParams()
        self.__queryBuilder__ = {
            '__initAlias__': None,
            '__listCols__': [],
            '__pathAlias__': {},
            '__aliasedDict__': {},
            '__inspectedList__': [],
            '__relationshipsAdded__': []
        }
        self.__serializerOutput__ = {
                '__struct__' : {},
                '__namedTupleCollections__': {},
                '__pathNamedtuple__' : {},
                '__frameorder__': [],
                '__framestartingTable__': None,
                '__listCols__': []
            }

    def addDictsSchemaAndColumnsAlliased(self, model=None, prefix='', separator='.'):
        #
        # REFACT should be call at start and end of query
        #
        #
        toRetDict = {}
        # print(f'For model { model.__table__.name}')
        alias = aliased(model , name=prefix)
        if prefix =='':
            self.__queryBuilder__['__pathAlias__']['Station'] = alias
        else:
            self.__queryBuilder__['__pathAlias__'][prefix] = alias
        for item in alias._aliased_insp.local_table.columns:
            # print(f'add column {item} with alias {prefix}{separator}{item.name}')
            self.__queryBuilder__['__listCols__'].append(item.label(f'{prefix}{separator}{item.name}'))
            toRetDict[item.name] = None
        self.__queryBuilder__['__aliasedDict__'][prefix] = toRetDict
        self.__serializerOutput__['__pathNamedtuple__'][prefix] = namedtuple('test', toRetDict.keys(), defaults=(None,) * len(toRetDict.keys()))
        return alias

    def applyAllRelationship(self, query=None):
        self.__query__ = query # need reference outside scope exploreTreeAndApply is recursive 
        modelClass = self.__queryBuilder__['__initAlias__']
        self.exploreTreeAndApply(startingModel=self.__from_model__,prefix=self.__from_model__.__table__.name)
        query = self.__query__
        del self.__query__ # free for reference
        return query

    def initQuery(self, prefix='', separator='.'):
        inspectedModel = inspect(self.__from_model__) # need Mapped Table for alias look in doc ?
        table = inspectedModel.persist_selectable

        alias = self.addDictsSchemaAndColumnsAlliased(model=self.__from_model__, prefix='Station', separator='.')
        self.__queryBuilder__['__initAlias__'] = alias
        query = self.request.dbsession.query(alias)
        query = query.with_labels()
        return query

    def exploreTreeAndApply(self, startingModel=None, prefix='', separator='.', parent=[]):

        inspectedSource = inspect(startingModel)
        # explore eache relationship defined in model
        for relation in inspectedSource.relationships:
            relationshipTmp = getattr(startingModel, relation.key)
            targetClass = relation.entity.class_
            # if
            #   the relationship is not yet added
            #   and
            #   the relationship is defined for the collections
            if (
                f'{relationshipTmp}' not in self.__queryBuilder__['__relationshipsAdded__']
                and
                f'{relationshipTmp}' in self.__with_relationships__
            ):
                # fix curPrefix from prefix "depth" for not altering profile for siblings relationship
                curPrefix = f'{prefix}{separator}{relation.key}'
                # create schema and store it
                # alias alls columns from the model
                # the main idea is flattened dict = tree
                # sql result are flattened dict
                # and we have everything we need with just relationship
                # RELATIONSHIP IS LIKE ARC IN ORIENTED GRAPH
                # Stations.ID | Stations.Name | Station.stationTypes.ID |
                #     1       |    Toto       |         12              |
                #     1       |    Toto       |         13              |
                #
                # return {
                #         'ID' : 1,
                #         'Name' : 'Toto',
                #         'stationType' : [
                #                          {'ID' : 12 },
                #                          {'ID': 13}
                #                         ]
                #         }

                alias = self.addDictsSchemaAndColumnsAlliased(model=targetClass, prefix=curPrefix, separator=separator)
                self.__queryBuilder__['__relationshipsAdded__'].append(f'{relationshipTmp}')
                innerJoin = relation.innerjoin
                curParent = parent  + [(relation.key, alias)]
                self.__query__ = self.__query__.join((alias), isouter=not(innerJoin))
                toRetTest = None
                for item in curParent:
                    if toRetTest is None:
                        toRetTest = contains_eager(item[0], alias=item[1])
                    else:
                        toRetTest = toRetTest.contains_eager(item[0], alias=item[1])

                self.__query__ = self.__query__.options(toRetTest)
                # print(f'{self.__query__.statement.compile(compile_kwargs={"literal_binds": True })}')

                self.exploreTreeAndApply(
                    startingModel=targetClass,
                    prefix=curPrefix,
                    separator=separator,
                    parent=curParent
                    )


    def _setDefaultParams(self):
        '''
        Will add a default pagination parameters for querybuilder
        and everything we will need for every MetaCollectionRessource and child
        '''
        toRet = {}
        toRet.update(self.handlePagination())
        return toRet

    @parser.use_args(defaultParams)
    def handlePagination(self, args):
        return args

    def getParamsForContext(self):
        return self.paramsForContext

    def setParamsForContext(self, params):
        self.paramsForContext = params



    def buildCollectionsFrom(self, distinct=False):
        '''
        (1)  FROM : The FROM phase identifies the query’s source tables and processes table operators.
        Each table operator applies a series of sub phases.
        For example, the phases involved in a join are (1-J1) Cartesian product, (1-J2) ON Filter, (1-J3) Add Outer Rows.
        The FROM phase generates virtual table VT1.
        '''
        query = self.initQuery()

        query = self.applyAllRelationship(query=query)

        query = self.returnAllFilters(
            query=query,
            listFilters=[ (self.__queryBuilder__['__pathAlias__'].get('Station.stationTypes').Name == 'Standard')]
            # listFilters=[and_(
            #     (self.__queryBuilder__['__pathAlias__'].get('Station').ID == 1),
            #     (self.__queryBuilder__['__pathAlias__'].get('Station.stationTypes').Name == 'Standard')
            #     )]
        )
        query = self.returnAllGroupsBy(
            query=query,
            listGroupsBy=[]
        )
        query = self.returnAllHavings(
            query=query,
            listHavings=[]
        )
        query = self.returnAllSelects(
            query=query,
            listSelects=self.__queryBuilder__['__listCols__'],
            distinct=distinct
        )
        query = self.returnAllOrdersBy(
            query=query,
            listOrdersBy=[(asc(self.__queryBuilder__['__listCols__'][0]))]
        )
        query = self.returnPagination(
            query=query,
            limit=10000,
            offset=0
        )
        return query

    def returnAllFilters(self, query, listFilters=[]):
        for item in listFilters:
            query = query.filter(item)
        return query

    def returnAllGroupsBy(self, query, listGroupsBy=[]):
        for item in listGroupsBy:
            query = query.group_by(item)
        return query

    def returnAllOrdersBy(self, query, listOrdersBy=[]):
        for item in listOrdersBy:
            query = query.order_by(item)
        return query

    def returnAllHavings(self, query, listHavings=[]):
        for item in listHavings:
            query = query.having(item)
        return query

    def returnAllSelects(self, query, listSelects=[], distinct=False):

        if distinct:
            query = query.with_entities(listSelects[0]).distinct()
        else:
            query = query.with_entities(*listSelects)

        return query

    def returnPagination(self, query, limit=0, offset=0):
        query = query.limit(limit)
        query = query.offset(offset)
        return query

    def parseResult(self, res=None):
        toRet = {
        }
        listOfTuple = self.__serializerOutput__.get('__pathNamedtuple__')#.get('Station').get('schema')
        listOfTupleTmp = copy.deepcopy(self.__serializerOutput__.get('__pathNamedtuple__'))
        listOfUniqTuple = {}
        mappingDictUniqIndexRet = {}

        for tName in listOfTuple:
            listOfUniqTuple[tName] = deque()
            mappingDictUniqIndexRet[tName] = {}
        for line in res:
            ## si tout est ordonné on peut optimiser et  tout faire en même temps
            ## création insertion 
            ## couper les explorations profondes inutiles si un noeud est parent est null ???
            newMess = ()
            newM = False
            for item in listOfTuple:
                listOfTupleTmp[item] = None  # assert we loop other all member of list
                tmpObj = listOfTuple.get(item)()
                newDict = {}
                for i in range(len(tmpObj)):
                    key = tmpObj._fields[i]
                    newDict[key] = getattr(line, f'{item}.{key}', [])

                tmpNamedTuple = listOfTuple.get(item)(**newDict)
                # trueTuple = tuple(tmpNamedTuple)
                trueTuple = tmpNamedTuple
                idMessStored = None
                if not(trueTuple.count(None) == len(trueTuple)):
                    if trueTuple not in listOfUniqTuple.get(item):
                        listOfUniqTuple[item].append(trueTuple)
                        idMessStored = len(listOfUniqTuple[item]) - 1
                        newM = True

                    else:
                        idMessStored = listOfUniqTuple.get(item).index(trueTuple)
                newMess = newMess + (idMessStored,)
                listOfTupleTmp[item] = tmpNamedTuple

            if newM:
                cursor = toRet
                for index, item in enumerate(listOfTuple):
                    indexUniqTuple = newMess[index]
                    if indexUniqTuple is not None:
                        messTmp = listOfUniqTuple.get(item)[indexUniqTuple]

                        contextPath = item.split('.')
                        pathItem = contextPath[-1]
                        indexInRet = None
                        if cursor.get(pathItem) == None:
                            cursor[pathItem] = []
                            cursor[pathItem].append(messTmp._asdict())
                            indexInRet = len(cursor.get(pathItem)) - 1
                            mappingDictUniqIndexRet[item].update({ indexUniqTuple : indexInRet })

                        if len(cursor.get(pathItem)) <= indexUniqTuple:
                            cursor[pathItem].append(messTmp._asdict())
                            indexInRet = len(cursor.get(pathItem)) - 1
                            mappingDictUniqIndexRet[item].update({ indexUniqTuple : indexInRet })

                        if indexInRet is None:
                            indexInRet = mappingDictUniqIndexRet[item].get(indexUniqTuple)
                        try :
                            cursor = cursor.get(pathItem)[indexInRet]
                        except Exception as e:
                            print(f'qs')

        return toRet

    def retrieve(self):
        query = self.buildCollectionsFrom(distinct=False)
        print(f'{query.statement.compile(compile_kwargs={"literal_binds": True })}')
        res = query.all()

        toRet = []
        toRet = self.parseResult(res=res)
        return toRet

        # print(f'{query.statement.compile(compile_kwargs={"literal_binds": True })}')
        # rawQuery = f'{query.statement.compile(compile_kwargs={"literal_binds": True })}'
        # res = self.request.dbsession.get_bind(self.__from_model__).execute(rawQuery)


    
    # def retrieve(self):

    #     def namedTupleToNestDict(headers=None, separator='.'):
    #         objectsDicts = {}

    #         for key in headers:
    #             *objects, subKey = key.split('.')
    #             objName = None
    #             if len(objects) > 1:
    #                 objName = objects[-2]
    #             else:
    #                 objName = objects[0]

    #             # merge dict if exist
    #             # create it if didn't exist
    #             mergedOrNewSchema = {
    #                 **objectsDicts.get(objName, {}),
    #                 **{subKey: None}
    #                 }

    #             objectsDicts[objName] = mergedOrNewSchema

    #         return objectsDicts

    #     def getHeaders(cursor=None):
    #         headers = []
    #         for item in cursor.description:
    #             print(f'{item}')
    #             headers.append(item[0])

    #         return headers

    #     def returnStruct():
    #         startingObj = self.__serializerOutput__.get('__framestartingTable__')
    #         memStruct = self.__serializerOutput__.get('__struct__')
    #         tmpStruct = memStruct.get(startingObj)
    #         copyTmp = copy.deepcopy(tmpStruct)
    #         for key, value in tmpStruct.items():
    #             if isinstance(value, list):
    #                 copyTmp[key] = [memStruct.get(value[0])]
            
    #         return {startingObj: [copyTmp]}

    #     query = self.buildCollectionsFrom()
    #     print(f'{query.statement.compile(compile_kwargs={"literal_binds": True })}')
    #     rawQuery = f'{query.statement.compile(compile_kwargs={"literal_binds": True })}'
    #     res = self.request.dbsession.get_bind(self.__from_model__).execute(rawQuery)

    #     plm = returnStruct()

    #     headers = getHeaders(cursor=res.cursor)
    #     structNeed = namedTupleToNestDict(headers=headers, separator='.')
    #     tmpres = res.fetchall()

    #     def parseResult(self, res=None,structToRet=None):
    #         toRet = {}
    #         listOfObjects = self.__serializerOutput__.get('__struct__')
    #         listOfTuple = self.__serializerOutput__.get('__namedTupleCollections__')#.get('Station').get('schema')
    #         startingNode = self.__serializerOutput__.get('__frameorder__')[0]
    #         toRet [startingNode.get('node')] = []
    #         listOfTupleTmp = copy.deepcopy(self.__serializerOutput__.get('__namedTupleCollections__'))
    #         listOfUniqTuple = {}

    #         for tName in listOfTuple:
    #             listOfUniqTuple[tName] = deque()

    #         for line in res:
    #             newMess = ()
    #             newM = False
    #             for item in listOfTuple:
    #                 listOfTupleTmp[item] = None # assert we loop other all member of list
    #                 tmpObj = listOfTuple.get(item).get('schema')()
    #                 newDict = {}
    #                 for i in range(len(tmpObj)):
    #                     key = tmpObj._fields[i]
    #                     newDict[key] = getattr(line, f'{item}.{key}', [])

    #                 tmpNamedTuple = listOfTuple.get(item).get('schema')(**newDict)
    #                 trueTuple = tuple(tmpNamedTuple)
    #                 cursor= -1
    #                 if trueTuple not in listOfUniqTuple.get(item):
    #                     listOfUniqTuple[item].append(trueTuple)
    #                     cursor = len(listOfUniqTuple[item]) - 1
    #                     newM = True
                        
    #                 else:
    #                     cursor = listOfUniqTuple.get(item).index(trueTuple)
    #                 newMess = newMess + (cursor,)
    #                 listOfTupleTmp[item] = tmpNamedTuple
    #                 print('la on est kéblo :( :( :( :( ')
                
    #             if newM:
    #                 print("youhou nouveau atom ajouter")
    #             # for row in toRet[startingNode.get('node')]:

    #             for leaf in startingNode.get('leafs'):
    #                 print(leaf)
    #                 print("")
    #             print(line)

    #         return toRet

    #     resp = parseResult(self=self, res=tmpres,structToRet=plm)

    #     test = self.__serializerOutput__
    #     result = {
    #         'Station': []
    #     }
    #     for line in tmpres:
    #         # Namedtuple
    #         # collections
    #         # set
    #         # uniq
    #         # data structure
    #         tmSerial = copy.deepcopy(test)
    #         for key, value in test.items():
    #             prefix = key
    #             if isinstance(value, dict):
    #                 for subKey, subValue in value.items():
    #                     if isinstance(subValue, tuple):
    #                         tmSerial[prefix][subKey] = getattr(line, f'{prefix}.{subKey}')
    #         # from here all item in row is parsed
    #         # we switch to manipulate dict
    #         # for instanciate namedTuple
    #         # in order to build a uniq list of namedTuple as recompose item in row
    #         namedtupleC = test.get('__namedTupleCollections__')
    #         for objName in namedtupleC:
    #             tmpTuple = namedtupleC.get(objName).get('schema')(**tmSerial.get(objName))
    #             listToTest = namedtupleC.get(objName).get('instCollections')
    #             if objName == 'Station':
    #                 if tmpTuple not in result.get('Station'):
    #                     result.get('Station').append(tmpTuple)
    #             if tmpTuple not in listToTest:
    #                 listToTest.append(tmpTuple)

            

    #         # orderList = test.get('__frameorder__')
    #         # result = {}

    #         # for obj in orderList:
    #         #     #todo iterate over frameorder an recompose objets
    #         #     #then merge it
    #         #     #or maybe we can do it in row??????????
    #         #     tmpDict = tmSerial.get(obj.get('node'))
    #         #     for leaf in obj.get('leafs'):
    #         #         tmpSubDict = tmpDict.get(leaf.node)
    #         #         curList = tmpDict.get(leaf.key,None)
    #         #         if curList == None:
    #         #             tmpDict[leaf.key] = []
    #         #             tmpDict[leaf.key].append(tmpSubDict)
    #         #         else:
    #         #             mergedOrNewSchema = {
    #         #                 **result.get(obj.get('node'), []),
    #         #                 **tmpDict
    #         #                 }
    #         #     result[obj].append(tmpDict)

    #         # result[test['__framestartingTable__']] = tmSerial.get(test['__framestartingTable__'])


    #     result = [dict(zip(headers, line)) for line in tmpres]

    #     a = namedTupleToNestDict(
    #             headers=res[0].headers._real_fields,
    #             separator='.'
    #         )
    #     for item in res:
    #         pass

    #     toRet = []

    #     def getListOfObject(listRealField=[]):
    #         toRet = []
    #         structureObj = {}
    #         mappingObj = {}
    #         for item in listRealField:
    #             if '.' in item:
    #                 newObjKey = item.split('.')[0]
    #                 structureObj.update({
    #                     newObjKey: structureObj.get(newObjKey, [])
    #                 })
    #                 mappingObj.update({
    #                     newObjKey: mappingObj.get(newObjKey, [])
    #                 })
    #                 newObjAttributes = item.split('.')[1]
    #                 flagDict = structureObj.get(newObjKey, None)
    #                 if flagDict:
    #                     structureObj.get(newObjKey).update({
    #                             newObjAttributes: structureObj[newObjKey].get(newObjAttributes, None)
    #                     })
    #                     mappingObj.get(newObjKey).update({
    #                             newObjAttributes: item
    #                     })
    #                 else:
    #                     structureObj.update({
    #                             newObjKey: {
    #                                 newObjAttributes: None
    #                             }
    #                     })
    #                     mappingObj.update({
    #                             newObjKey: {
    #                                 newObjAttributes: item
    #                             }
    #                     })
    #             else:
    #                 structureObj[item] = None
    #                 mappingObj[item] = item
    #         return structureObj,mappingObj

    #     structureobj,mappingobj = getListOfObject(res[0]._real_fields)
    #     self.__from_model__

    #     def nest_dict(dict1): 
    #         result = {} 
    #         for k, v in dict1.items(): 
                
    #             # for each key call method split_rec which 
    #             # will split keys to form recursively  
    #             # nested dictionary 
    #             split_rec(k, v, '.', result) 
    #         return result 
  
    #     def split_rec(k, v, separator, out): 
            
    #         # splitting keys in dict 
    #         # calling_recursively to break items on separator
    #         k, *rest = k.split(separator, 1) 
    #         if rest: 
    #             split_rec(rest[0], v, separator, out.setdefault(k, {})) 
    #         else: 
    #             out[k] = v 

    #     # super_dict = collections.defaultdict(set)

    #     # for d in res:
    #     #     curD = d._asdict()
    #     #     a = flatdict.FlatDict(value=curD, delimiter='.')
    #     #     fD = a.as_dict()
    #     #     for k, v in fD.items():  # d.items() in Python 3+
    #     #         super_dict[k].add(v)

    #     # output all dict items, and sort them by key
    #     dicts_ele = sorted( ( item for d in res for item in d.items() ), key = lambda x: x.as_dict() )
    #     # groups items by key
    #     ele_groups = itertools.groupby( dicts_ele, key = lambda x: x[0] )
    #     # iterates over groups and get item value
    #     merged = { k: set( v[1] for v in grouped ) for k, grouped in ele_groups }

    #     newRet = {}
    #     for item in res:
    #         flatDict = item._asdict()
    #         a = flatdict.FlatDict(value=flatDict, delimiter='.')
    #         print(f'{str(nest_dict(flatDict))}')
    #         tmpIt = {
    #             a.get('ID'): a.as_dict()
    #         }
    #         newRet = always_merger.merge(tmpIt, newRet.get(a.get('ID'),{}))

    #     for item in toRet:
            
    #         print('l')
    #         pass
    #     return toRet
    
    
    
    
    # def retrieve(self):
    #     toRet = []
    #     listCols = []

        

    #     test = self.buildCollectionsFrom()
    #     print(f'{test.statement.compile(compile_kwargs={"literal_binds": True })}')

    #     for item in self.__from_model__.__table__.columns:
    #         listCols.append(item)
    #     for model in self.__with_models__:
    #         for item in model.__table__.columns:
    #             listCols.append(item.label(f'{item.table.name}.{item.name}'))
    #     #Station is for test query building
    #     #Relationship should be in the model class
    #     #Station = self.__model__


    #     filterQuery = self.request.dbsession.query(self.__from_model__)

    #     inspectedSource = inspect(self.__from_model__)
    #     allRelationships = inspectedSource.relationships

    #     for relation in allRelationships:
    #         target = relation.target
    #         relationColumn = getattr(self.__from_model__, relation.key)
    #         innerJoin = relation.innerjoin
    #         filterQuery = filterQuery.join(target, relationColumn, isouter=not(innerJoin))
    #         filterQuery = filterQuery.options(contains_eager(relationColumn))

    #     filterQuery = filterQuery.filter(StationType.Name=='Standard')

    #     filterQuery   = filterQuery.order_by(asc(Station.StationDate))
    #     filterQuery   = filterQuery.with_entities(*listCols)

    #     query   = self.request.dbsession.query(self.__from_model__)

    #     inspectedSource = inspect(self.__from_model__)
    #     allRelationships = inspectedSource.relationships

    #     for relation in allRelationships:
    #         target = relation.target
    #         relationColumn = getattr(self.__from_model__, relation.key)
    #         innerJoin = relation.innerjoin
    #         query = query.join(target, relationColumn, isouter=not(innerJoin))
    #         query = query.options(contains_eager(relationColumn))

    #     query = query.filter(StationType.Name=='Standard')

    #     query   = query.order_by(asc(Station.StationDate))
    #     query   = query.with_entities(*listCols) # Be careful with with_entities, this function could redefine the entire query
    #     query   = query.limit(1000)
    #     query   = query.offset(10000)

    #     print(f'{query.statement.compile(compile_kwargs={"literal_binds": True })}')
    #     # res = self.request.dbsession.execute(query.with_labels().statement).fetchall()
    #     res     = query.all()

    #     toRet = []
    #     for item in res:
    #         toRet.append(item._asdict())
    #     return toRet



    # def retrieve(self):
    #     toRet = []
    #     listCols = []
    #     for item in self.__from_model__.__table__.columns:
    #         listCols.append(item)
    #     for model in self.__with_model__:
    #         for item in model.__table__.columns:
    #             listCols.append(item.label(f'{item.table.name}.{item.name}'))
    #     #Station is for test query building
    #     #Relationship should be in the model class
    #     #Station = self.__model__
    #     query   = self.request.dbsession.query(Station)

    #     inspectedSource = inspect(Station)
    #     allRelationships = inspectedSource.relationships

    #     for relation in allRelationships:
    #         target = relation.target
    #         relationColumn = getattr(Station, relation.key)
    #         innerJoin = relation.innerjoin
    #         query = query.join(target, relationColumn, isouter=not(innerJoin))
    #         # query = query.options(joinedload(relationColumn, innerjoin=innerJoin))
    #         query = query.options(contains_eager(relationColumn))

    #     # query   = self.request.dbsession.query(Station)
    #     # query   = query.join(StationType, Station.stationType)
    #     # query   = query.options(contains_eager(Station.stationType))
    #     # query   = query.join(Observation, Station.observations)
    #     # query   = query.options(contains_eager(Station.observations))

    #     query = query.filter(StationType.Name=='Standard')
    #     query   = query.order_by(asc(Station.StationDate))
    #     query   = query.with_entities(*listCols) # Be careful with with_entities, this function could redefine the entire query
    #     # query = query.options(joinedload(self.__with_model__[0]))
    #     # query = query.with_entities(*listCols)
    #     # query   = applyFilters(query,args)
    #     # query   = query.order_by(asc(ArgosGps.pk_id))
    #     # query   = query.group_by(ArgosGps.ptt)
    #     query   = query.limit(1000)
    #     query   = query.offset(10000)

    #     print(f'{query.statement.compile(compile_kwargs={"literal_binds": True })}')
    #     # res = self.request.dbsession.execute(query.with_labels().statement).fetchall()
    #     res     = query.all()

    #     toRet = []
    #     for item in res:
    #         toRet.append(item._asdict())
    #     return toRet


 # def returnAllRelationships(self, sourceModel, listModels, dbsession):
    # def returnAllRelationships(self):
    #     '''
    #     first need to joined all relationships found in sourceModel
    #     if their name are in the list
    #     then for each model of the list same????
    #     '''
    #     def targetTableInList(target=None, listMapper=[], relationClass=None, sourceModel=None):
    #         # if next((x for x in listMapper if x.persist_selectable == target), False)
    #         toRet = False
    #         if relationClass == sourceModel:
    #             "we did not handle selffish relationship for now"
    #             return False
    #         for item in listMapper:
    #             if item.persist_selectable == target:
    #                 toRet = True
    #                 break
    #         return toRet

    #     def applyAllRelationship(query=None, sourceModel=None, inspectedList=[]):
    #         inspectedSource = inspect(sourceModel)
    #         allRelationship = inspectedSource.relationships
    #         tableName = inspectedSource.persist_selectable.name
    #         subDict = {}
    #         fields = []
    #         for key in inspectedSource.c:
    #             subDict[key.name] = () #set tuple for detecting None true value
    #             fields.append(key.name)


    #         mergedOrNewSchema = {
    #                 **self.__serializerOutput__['__struct__'].get(tableName, {}),
    #                 **subDict
    #                 }
    #         mergedOrNewSchema2 = {
    #                 **self.__serializerOutput__['__namedTupleCollections__'].get(tableName , {}),
    #                 **{
    #                     'dictSchema': subDict,
    #                     'schema': None,
    #                     'instCollections': []
    #                 }
    #         }
    #         self.__serializerOutput__[tableName] = mergedOrNewSchema
    #         self.__serializerOutput__['__struct__'][tableName] = mergedOrNewSchema
    #         self.__serializerOutput__['__namedTupleCollections__'][tableName] = mergedOrNewSchema2
    #         self.__serializerOutput__['__namedTupleCollections__'][tableName]['schema'] = namedtuple(tableName, fields, defaults=([],) * len(fields))  # mergedOrNewSchema2
    #         print(f'Table :{inspectedSource.persist_selectable.name}')
    #         tmpOrder = {
    #             'node': tableName,
    #             'leafs': []
    #             }
    #         for relation in allRelationship:
    #             targetTable = relation.target
    #             relationClass = relation.entity.class_
    #             if targetTableInList(
    #                 target=targetTable,
    #                 listMapper=inspectedList,
    #                 relationClass=relationClass,
    #                 sourceModel=sourceModel
    #             ):
    #                 # very important when modeling
    #                 # directly affect LEFT JOIN
    #                 print(f'will contain Table {targetTable.name} in key {targetTable.key}')

    #                 targetTableName = targetTable.name
    #                 relationshipName = relation.key
    #                 tmpOrder['leafs'].append({
    #                     'key': relationshipName,
    #                     'node': targetTableName
    #                 })
    #                 subDict = {relationshipName: [targetTableName]}
    #                 mergedOrNewSchema = {
    #                     ** self.__serializerOutput__['__struct__'].get(tableName, {}),
    #                     **subDict
    #                 }
    #                 # fields.append(relationshipName)
    #                 # subDict2 = {relationshipName: []}
    #                 # fields.append(relationshipName)
    #                 # mergedOrNewSchema2 = {
    #                 #         **self.__serializerOutput__['__namedTupleCollections__'][tableName].get('schema' , {}),
    #                 #         **subDict2
    #                 # }
    #                 # self.__serializerOutput__['__namedTupleCollections__'][tableName]['schema'] = namedtuple(tableName, fields, defaults=([],) * len(fields))  # mergedOrNewSchema2
    #                 self.__serializerOutput__['__struct__'][tableName] = mergedOrNewSchema
    #                 self.__serializerOutput__[tableName] = mergedOrNewSchema
    #                 relationColumn = getattr(sourceModel, relation.key)
    #                 innerJoin = relation.innerjoin
    #                 query = query.join(targetTable, relationColumn, isouter=not(innerJoin))
    #                 # query = query.options(contains_eager(Station.observations, relationColumn))



    #         if tmpOrder['leafs']: # should not exist ???? cross apply
    #             self.__serializerOutput__['__frameorder__'].append(tmpOrder)
    #         return query

    #     def inspectFromSource(sourceModel=None, prefix='', separator='.'):#recurcif recurcif
    #         inspectedSource = inspect(sourceModel)
    #         prefix = prefix + f'{inspectedSource.persist_selectable.name}{separator}'
    #         for item in inspectedSource.persist_selectable.columns:
    #             self.__queryBuilder__['__listCols__'].append(item.label(f'{prefix}{item.name}'))
            
    #         if prefix not in self.__queryBuilder__['__added__']:
    #             self.__queryBuilder__['__added__'].append(prefix)
    #         for item in inspectedSource.relationships:
    #             targetTable = item.target
    #             relationClass = item.entity.class_
    #             if targetTableInList(
    #                 target=targetTable,
    #                 listMapper=self.__queryBuilder__['__inspectedList__'],
    #                 relationClass=relationClass,
    #                 sourceModel=sourceModel
    #             ):
    #                 inspectFromSource(item.entity.class_,prefix=prefix,separator='.')
    #             # if item.entity.class_ in self.__with_models__ and item.entity.class_ is not sourceModel and f'{prefix}{item.mapper.persist_selectable.name}' not in self.__queryBuilder__['__added__']:
    #             #     inspectFromSource(item.entity.class_,prefix=prefix,separator='.')

    #     joinModelsQuery = self.request.dbsession.query(self.__from_model__)

       
    #     #DO IT ONCE
    #     inspectedSource = inspect(self.__from_model__)
    #     for item in self.__with_models__:
    #         tmpInspected = inspect(item)
    #         self.__queryBuilder__['__inspectedList__'].append(tmpInspected)

    #     self.__serializerOutput__['__framestartingTable__'] = inspectedSource.persist_selectable.name
    #     inspectFromSource(sourceModel=self.__from_model__)
    #     for model in [self.__from_model__] + self.__with_models__:
    #         joinModelsQuery = applyAllRelationship(
    #             query=joinModelsQuery,
    #             sourceModel=model,
    #             inspectedList=self.__queryBuilder__['__inspectedList__']
    #         )


    #     return joinModelsQuery

class MetaItemRessource (MetaCollectionRessource):
    pass



class MetaEndPointNotREST (MetaRootRessource):
    pass
