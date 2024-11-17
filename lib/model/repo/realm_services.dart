import 'package:invman/model/realm_models/parameters/parameters.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:realm/realm.dart';

class RealmServices {
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    print('done1');

    if (app.currentUser != null || currentUser != app.currentUser) {
      print('done2');
      currentUser ??= app.currentUser;
      // realm = Realm(Configuration.flexibleSync(currentUser!, [Product.schema, Parameters.schema, TransactionItem.schema]));
      realm = Realm(Configuration.flexibleSync(currentUser!, [Product.schema, Parameters.schema]));

      // showAll = (realm.subscriptions.findByName(queryAllName) != null);
      if (realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<void> updateSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
        mutableSubscriptions.add(realm.all<Product>());
        mutableSubscriptions.add(realm.all<Parameters>());
        // mutableSubscriptions.add(realm.all<TransactionItem>());
    });
    await realm.subscriptions.waitForSynchronization();
  }


  void createItem(
  {
    required String name, required double cost, required double price, required double totalStock,
    String? category, bool? active, String? barcode, String? brand, String? description, double? discount, DateTime? expireDate
    ,String? imageUrl, double? minQty, double? profitMargin, String? unit, ObjectId? id
  })
  {
    final newItem = Product( id ?? ObjectId(),
        name, cost, price, totalStock,category: category, active: active = true,
    barcode: barcode,brand: brand,description: description,discount: discount,expireDate: expireDate,imageUrl: imageUrl,
    minQty: minQty,profitMargin: profitMargin,unit: unit);
    realm.write<Product>(() => realm.add<Product>(newItem, update: id == null ? false : true));
    // notifyListeners();
    final characters = realm.all<Product>();
    print(characters.length);
  }

  void deleteItem(Product item) {
    realm.write(() => realm.delete(item));
    // notifyListeners();
  }

  Future<void> updateItem(Product item,
      {
        name, cost, price, totalStock, category,active, barcode, brand, description,discount, expireDate, imageUrl,
        minQty,profitMargin,unit
      }) async {

    realm.write(() {
      if (name != null) { item.name = name; }
      if (cost != null) { item.cost = cost; }
      if (price != null) { item.price = price; }
      if (totalStock != null) { item.totalStock = totalStock; }
      if (category != null) { item.category = category; }
      if (active != null) { item.active = active; }
      if (barcode != null) { item.barcode = barcode; }
      if (brand != null) { item.brand = brand; }
      if (description != null) { item.description = description; }
      if (discount != null) { item.discount = discount; }
      if (expireDate != null) { item.expireDate = expireDate; }
      if (imageUrl != null) { item.imageUrl = imageUrl; }
      if (minQty != null) { item.minQty = minQty; }
      if (profitMargin != null) { item.profitMargin = profitMargin; }
      if (unit != null) { item.unit = unit; }
    });
    // notifyListeners();
  }

  void createParameters()
  {
    final newItem = Parameters(ObjectId(), categories: ['General'], brands: ['General']);
    realm.write<Parameters>(() => realm.add<Parameters>(newItem));
  }

  // void createTransaction(
  //     {
  //       required DateTime time, required String type, required String billedTo, required String channel, required double total,
  //       required List<String> items, ObjectId? id,
  //     })
  // {
  //   final newItem = TransactionItem(id ?? ObjectId(), time, type, billedTo, channel, total, items: items);
  //   realm.write<TransactionItem>(() => realm.add<TransactionItem>(newItem, update: id == null ? false : true));
  //   final characters = realm.all<TransactionItem>();
  //   print(characters.length);
  // }


}
