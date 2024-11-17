import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/presentation/widgets/button.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:realm/realm.dart';

class PosPaymentScreen extends StatefulWidget {
  PosPaymentScreen(this.isPOS, {Key? key}) : super(key: key);

  bool isPOS;
  @override
  _PosPaymentScreenState createState() => _PosPaymentScreenState();
}

class _PosPaymentScreenState extends State<PosPaymentScreen> {
  TextEditingController cashPartController = TextEditingController();
  TextEditingController cardPartController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController receiptNumberController = TextEditingController();
  double remaining = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: InkWell(
          onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Payment',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Card(
                            color: Colors.indigo.withOpacity(0.8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            // cubit.currentTransaction.items.clear();
                                          });
                                        },
                                        child: const Text(
                                          'Clear',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 300,
                                //   child: ListView.builder(
                                //       itemCount:
                                //           cubit.currentTransaction.items.length,
                                //       padding:
                                //           const EdgeInsets.symmetric(vertical: 16),
                                //       itemBuilder: (BuildContext context, index) {
                                //         return Dismissible(
                                //           key: Key(
                                //               'item ${cubit.currentTransaction.items[index]}'),
                                //           onDismissed: (DismissDirection direction) {
                                //             print(cubit
                                //                 .currentTransaction.items.length);
                                //             cubit.currentTransaction.items
                                //                 .removeAt(index);
                                //             print(cubit
                                //                 .currentTransaction.items.length);
                                //             cubit.calculateTotal();
                                //             setState(() {});
                                //           },
                                //           child: ListTile(
                                //             leading: ClipRRect(
                                //               borderRadius: BorderRadius.circular(20),
                                //               child: cubit
                                //                   .realmServices.realm
                                //                   .find<Product>(ObjectId
                                //                   .fromHexString(cubit
                                //                   .currentTransaction
                                //                   .items[index]
                                //                   .split(',')[0]
                                //                   .trim()))!
                                //                   .imageUrl ==
                                //                   null ? Image.asset(AssetsManager.defaultProduct,width: screenWidth/15, height: screenWidth/15, fit: BoxFit.cover):CachedNetworkImage(
                                //                 height: screenWidth / 20,
                                //                 width: screenWidth / 20,
                                //                 fit: BoxFit.cover,
                                //                 imageUrl: cubit.realmServices.realm
                                //                             .find<Product>(ObjectId
                                //                                 .fromHexString(cubit
                                //                                     .currentTransaction
                                //                                     .items[index]
                                //                                     .split(',')[0]
                                //                                     .trim()))!
                                //                             .imageUrl ==
                                //                         null
                                //                     ? 'https://cdn3.vectorstock.com/i/1000x1000/03/27/cartoon-cardboard-box-vector-29560327.jpg'
                                //                     : 'https://${cubit.realmServices.realm.find<Product>(ObjectId.fromHexString(cubit.currentTransaction.items[index].split(',')[0].trim()))!.imageUrl}',
                                //                 placeholder: (context, url) =>
                                //                     const CircularProgressIndicator(),
                                //                 errorWidget: (context, url, error) =>
                                //                     Image.asset(
                                //                         AssetsManager.defaultProduct,
                                //                         width: screenWidth / 15,
                                //                         height: screenWidth / 15,
                                //                         fit: BoxFit.cover),
                                //               ),
                                //             ),
                                //             title: Text(
                                //               cubit.realmServices.realm
                                //                   .find<Product>(
                                //                       ObjectId.fromHexString(cubit
                                //                           .currentTransaction
                                //                           .items[index]
                                //                           .split(',')[0]
                                //                           .trim()))!
                                //                   .name,
                                //               style: const TextStyle(
                                //                   color: Colors.white, fontSize: 18),
                                //             ),
                                //             subtitle: Text(
                                //               cubit.realmServices.realm
                                //                       .find<Product>(
                                //                           ObjectId.fromHexString(cubit
                                //                               .currentTransaction
                                //                               .items[index]
                                //                               .split(',')[0]
                                //                               .trim()))!
                                //                       .category ??
                                //                   'General',
                                //               style:
                                //                   const TextStyle(color: Colors.grey),
                                //             ),
                                //             trailing: Text(
                                //               cubit.realmServices.realm
                                //                   .find<Product>(
                                //                       ObjectId.fromHexString(cubit
                                //                           .currentTransaction
                                //                           .items[index]
                                //                           .split(',')[0]
                                //                           .trim()))!
                                //                   .price
                                //                   .toString(),
                                //               style: const TextStyle(
                                //                   color: Colors.white),
                                //             ),
                                //           ),
                                //         );
                                //       }),
                                // ),
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
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              subtitle: const Text(
                                "new customer",
                                style: TextStyle(color: Colors.grey),
                              ),
                              trailing: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Cash',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Cash part'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                width: 200,
                                                child: TextFieldWidget(
                                                  inputType: TextInputType.number,
                                                  onChange: (val){
                                                    // final total = cubit.currentTransaction.total;

                                                    // if(double.parse(val) > total){
                                                    //   cashPartController.text = total.toString();
                                                    //   cardPartController.text = '0';
                                                    //   return;
                                                    // }
                                                    //
                                                    // cardPartController.text = (total - double.parse(val)).toString();

                                                    setState(() {
                                                    });
                                                  },

                                                    textController:
                                                        cashPartController)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Paid          '),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                width: 200,
                                                child: TextFieldWidget(
                                                    inputType: TextInputType.number,
                                                  onChange: (val){
                                                    // final total = cubit.currentTransaction.total;

                                                    // if(double.parse(val) > total){
                                                    //   paidController.text = '0';
                                                    //   return;
                                                    // }

                                                    // remaining = double.parse(val) - total ;

                                                    setState(() {
                                                    });
                                                  },
                                                    textController: paidController)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Text('Remaining'),
                                          SizedBox(
                                            width: 60,
                                          ),
                                          Text(
                                            '${remaining.toString()}\$',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Card',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Card part'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                width: 200,
                                                child: TextFieldWidget(
                                                    inputType: TextInputType.number,
                                                    onChange: (val){
                                                      // final total = cubit.currentTransaction.total;

                                                      // if(double.parse(val) > total){
                                                      //   cardPartController.text = total.toString();
                                                      //   cashPartController.text = '0';
                                                      //   return;
                                                      // }

                                                      // cashPartController.text = (total - double.parse(val)).toString();

                                                      setState(() {
                                                      });
                                                    },
                                                    textController:
                                                        cardPartController)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Transaction Receipt number'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(width: 300,child: TextFieldWidget(textController: paidController)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 600,
                            child: Card(
                              color: Colors.indigo.withOpacity(0.8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children:  [
                                        Text(
                                          "Subtotal",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        // Text(
                                        //   // cubit.currentTransaction.total.toString(),
                                        //   style: TextStyle(color: Colors.white),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Text(
                                          "Discount",
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
                                      children:  [
                                        Text(
                                          'Total',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        // Text(
                                        //   cubit.currentTransaction.total.toString(),
                                        //   style: TextStyle(color: Colors.white),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Text(
                                          "Receipt number",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "245154984585",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: SizedBox(
                              //     width: 150,
                              //     child: ButtonWidget(
                              //       onPressed: (){Navigator.pop(context);}, color: Colors.orange, child: const Text('Print'),),
                              //   ),
                              // ),
                              SizedBox(
                                width: 600,
                                child: ButtonWidget(
                                  onPressed: () {
                                    // cubit.realmServices.createTransaction(
                                    //     time: DateTime.now(),
                                    //     type: widget.isPOS? "OUT":"IN",
                                    //     billedTo: 'Ahmed Khaled',
                                    //     channel: 'Ahmed Khaled',
                                    //     items: cubit.currentTransaction.items,
                                    //     total: cubit.currentTransaction.total);
                                    // cubit.currentTransaction.items.clear();
                                    // cubit.currentTransaction.total = 0;
                                    // cubit.setState();
                                    // Navigator.pop(context);
                                  },
                                  color: Colors.orange,
                                  child: const Text('Confirm and Print'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
        ),
      ),
    );
  },
),
    );
  }
}
