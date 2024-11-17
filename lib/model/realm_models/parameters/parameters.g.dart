// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameters.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Parameters extends _Parameters
    with RealmEntity, RealmObjectBase, RealmObject {
  Parameters(
    ObjectId id, {
    Iterable<String> categories = const [],
    Iterable<String> brands = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set<RealmList<String>>(
        this, 'categories', RealmList<String>(categories));
    RealmObjectBase.set<RealmList<String>>(
        this, 'brands', RealmList<String>(brands));
  }

  Parameters._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  RealmList<String> get categories =>
      RealmObjectBase.get<String>(this, 'categories') as RealmList<String>;
  @override
  set categories(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get brands =>
      RealmObjectBase.get<String>(this, 'brands') as RealmList<String>;
  @override
  set brands(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Parameters>> get changes =>
      RealmObjectBase.getChanges<Parameters>(this);

  @override
  Parameters freeze() => RealmObjectBase.freezeObject<Parameters>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Parameters._);
    return const SchemaObject(
        ObjectType.realmObject, Parameters, 'Parameters', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('categories', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('brands', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
