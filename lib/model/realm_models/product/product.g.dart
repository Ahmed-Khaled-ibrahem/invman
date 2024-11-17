// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Product extends _Product with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Product(
    ObjectId id,
    String name,
    double cost,
    double price,
    double totalStock, {
    String? ownerId,
    String? description,
    double? discount,
    double? profitMargin,
    String? unit,
    String? category,
    String? brand,
    String? imageUrl,
    String? barcode,
    bool active = true,
    double? minQty,
    DateTime? expireDate,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Product>({
        'active': true,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'cost', cost);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'totalStock', totalStock);
    RealmObjectBase.set(this, 'discount', discount);
    RealmObjectBase.set(this, 'profitMargin', profitMargin);
    RealmObjectBase.set(this, 'unit', unit);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'barcode', barcode);
    RealmObjectBase.set(this, 'active', active);
    RealmObjectBase.set(this, 'minQty', minQty);
    RealmObjectBase.set(this, 'expireDate', expireDate);
  }

  Product._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get ownerId =>
      RealmObjectBase.get<String>(this, 'owner_id') as String?;
  @override
  set ownerId(String? value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  double get cost => RealmObjectBase.get<double>(this, 'cost') as double;
  @override
  set cost(double value) => RealmObjectBase.set(this, 'cost', value);

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObjectBase.set(this, 'price', value);

  @override
  double get totalStock =>
      RealmObjectBase.get<double>(this, 'totalStock') as double;
  @override
  set totalStock(double value) =>
      RealmObjectBase.set(this, 'totalStock', value);

  @override
  double? get discount =>
      RealmObjectBase.get<double>(this, 'discount') as double?;
  @override
  set discount(double? value) => RealmObjectBase.set(this, 'discount', value);

  @override
  double? get profitMargin =>
      RealmObjectBase.get<double>(this, 'profitMargin') as double?;
  @override
  set profitMargin(double? value) =>
      RealmObjectBase.set(this, 'profitMargin', value);

  @override
  String? get unit => RealmObjectBase.get<String>(this, 'unit') as String?;
  @override
  set unit(String? value) => RealmObjectBase.set(this, 'unit', value);

  @override
  String? get category =>
      RealmObjectBase.get<String>(this, 'category') as String?;
  @override
  set category(String? value) => RealmObjectBase.set(this, 'category', value);

  @override
  String? get brand => RealmObjectBase.get<String>(this, 'brand') as String?;
  @override
  set brand(String? value) => RealmObjectBase.set(this, 'brand', value);

  @override
  String? get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String?;
  @override
  set imageUrl(String? value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String? get barcode =>
      RealmObjectBase.get<String>(this, 'barcode') as String?;
  @override
  set barcode(String? value) => RealmObjectBase.set(this, 'barcode', value);

  @override
  bool get active => RealmObjectBase.get<bool>(this, 'active') as bool;
  @override
  set active(bool value) => RealmObjectBase.set(this, 'active', value);

  @override
  double? get minQty => RealmObjectBase.get<double>(this, 'minQty') as double?;
  @override
  set minQty(double? value) => RealmObjectBase.set(this, 'minQty', value);

  @override
  DateTime? get expireDate =>
      RealmObjectBase.get<DateTime>(this, 'expireDate') as DateTime?;
  @override
  set expireDate(DateTime? value) =>
      RealmObjectBase.set(this, 'expireDate', value);

  @override
  Stream<RealmObjectChanges<Product>> get changes =>
      RealmObjectBase.getChanges<Product>(this);

  @override
  Product freeze() => RealmObjectBase.freezeObject<Product>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Product._);
    return const SchemaObject(ObjectType.realmObject, Product, 'Product', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ownerId', RealmPropertyType.string,
          mapTo: 'owner_id', optional: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('cost', RealmPropertyType.double),
      SchemaProperty('price', RealmPropertyType.double),
      SchemaProperty('totalStock', RealmPropertyType.double),
      SchemaProperty('discount', RealmPropertyType.double, optional: true),
      SchemaProperty('profitMargin', RealmPropertyType.double, optional: true),
      SchemaProperty('unit', RealmPropertyType.string, optional: true),
      SchemaProperty('category', RealmPropertyType.string, optional: true),
      SchemaProperty('brand', RealmPropertyType.string, optional: true),
      SchemaProperty('imageUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('barcode', RealmPropertyType.string, optional: true),
      SchemaProperty('active', RealmPropertyType.bool),
      SchemaProperty('minQty', RealmPropertyType.double, optional: true),
      SchemaProperty('expireDate', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
