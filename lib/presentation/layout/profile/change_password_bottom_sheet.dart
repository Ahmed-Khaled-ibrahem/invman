import 'package:flutter/material.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  ChangePasswordBottomSheet({Key? key}) : super(key: key);

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController new2PasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(
          width: screenWidth/2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Change Password',style: TextStyle(fontSize: 30),),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    textController: newPasswordController,
                  prefixIcon: const Icon(Icons.password),
                  hintText: 'Enter the current password',
                  titleText: 'Current Passwrod',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  textController: oldPasswordController,
                  prefixIcon: const Icon(Icons.password),
                  hintText: 'Enter the new password',
                  titleText: 'New Passwrod',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  textController: new2PasswordController,
                  prefixIcon: const Icon(Icons.password),
                  hintText: 'Confirm the new password',
                  titleText: 'Confirm Passwrod',
                  isPassword: true,
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){

                    },
                    color: Colors.green,
                    child: const Text('Save',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40,),
        Lottie.asset(AssetsManager.passwordLottie, repeat: false,reverse: true,),
      ],
    );
  }
}
