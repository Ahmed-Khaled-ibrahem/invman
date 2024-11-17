import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/model/filters_model.dart';
import 'package:invman/model/notUsed/item.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/presentation/layout/inventory/cards_panel.dart';
import 'package:invman/presentation/layout/inventory/product_card.dart';
import 'package:invman/presentation/layout/product/product_screen.dart';
import 'package:invman/presentation/responsive/responsive.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:realm/realm.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.isMobile(context)? 50: null,
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
                      SizedBox(
                        width: 180,
                        // height: 80,
                        child: Card(
                          margin: Responsive.isMobile(context)? null :const EdgeInsets.all(10),
                          color: Colors.green,
                          child: ListTile(
                            textColor: Colors.white,
                            onTap: () {
                              navigateTo(context, ProductScreen());
                            },
                            minVerticalPadding: 0,
                            minLeadingWidth: 0,
                            // tileColor: Colors.green,
                            title: const Text(
                              'Product',
                              style: TextStyle(fontSize: 12),
                            ),
                            subtitle: const Text(
                              'Create',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            leading:  Icon(
                              Icons.add,
                              size: Responsive.isMobile(context)? 25 : 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CardsPanel(),

                Responsive.isTablet(context)? const SizedBox(
                  height: 10,
                ):Container(),
                Responsive.isTablet(context)? Text(
                  cubit.searchResultsEnable && Responsive.isTablet(context)
                      ? ''
                      : 'Results', // it shoud be favourits
                  style: const TextStyle(fontSize: 16),
                ):Container(),

                cubit.searchResultsEnable && Responsive.isTablet(context)
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              10,
                              (index) => SizedBox(
                                    width: 200,
                                    // child: ProductCard(String product),
                                  )),
                        ),
                      )
                    : Expanded(
                        child: GridView.count(
                            crossAxisCount: Responsive.isMobile(context) ? 3 : 4,
                            shrinkWrap: true,
                            childAspectRatio: Responsive.isMobile(context) ? 1.7 : 1.7,
                            scrollDirection: Axis.vertical,
                            children: cubit.searchResults == null
                                ? [Container()]
                                : cubit.searchResults!
                                    .map((e) => ProductCard(e))
                                    .toList()),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
