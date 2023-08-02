
import 'item.dart';

class ItemTransaction {
  String id;
  int type;
  String createdBy;
  List<Item> items;
  late DateTime createdAt;


  ItemTransaction(
  {
    required this.id,
    required this.type,
    required this.createdBy,
    required this.items,
  }
  ){createdAt = DateTime.now();}


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
    map['type'] = type;
    map['items'] = items;
    map['createdBy'] = createdBy;
    map['createdAt'] = createdAt;
    return map;
  }

  ItemTransaction.fromMapObject(Map<String, dynamic> map) :
        id = map['id'],
        type = map['type'],
        items = map['items'],
        createdAt = map['createdAt'],
        createdBy = map['createdBy'];
}