import 'package:flutter/material.dart';
import 'package:invman/presentation/widgets/text_field.dart';

Widget editViewWidget(){
  TextEditingController nameController = TextEditingController(text: 'Ahmed khaled ibrahem');
  TextEditingController phoneController = TextEditingController(text: '+201288534459');
  TextEditingController addressController = TextEditingController(text: '88 nasreldin str - Elgomrok - alexandria');
  TextEditingController mailController = TextEditingController(text: 'ahmedkhaledibrahem@gmail.com');

  return SizedBox(
    width: 400,
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
              onPressed: (){},
              color: Colors.green,
            child: const Text('Save',style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    ),
  );
}