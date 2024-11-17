import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/model/notUsed/item.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/presentation/layout/inventory/cards_panel.dart';
import 'package:invman/presentation/layout/product/product_screen.dart';
import 'package:invman/presentation/responsive/responsive.dart';
import 'package:invman/presentation/widgets/button.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:realm/realm.dart';
import '../../../bloc/app_cubit.dart';
import '../../../bloc/app_states.dart';
import '../../../functions/navigation.dart';
import 'package:invman/presentation/layout/inventory/product_card.dart';
import 'client_bottom_sheet.dart';
import 'pos_payment_screen.dart';

class POSScreen extends StatefulWidget {
  POSScreen(this.isPOS, {Key? key}) : super(key: key);

  bool isPOS;
  @override
  _POSScreenState createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

//         final test = cubit.realmServices.realm.find<Product>(ObjectId.fromHexString(cubit.currentTransaction.items[0].split(',')[0].trim()));
// print(test!.name);

        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsive.isMobile(context) ? 50 : null,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                onChange: (value) {
                                  cubit.searchFilter();
                                  setState(() {
                                    cubit.searchResultsEnable = false;
                                  });
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      cubit.editingSearchController.clear();
                                      cubit.searchFilter();
                                      cubit.searchResultsEnable = true;
                                    });
                                  },
                                ),
                                textController: cubit.editingSearchController,
                                titleText: "Search",
                                hintText: "Use Product name or Product ID",
                                prefixIcon: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CardsPanel(),
                      Responsive.isTablet(context)
                          ? const SizedBox(
                              height: 10,
                            )
                          : Container(),
                      Responsive.isTablet(context)
                          ? Text(
                              cubit.searchResultsEnable &&
                                      Responsive.isTablet(context)
                                  ? ''
                                  : 'Results', // it shoud be favourits
                              style: const TextStyle(fontSize: 16),
                            )
                          : Container(),
                      cubit.searchResultsEnable && Responsive.isTablet(context)
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    10,
                                    (index) => const SizedBox(
                                          width: 200,
                                          // child: ProductCard(String product),
                                        )),
                              ),
                            )
                          : Expanded(
                              child: GridView.count(
                                  crossAxisCount:
                                      Responsive.isMobile(context) ? 2 : 3,
                                  shrinkWrap: true,
                                  childAspectRatio:
                                      Responsive.isMobile(context) ? 1.7 : 1.4,
                                  scrollDirection: Axis.vertical,
                                  children: cubit.searchResults == null
                                      ? [Container()]
                                      : cubit.searchResults!
                                          .map((e) =>
                                              ProductCard(e, cubit: cubit))
                                          .toList()),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth / 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: Colors.indigo.withOpacity(0.8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'List',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // cubit.currentTransaction.items
                                          //     .clear();
                                        });
                                      },
                                      child: const Text(
                                        'Clear',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              ),
        //                       SizedBox(
        //                         height: 300,
        //                         child: ListView.builder(
        //                             itemCount:
        //                                 cubit.currentTransaction.items.length,
        //                             padding: const EdgeInsets.symmetric(
        //                                 vertical: 16),
        //                             itemBuilder: (BuildContext context, index) {
        //                               return Dismissible(
        //                                 key: Key(
        //                                     'item ${cubit.currentTransaction.items[index]}'),
        //                                 onDismissed: (DismissDirection direction) {
        //                                   print(cubit.currentTransaction.items.length);
        //                                     cubit.currentTransaction.items
        //                                         .removeAt(index);
        //                                   print(cubit.currentTransaction.items.length);
        //                                     cubit.calculateTotal();
        //                                   setState(() {
        //                                   });
        //                                 },
        //                                 child: ListTile(
        //                                   leading: ClipRRect(
        //                                     borderRadius:
        //                                         BorderRadius.circular(20),
        //                                     child:  cubit
        //     .realmServices.realm
        //     .find<Product>(ObjectId
        //     .fromHexString(cubit
        //     .currentTransaction
        //     .items[index]
        //     .split(',')[0]
        //     .trim()))!
        //     .imageUrl ==
        // null ? Image.asset(AssetsManager.defaultProduct,width: screenWidth/15, height: screenWidth/15, fit: BoxFit.cover):
        //                                       CachedNetworkImage(
        //                                       height: screenWidth / 20,
        //                                       width: screenWidth / 20,
        //                                       fit: BoxFit.cover,
        //                                       imageUrl: cubit
        //                                                   .realmServices.realm
        //                                                   .find<Product>(ObjectId
        //                                                       .fromHexString(cubit
        //                                                           .currentTransaction
        //                                                           .items[index]
        //                                                           .split(',')[0]
        //                                                           .trim()))!
        //                                                   .imageUrl ==
        //                                               null
        //                                           ? 'https://cdn3.vectorstock.com/i/1000x1000/03/27/cartoon-cardboard-box-vector-29560327.jpg'
        //                                           : 'https://${cubit.realmServices.realm.find<Product>(ObjectId.fromHexString(cubit.currentTransaction.items[index].split(',')[0].trim()))!.imageUrl}',
        //                                       placeholder: (context, url) =>
        //                                           const CircularProgressIndicator(),
        //                                       errorWidget: (context, url,
        //                                               error) =>
        //                                           Image.asset(
        //                                               AssetsManager
        //                                                   .defaultProduct,
        //                                               width: screenWidth / 15,
        //                                               height: screenWidth / 15,
        //                                               fit: BoxFit.cover),
        //                                     ),
        //                                   ),
        //                                   title: Text(
        //                                     cubit.realmServices.realm
        //                                         .find<Product>(
        //                                             ObjectId.fromHexString(cubit
        //                                                 .currentTransaction
        //                                                 .items[index]
        //                                                 .split(',')[0]
        //                                                 .trim()))!
        //                                         .name,
        //                                     style: const TextStyle(
        //                                         color: Colors.white,
        //                                         fontSize: 18),
        //                                   ),
        //                                   subtitle: Text(
        //                                     cubit.realmServices.realm
        //                                             .find<Product>(ObjectId
        //                                                 .fromHexString(cubit
        //                                                     .currentTransaction
        //                                                     .items[index]
        //                                                     .split(',')[0]
        //                                                     .trim()))!
        //                                             .category ??
        //                                         'General',
        //                                     style: const TextStyle(
        //                                         color: Colors.grey),
        //                                   ),
        //                                   trailing: SizedBox(
        //                                     width: 120,
        //                                     child: SingleChildScrollView(
        //                                           scrollDirection: Axis.horizontal,
        //                                       child: Row(
        //                                         children: [
        //                                            Text(cubit.currentTransaction.items[index].split(',')[1]),
        //                                           IconButton(onPressed: (){
        //                                              final String id =  cubit.currentTransaction.items[index].split(',')[0];
        //                                              final String count =  cubit.currentTransaction.items[index].split(',')[1];
        //                                              final double total = double.parse(count) + 1;
        //
        //                                             cubit.currentTransaction.items[index] = id + ',' + total.toString();
        //                                             cubit.calculateTotal();
        //                                             cubit.setState();
        //                                           }, icon: const Icon(Icons.add)),
        //
        //                                           Text(
        //                                             cubit.realmServices.realm
        //                                                 .find<Product>(
        //                                                     ObjectId.fromHexString(cubit
        //                                                         .currentTransaction
        //                                                         .items[index]
        //                                                         .split(',')[0]
        //                                                         .trim()))!
        //                                                 .price
        //                                                 .toString(),
        //                                             style: const TextStyle(
        //                                                 color: Colors.white),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               );
        //                             }),
        //                       ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.indigo.withOpacity(0.8),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage(AssetsManager.pic),
                            ),
                            title: const Text(
                              'Ahmed khaled',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            subtitle: const Text(
                              "new customer",
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  showBottomSheetWidget(
                                      context, BottomSheetClient(),
                                      height: 0.8);
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        Card(
                          color: Colors.indigo.withOpacity(0.8),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:  [
                                    Text(
                                      "subtotal",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    // Text(
                                    // cubit.currentTransaction.total.toString(),
                                    //   style: TextStyle(color: Colors.white),
                                    // ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text(
                                      "discount",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "0%",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "total",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    // Text(
                                    //   cubit.currentTransaction.total.toString(),
                                    //   style: TextStyle(color: Colors.white),
                                    // ),
                                  ],
                                ),
                                // ButtonWidget(
                                //   onPressed: () {
                                //     if(!widget.isPOS){
                                //       cubit.currentTransaction.items.forEach((element) {
                                //         final Product? product = cubit.realmServices.realm.find<Product>(ObjectId.fromHexString(element.split(',')[0].trim()));
                                //         cubit.realmServices.realm.write(() {
                                //         product?.totalStock = product.totalStock + double.parse(element.split(',')[1].trim());
                                //         });
                                //       });
                                //       cubit.realmServices.createTransaction(
                                //       time: DateTime.now(),
                                //       type: "IN",
                                //       billedTo: 'Ahmed Khaled',
                                //       channel: 'Ahmed Khaled',
                                //       items: cubit.currentTransaction.items,
                                //       total: cubit.currentTransaction.total);
                                //
                                //       cubit.currentTransaction.items.clear();
                                //       cubit.currentTransaction.total = 0;
                                //       cubit.setState();
                                //       return;
                                //      }
                                //     navigateTo(context, PosPaymentScreen(widget.isPOS));
                                //   },
                                //   child: const Text('confirm'),
                                //   color: Colors.orange,
                                // ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
