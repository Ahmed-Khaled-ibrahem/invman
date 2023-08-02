import 'package:invman/model/const/random_data_gen.dart';
import 'package:invman/model/item.dart';
import 'package:collection/collection.dart';

class InvBrain{

  late List<Item> itemsList;
  late Map<String,dynamic> itemsTree;  // string key is the categoury general-washing neasted

  InvBrain(){
    // read inventroy data

    itemsList = [item1,item2, item3, item4, item5, item6];
    itemsTree = groupItemsByCategory(itemsList);
  }

  Map<String, List<Item>> groupItemsByCategory(List<Item> items) {
    return groupBy(items, (Item item) {
      List<String> categoryLevels = item.category.split('-');
      return categoryLevels.first;
    });
  }


  void printItemsTree( Map<String, dynamic> itemsByCategory, {String indent = ''}) {

    itemsByCategory.forEach((category, categoryItems) {
      print('Category: $category');
      categoryItems.forEach((item) {
        print('Item: ${item.name}');
      });
      print('-----');
    });
  }





}