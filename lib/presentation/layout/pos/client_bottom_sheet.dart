import 'package:flutter/material.dart';

import '../../../functions/navigation.dart';
import '../../../model/const/assets_manager.dart';
import '../../widgets/text_field.dart';
import 'new_client.dart';

class BottomSheetClient extends StatefulWidget {
  const BottomSheetClient({Key? key}) : super(key: key);

  @override
  State<BottomSheetClient> createState() => _BottomSheetClientState();
}

class _BottomSheetClientState extends State<BottomSheetClient> {

  TextEditingController editingController = TextEditingController();
  bool searchResultsEnable = true;

  void filterSearchResults(String query) {
    setState(() {
      // items = duplicateItems
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
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
                    hintText: "Use Person name or Person ID",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                SizedBox(
                  width: 180,
                  // height: 80,
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.green,
                    child: ListTile(
                      textColor: Colors.white,
                      onTap: (){
                        navigateTo(context,  const AddNewClient());
                      },
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      // tileColor: Colors.green,
                      title: const Text('Person',style: TextStyle(fontSize: 12),),
                      subtitle: const Text('Add new',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                      leading: const Icon(Icons.add,size: 40,color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1,
                  childAspectRatio: 3
                ),
                itemBuilder: (dfs,fsd){
                  return ListTile(
                       leading: const CircleAvatar(
                         backgroundImage: AssetImage(AssetsManager.pic),
                       ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                    title: const Text(
                      'Ahmed khaled Ibrahem',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16),
                    ),
                    subtitle: const Text(
                      "01288534459",
                      style: TextStyle(color: Colors.grey),
                    ),


                  );
                },
                itemCount: 10,
                  // crossAxisCount: 4,
                  shrinkWrap: true,
                  // childAspectRatio: 1.6,
                  scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
