import 'package:realm/realm.dart';
// part 'transaction.g.dart';

@RealmModel()

class _TransactionItem{
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  @MapTo('owner_id')
  late String? ownerId;

  late DateTime time;
  late String type;
  late String billedTo;
  late List<String> items;
  late String channel;
  late double total;


}