import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/functions/custom_dialog.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/main_layout.dart';
import 'package:invman/presentation/widgets/button.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import '../../loading_holder_screen/loading_holding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? rememberMe = false;
  bool switchView = true;
  double containerWidth = 900;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      runAnimation();
    });
  }
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void runAnimation() async {
    setState(() {
      containerWidth = 400;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AssetsManager.backgroundLogin)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: containerWidth,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.75),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        reverseDuration: const Duration(seconds: 1),
                        switchInCurve: Curves.easeInExpo,
                        switchOutCurve: Curves.easeOutCirc,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: switchView
                            ? loginView(context, cubit,userNameController, passwordController)
                            : accountsView(context, cubit),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 30,
                    child: InkWell(
                      onTap: () {
                        // navigateTo(context, const MainLayoutScreen());
                        EasyLoading.showToast('Signing in as a Demo version').whenComplete((){
                          print('logining');
                          navigateTo(context, const MainLayoutScreen());
                        }).timeout(const Duration(seconds: 1));
                      },
                      child: Row(
                        children: const [
                          Text('Demo Login'),
                          Icon(Icons.double_arrow_outlined),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget loginView(context, AppCubit cubit, userNameController, passwordController ) {
    final _formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Hero(
                      tag: 'logo',
                      child: Image.asset(AssetsManager.logo, height: 150)),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.left,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("See your growth and get support.")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: TextFieldWidget(
                      hintText: "Enter your Email",
                      prefixIcon: const Icon(Icons.person),
                      titleText: 'Email',
                      textController: userNameController,
                    ),
                  ),
                  // const SizedBox(height: 20,),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: TextFieldWidget(
                      onChange: (val){},
                      hintText: 'Enter the password',
                      titleText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      textController: passwordController,
                      isPassword: true,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                      ),
                      // const SizedBox(width: 3),
                      const Text(
                        'Remember me',
                        style: TextStyle(fontSize: 17.0),
                      ), //Checkbox
                    ], //<Widget>[]
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ButtonWidget(
                        onPressed: () async{
                          if(_formKey.currentState!.validate()) {
                            bool access = cubit.loginButtonEvent(userNameController.text,passwordController.text);

                            if(access){
                              setState(() {
                                switchView = false;
                              });
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            // Icon(Icons.arrow_forward_ios, color: Colors.white,size: ,),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          child: const Text('Contact us'),
          onPressed: () {
            showCustomDialogWidget(
                context,
                SizedBox(
                  width: 200,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'Contact',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Invman company',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Mail : Invman@any.com',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(AssetsManager.qr)
                    ],
                  ),
                ));

             // cubit.register(userNameController.text,passwordController.text);
          },
        ),
      ],
    );
  }

  Widget accountsView(context, AppCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {

                      // bool access = cubit.loginButtonEvent('','');
                      //
                      // if(access){
                        setState(() {
                          switchView = true;
                        });
                      // }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.grey,
                    )),
                Text(
                  'Accounts',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: const Text(
                      "3 alerts",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("shop number ${index + 1}"));
              }),
        ],
      ),
    );
  }
}
