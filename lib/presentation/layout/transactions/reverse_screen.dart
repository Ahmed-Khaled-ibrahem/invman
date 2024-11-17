import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:realm/realm.dart';
import '../../../bloc/app_states.dart';
import '../../../functions/navigation.dart';
import '../../../functions/show_bottom_sheet.dart';
import '../../../model/const/assets_manager.dart';
import '../../../model/filters_model.dart';
import '../../../model/notUsed/item.dart';
import '../../../model/realm_models/product/product.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import '../inventory/cards_panel.dart';
import '../inventory/product_card.dart';
import '../pos/client_bottom_sheet.dart';
import '../pos/pos_payment_screen.dart';

class ReverseScreen extends StatefulWidget {
  const ReverseScreen({Key? key}) : super(key: key);

  @override
  _ReverseScreenState createState() => _ReverseScreenState();
}

class _ReverseScreenState extends State<ReverseScreen> {

  TextEditingController editingController = TextEditingController();

  bool searchResultsEnable = true;
  late RealmResults<Product> searchResults ;

  List<Item> products = List.generate(10, (index) => Item(id: index, name: 'name $index', cost: index*2, price: index*5)) ;

  FilterModel filterModel = FilterModel(type: 'filter', title: 'Filters', active: 'All',
      items: ['All', 'In Stock', 'Out Of Stock', 'Active', 'In Active']);

  FilterModel sortingModel = FilterModel(type: 'sort', title: 'Sorting', active: 'None',
      items: ['None', 'Price', 'Cost', 'Alphabetical', 'revenue', 'Stock']);

  FilterModel brandModel = FilterModel(type: 'brand', title: 'Brand', active: 'none',
      items: ['Nike', 'Samsung', 'Nokia', 'Oppo']);

  FilterModel categoryModel = FilterModel(type: 'category', title: 'Category', active: 'none',
      items: ['TV', 'Food', 'Drinks', 'Laptops', 'Phones']);

  List<List<dynamic>> items = [
    ["Watch",true],
  ["Jeans",true],
  ["Shirt",true],
  ["T-Shirt",true],
  ["Cup",true],
  ["Shoes",true],
  ["Cap",true],
  ];


  void filterSearchResults(String query) {
    setState(() {
      // items = duplicateItems
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: (){ FocusManager.instance.primaryFocus?.unfocus(); },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left_rounded,
                            size: 30,
                          )),
                      Text(
                        'Reverse',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        onChange: (value) {
                                          filterSearchResults(value);

                                          setState(() {
                                            searchResultsEnable = false;
                                          });
                                        },
                                        suffixIcon : IconButton(
                                          icon: Icon(Icons.cancel,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              editingController.clear();
                                              filterSearchResults('');
                                              searchResultsEnable = true;
                                            });
                                          },
                                        ),
                                        textController: editingController,
                                        titleText: "Search",
                                        hintText: "Use Product name or Product ID",
                                        prefixIcon: const Icon(Icons.search),
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardsPanel(),

                                    const SizedBox(height: 20,),
                                    Text(searchResultsEnable? 'Favourites': 'Results', style: const TextStyle(fontSize: 16),),
                                  ],
                                ),

                                searchResultsEnable? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: List.generate(10, (index) =>  const SizedBox(
                                    width: 200,
                                    // child: ProductCard(String product),
                                  )),),
                                )
                                 : SizedBox(
                                  height: 400,
                                   child: GridView.count(
                                       crossAxisCount: 3,
                                       shrinkWrap: true,
                                       childAspectRatio: 1.6,
                                       scrollDirection: Axis.vertical,
                                       children: products.map((e) =>  ProductCard(
                                           Product(ObjectId(), 'cdsv', 45, 495, 151)

                                       )).toList()
                                   ),
                                 ),

                              ],
                            ),
                          ),
                        ),

                        SingleChildScrollView(
                          child: SizedBox( width: 400,
                            child: Column(
                              children:  [
                                Card(
                                  color: Colors.blueGrey,
                                  child: SizedBox(
                                    height: 450,
                                    child: ListView.builder(
                                        itemCount: items.length,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        itemBuilder: (BuildContext context, index) {
                                          return ListTile(
                                            leading: const CircleAvatar(
                                              backgroundImage: AssetImage(AssetsManager.pic),
                                            ),
                                            title: Text(
                                              items[index][0],
                                              style:  TextStyle(
                                                decoration: items[index][1] == true? TextDecoration.none:TextDecoration.lineThrough,
                                                  color: Colors.white, fontSize: 18),
                                            ),
                                            subtitle: const Text(
                                              "2 x 5.0 LE",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            trailing: MaterialButton(
                                              color:items[index][1] == false ? Colors.green: Colors.red,
                                              onPressed: (){
                                                setState(() {
                                                  items[index][1] = !items[index][1];
                                                });
                                              },
                                              child:  Text(
                                                items[index][1] == false ? "Undo":"delete",
                                                style: const TextStyle(
                                                    color: Colors.white, fontSize: 18),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.blueGrey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              "OLD Total",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              "200.0",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              "New Total",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              "150.0",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              "charge",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              "-50.0",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),

                                        ButtonWidget(
                                          onPressed: (){navigateTo(context, PosPaymentScreen(true));}, child: const Text('confirm'), color: Colors.orange,),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
