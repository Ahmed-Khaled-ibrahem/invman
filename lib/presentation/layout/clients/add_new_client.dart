import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invman/functions/image_picker.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/functions/toast.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/accounts/accounts_screen.dart';
import 'package:invman/presentation/layout/profile/change_password_bottom_sheet.dart';
import 'package:invman/presentation/layout/profile/person_data_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/text_field.dart';

class ClientMangmentScreen extends StatefulWidget {
  const ClientMangmentScreen({Key? key}) : super(key: key);

  @override
  _ClientMangmentScreenState createState() => _ClientMangmentScreenState();
}

class _ClientMangmentScreenState extends State<ClientMangmentScreen> {

  TextEditingController nameController = TextEditingController(text: 'Ahmed khaled ibrahem');
  TextEditingController phoneController = TextEditingController(text: '+201288534459');
  TextEditingController addressController = TextEditingController(text: '88 nasreldin str - Elgomrok - alexandria');
  TextEditingController mailController = TextEditingController(text: 'ahmedkhaledibrahem@gmail.com');
  File? image ;
  List roles = ['Client', 'Supplier'];
  String selectedRole = 'Client';

  Future pickImage(context) async {

    if (await Permission.camera.request().isGranted) {
      imageDialog(context).then((ImageSource? source) async {
        if (source != null) {

          XFile? pickedFile = await ImagePicker().pickImage(source: source);

          if (pickedFile != null) {
            setState(() {
              image = File(pickedFile.path);
            });

          }

        }
      });
    } else {
      showToast('can not open camera');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                'New Person',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Expanded(
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0)),
              onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Padding(
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
                                Navigator.pop(context);
                                });},
                                color: Colors.green,
                                child: const Text('Save',style: TextStyle(color: Colors.white),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: image == null ?
                              Image.asset(AssetsManager.pic, height: 250,):
                              Image.file(image!,height: 250,)),
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
                        const SizedBox(height: 30,),
                        const Text('Role'),
                        ToggleButtons(
                          isSelected: roles.map((e) => e==selectedRole).toList(),
                          onPressed: (int index) {
                            setState(() {
                              selectedRole = roles[index];
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Icon(Icons.person,size: 60,),
                                  Text(roles[0]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Icon(Icons.inventory,size: 60,),
                                  Text(roles[1]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
