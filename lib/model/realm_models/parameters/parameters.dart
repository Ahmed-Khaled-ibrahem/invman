import 'package:realm/realm.dart';
part 'parameters.g.dart';

@RealmModel()

class _Parameters{
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late List<String> categories ;
  late List<String> brands ;

}