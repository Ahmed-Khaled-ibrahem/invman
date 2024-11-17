import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invman/functions/image_picker.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/functions/toast.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/accounts/accounts_screen.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'change_password_bottom_sheet.dart';
import 'person_data_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool switchView = true;
  TextEditingController nameController = TextEditingController(text: 'Ahmed khaled ibrahem');
  TextEditingController phoneController = TextEditingController(text: '+201288534459');
  TextEditingController addressController = TextEditingController(text: '88 nasreldin str - Elgomrok - alexandria');
  TextEditingController mailController = TextEditingController(text: 'ahmedkhaledibrahem@gmail.com');
  File? image ;

  Future pickImage(context) async {

    if (await Permission.camera.request().isGranted) {
      imageDialog(context).then((ImageSource? source) async {
        if (source != null) {

          XFile? pickedFile = await ImagePicker().pickImage(source: source);

          if (pickedFile != null) {
            setState(() {
              image = File(pickedFile.path);
            });
            // Directory programPath = await getApplicationDocumentsDirectory();
            // String newPath = "${programPath.path}/${pickedFile.name}";
            // roomsDataBase[roomIndex].roomImg = pickedFile.path;
            // File(pickedFile.path).copy(newPath);
            // emit(PhotoTakenState());
            // if (reWrite) {
            //   writeInitialToDatabase(context, nav: false, needReorder: false);
            // }
          }

        }
      });
    } else {
      showToast('can not open camera');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0)),
      onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth/2.2,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(seconds: 0),
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutCirc,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },

              child: switchView? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        personDataWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){ setState(() {
                              switchView = !switchView;
                            }); }, icon: const Icon(Icons.edit)),
                          ],
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        showBottomSheetWidget(context, ChangePasswordBottomSheet(), height: 0.7);
                      }, child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock),
                      Text('Change Password')
                    ],
                  )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: (){
                            navigateTo(context, const AccountsScreen());
                          }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.manage_accounts,size: 37,),
                          Text('Manage Accounts',style: TextStyle(fontSize: 20),)
                        ],
                      )),
                    ),
                  )
                ],
              ) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldWidget(
                        textController: nameController,
                        titleText: 'Name',
                        hintText: "Enter your name",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      const SizedBox(height: 20,),
                      TextFieldWidget(
                        textController: phoneController,
                        titleText: 'Phone',
                        hintText: "Enter your phone",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      const SizedBox(height: 20,),
                      TextFieldWidget(
                        textController: addressController,
                        titleText: 'address',
                        hintText: "Enter your address",
                        prefixIcon: const Icon(Icons.location_on_sharp),
                      ),
                      const SizedBox(height: 20,),
                      TextFieldWidget(
                        textController: mailController,
                        titleText: 'mail',
                        hintText: "Enter your Mail",
                        prefixIcon: const Icon(Icons.mail),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: 400,
                        child: MaterialButton(
                          onPressed: (){setState(() {
                            switchView = !switchView;
                          });},
                          color: Colors.green,
                          child: const Text('Save',style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // child: switchView? normalViewWidget() : editViewWidget(),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image == null ?
                    Image.asset(AssetsManager.pic, height: screenHeight/3,):
                    Image.file(image!,height: screenHeight/3,)),
              ),
              Row(
                children: [
                MaterialButton(onPressed: () async {
                  pickImage(context);
                }, color: Colors.green, child: const Text('Upload'),),
                const SizedBox(width: 30,),
                MaterialButton(onPressed: (){
                  setState(() {
                    image = null;
                  });

                }, color: Colors.deepOrange, child: const Text('Remove'),),
              ],),

              // const SizedBox(height: 30,),
              // const Text('Login History'),

              // DataTable(
              //     columns: const [
              //       DataColumn(
              //         label: Text('Date'),
              //       ),
              //       DataColumn(
              //         label: Text('Time'),
              //       ),
              //     ],
              //     rows: const [
              //
              //     ]
              // ),
              //
              // SizedBox(
              //   width: 300,
              //   height: 100,
              //   child: ListView.builder(
              //       itemCount: 2,
              //       shrinkWrap: false,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: const [
              //             Text('25-06-2012'),
              //             Text('12:25:00')
              //           ],
              //         );
              //       }),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
