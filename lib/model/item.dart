
class Item {
  String id;
  String name;
  String? description;
  double cost;
  double price;
  double totalStock;
  String? unit;
  String category;
  String? brand;
  String? imageUrl;
  String? barcode;

  Item({
    required this.id,
    required this.name,
    this.description,
    required this.cost,
    required this.price,
    this.totalStock = 0,
    this.unit,
    this.category = "general",
    this.brand,
    this.imageUrl,
    this.barcode,
  });

  void increaseStock(double addedStock) {
    totalStock += addedStock;
  }

  void decreaseStock(double soldStock) {
    totalStock -= soldStock;
  }

  List<double> getNewCostPriceAndStock(
      double totalCostPriceOfTransaction, double noOfItemsInTransaction) {

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


  // static List<Item> fromQuerySnapshot(QuerySnapshot snapshot) {
  //   List<Item> items = List<Item>();
  //   snapshot.documents.forEach((DocumentSnapshot doc) {
  //     Item item = Item.fromMapObject(doc.data);
  //     item.id = doc.documentID;
  //     items.add(item);
  //   });
  //   items.sort((a, b) {
  //     return b.used.compareTo(a.used);
  //   });
  //   return items;
  // }

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

  Item.fromMapObject(Map<String, dynamic> map) :
        id = map['id'],
        description = map['description'],
        name = map['name'],
        cost = map['cost'],
        price = map['price'],
        totalStock = map['total_stock'],
        unit = map['unit'],
        category = map['category'],
        imageUrl = map['imageUrl'],
        barcode = map['barcode'],
        brand = map['brand'];

}