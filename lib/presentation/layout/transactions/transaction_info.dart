import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/model/const/datetimeFormat.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:realm/realm.dart';


class TransactionsInfo extends StatelessWidget {
  TransactionsInfo(this.transactionItem ,{Key? key}) : super(key: key);

  final TransactionItem transactionItem ;

  TableRow tableRow(id, name, qty, price, total){
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Center( child: Text(id, style: const TextStyle(fontSize: 15.0), overflow: TextOverflow.ellipsis, maxLines: 1,)),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(name, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(qty, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(price, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(total, style: const TextStyle(fontSize: 15.0),)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
  builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigoAccent,
        icon: const Icon(Icons.monetization_on_rounded),
          onPressed: (){}, label: Text('${transactionItem.total} \$ total')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            color: Colors.grey.withOpacity(0.4),child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text('Transaction',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
                    Row(
                      children: [
                        const Icon(Icons.merge_type),
                        Text(transactionItem.type,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text('Billed to',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                     Text(transactionItem.billedTo,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
                    const Text('address here we can use',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text('Invoice number',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                    Text(transactionItem.id.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                    SizedBox(height: 30,),
                    Text('issued on ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                    Text(DateFormat(DateTimeFormatString.date).format(transactionItem.type as DateTime),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                    Text(DateFormat(DateTimeFormatString.time).format(transactionItem.type as DateTime),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                                     ],
                )
              ],
          ),
            ),),

          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Products List',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(color: Colors.black,width: 1,borderRadius: const BorderRadius.all(Radius.circular(5))),
                      columnWidths: const {
                        0: FixedColumnWidth(100),
                        1: FlexColumnWidth(),
                        2: FixedColumnWidth(150),
                        3: FixedColumnWidth(150),
                        4: FixedColumnWidth(150),
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                            children: const [
                              Center(child: Text('ID',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Name',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
                              ),
                              Center(child: Text('Quantity',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Price',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Total',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                        ]),

                        ...transactionItem.items.map((e) {
                          ObjectId productID = ObjectId.fromHexString(e.split(',')[0].trim().toString());
                          int qty = int.parse(e.split(',')[1].trim());

                          Product? product = cubit.realmServices.realm.find<Product>(productID);
                          
                          return tableRow(
                              product?.id.toString() ,product?.name.toString(), qty.toString(),product?.price.toString(), (product!.price * qty).toString()
                          );
                        }).toList()


                      ],
                    ),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }
}

class TransactionItem {
  get items => null;

  get id => null;

  String get billedTo => 'null';

  String get type => 'null';

  get total => null;
}
