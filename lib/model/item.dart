
class Item {
  String id;
  String name;
  String nickName;
  String description;
  double costPrice;
  String markedPrice;
  double totalStock = 0.0;
  String lastStockEntry;
  int used = 0;
  Map units;

  Item({
    required this.id,
    required this.name,
    required this.nickName,
    required this.description,
    required this.costPrice,
    required this.markedPrice,
    required this.totalStock,
    required this.lastStockEntry,
    required this.used,
    required this.units,
  });

  void increaseStock(double addedStock) {
    totalStock += addedStock;
  }

  void decreaseStock(double soldStock) {
    totalStock -= soldStock;
  }

  List<double> getNewCostPriceAndStock(
      double totalCostPriceOfTransaction, double noOfItemsInTransaction) {

    if (costPrice == null) {
      return [
        totalCostPriceOfTransaction / noOfItemsInTransaction,
        noOfItemsInTransaction
      ];
    }

    double currentCp = costPrice;
    double totalCurrentCpOfStocks = currentCp * totalStock;
    double totalCp = totalCurrentCpOfStocks + totalCostPriceOfTransaction;
    double totalItems = totalStock + noOfItemsInTransaction;
    double newCp = totalCp / totalItems;
    return [newCp, totalItems];
  }

  void modifyLatestStockEntry(transaction, double newNoOfItemsInTransaction,
      double newTotalCostPriceOfTransaction) {

    assert(transaction.type == 1);
    // Retrieve old cp and totalStock before faulty transaction
    double oldTransactionItems = transaction.items;
    double oldTransactionCostPrice = transaction.amount / oldTransactionItems;
    print(
        "Got old transaction cp $oldTransactionCostPrice and items $oldTransactionItems");
    double oldTotalStock = totalStock - oldTransactionItems;
    double oldTotalCostPrice = ((costPrice * totalStock) -
        (oldTransactionItems * oldTransactionCostPrice))
        .abs();

    print(
        "Got total costprice of old $oldTotalCostPrice & items $oldTotalStock");
    // Reapply to get new cp from new updated transaction info
    double totalCp = oldTotalCostPrice + newTotalCostPriceOfTransaction;
    double totalItems = oldTotalStock + newNoOfItemsInTransaction;
    double newCp = totalCp / totalItems;
    costPrice = newCp;
    totalStock = totalItems;
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
    map['nick_name'] = nickName;
    map['description'] = description;
    map['cost_price'] = costPrice;
    map['marked_price'] = markedPrice;
    map['total_stock'] = totalStock;
    map['last_stock_entry'] = lastStockEntry;
    map['used'] = used;
    map['units'] = units;
    return map;
  }

  Item.fromMapObject(Map<String, dynamic> map) :
    id = map['id'],
    description = map['description'],
    name = map['name'],
    nickName = map['nick_name'],
    costPrice = map['cost_price'],
    markedPrice = map['marked_price'],
    totalStock = map['total_stock'],
    lastStockEntry = map['last_stock_entry'],
    used = map['used'],
    units = map['units'];

}