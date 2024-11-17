import 'package:flutter/material.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/accounts/add_new_account.dart';
import 'package:invman/presentation/layout/profile/profile_bottom_sheet.dart';
import 'package:invman/presentation/responsive/responsive.dart';
import 'package:invman/presentation/widgets/text_field.dart';

import 'account_card_widget.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List.generate(20, (i) => "person number $i");
  late List<String> items ;

  @override
  void initState() {
    super.initState();
    items = duplicateItems;
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0)),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Column(
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
                    'Accounts',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  MaterialButton(
                      textColor: Colors.green,
                      onPressed: () { navigateTo(context, const AddNewAccountScreen());},
                      child: Row(
                        children: const [
                          Icon(Icons.add_circle),
                          SizedBox(
                            width: 4,
                          ),
                          Text('add new account'),
                        ],
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldWidget(
                  onChange: (value) {
                    filterSearchResults(value);
                  },
                  suffixIcon : IconButton(
                    icon: Icon(Icons.cancel,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        editingController.clear();
                        filterSearchResults('');
                      });
                    },
                  ),
                  textController: editingController,
                  titleText: "Search",
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                ),
              ),

              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: Responsive.isMobile(context) ? 1.5 : 2
                    // childAspectRatio: 2.5
                  ),
                  children: items.map((item) => accountCardWidget(context, item) ).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
