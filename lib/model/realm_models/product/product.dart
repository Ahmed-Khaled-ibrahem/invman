import 'package:realm/realm.dart';
part 'product.g.dart';

@RealmModel()

class _Product{
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  @MapTo('owner_id')
  late String? ownerId;

  late String name;
  String? description;
  late double cost;
  late double price;
  late double totalStock;
  late double? discount;
  late double? profitMargin;
  String? unit;
  String? category;
  String? brand;
  String? imageUrl;
  String? barcode;
  bool active = true;
  double? minQty;
  DateTime? expireDate;


  void increaseStock(double addedStock) {
    totalStock += addedStock;
  }

  void decreaseStock(double soldStock) {
    totalStock -= soldStock;
  }

  List<double> getNewCostPriceAndStock(double totalCostPriceOfTransaction, double noOfItemsInTransaction) {

    if (cost == null) {
      return [
        totalCostPriceOfTransaction / noOfItemsInTransaction,
        noOfItemsInTransaction
      ];
    }

    double currentCp = cost;
    double totalCurrentCpOfStocks = currentCp * totalStock;
    double totalCp = totalCurrentCpOfStocks + totalCostPriceOfTransaction;
    double totalItems = totalStock + noOfItemsInTransaction;
    double newCp = totalCp / totalItems;
    return [newCp, totalItems];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['cost'] = cost;
    map['price'] = price;
    map['total_stock'] = totalStock;
    map['unit'] = unit;
    map['category'] = category;
    map['brand'] = brand;
    map['imageUrl'] = imageUrl;
    map['barcode'] = barcode;
    return map;
  }


}