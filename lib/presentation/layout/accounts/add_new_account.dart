import 'package:flutter/material.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/widgets/text_field.dart';

class AddNewAccountScreen extends StatefulWidget {
  const AddNewAccountScreen({Key? key}) : super(key: key);

  @override
  _AddNewAccountScreenState createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController mailController = TextEditingController(text: '');
  TextEditingController passController = TextEditingController(text: '');
  TextEditingController confirmationController = TextEditingController(text: '');

  List roles = ['Admin', 'cashier'];
  String selectedRole = 'Admin';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 40,
        child: MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.done, color: Colors.white,),
              SizedBox(width: 10,),
              Text('Create',style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),

      body: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0)),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
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
                      'Create New Account',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              textController: nameController,
                              titleText: 'Name',
                              hintText: "Enter your name",
                              prefixIcon: const Icon(Icons.person),
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: userNameController,
                              titleText: 'UserName',
                              hintText: "Enter your user name",
                              prefixIcon: const Icon(Icons.verified_user_rounded),
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: phoneController,
                              titleText: 'Phone',
                              hintText: "Enter your phone",
                              prefixIcon: const Icon(Icons.phone),
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: addressController,
                              titleText: 'address',
                              hintText: "Enter your address",
                              prefixIcon: const Icon(Icons.location_on_sharp),
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: mailController,
                              titleText: 'mail',
                              hintText: "Enter your Mail",
                              prefixIcon: const Icon(Icons.mail),
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: passController,
                              titleText: 'Password',
                              hintText: "Enter the password",
                              prefixIcon: const Icon(Icons.password),
                              isPassword: true,
                            ),
                            const SizedBox(height: 15,),
                            TextFieldWidget(
                              textController: confirmationController,
                              titleText: 'Confirm Password',
                              hintText: "Enter the password",
                              prefixIcon: const Icon(Icons.password),
                              isPassword: true,
                            ),

                          ],
                        ),
                      ),
                    ),
                    // const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(AssetsManager.pic, height: 250,)),
                        ),
                        Row(
                          children: [
                            MaterialButton(onPressed: (){}, color: Colors.green, child: const Text('Upload'),),
                            const SizedBox(width: 30,),
                            MaterialButton(onPressed: (){}, color: Colors.deepOrange, child: const Text('Remove'),),
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
                                  const Icon(Icons.person_pin,size: 60,),
                                  Text(roles[0]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Icon(Icons.point_of_sale_sharp,size: 60,),
                                  Text(roles[1]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
