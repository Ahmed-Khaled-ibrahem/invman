
class ItemTransaction {
  String id;
  int type;
  double amount;
  double costPrice;
  double dueAmount;
  String itemId;
  double items;
  String date;
  String description;
  int createdAt;
  String signature;

  ItemTransaction(
  {
    required this.id,
    required this.type,
    required this.amount,
    required this.itemId,
    required this.costPrice,
    required this.items,
    required this.date,
    required this.description,
    required this.dueAmount,
    required this.createdAt,
    required this.signature
  }
  );


  // static List<ItemTransaction> fromQuerySnapshot(QuerySnapshot snapshot) {
  //   List<ItemTransaction> transactions = List<ItemTransaction>();
  //   snapshot.documents.forEach((DocumentSnapshot doc) {
  //     ItemTransaction transaction = ItemTransaction.fromMapObject(doc.data);
  //     transaction.id = doc.documentID;
  //     transactions.add(transaction);
  //   });
  //   transactions.sort((a, b) {
  //     return b.createdAt.compareTo(a.createdAt);
  //   });
  //   return transactions;
  // }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['item_id'] = itemId;
    map['type'] = type;
    map['description'] = description;
    map['due_amount'] = dueAmount;
    map['date'] = date;
    map['amount'] = amount;
    map['items'] = items;
    map['cost_price'] = costPrice;
    map['created_at'] = createdAt;
    map['signature'] = signature;
    return map;
  }

  ItemTransaction.fromMapObject(Map<String, dynamic> map) :
    id = map['id'],
    type = map['type'],
    description = map['description'],
    dueAmount = map['due_amount'],
    itemId = map['item_id'],
    date = map['date'],
    amount = map['amount'],
    costPrice = map['cost_price'],
    items = map['items'],
    createdAt = map['created_at'],
    signature = map['signature'];

}