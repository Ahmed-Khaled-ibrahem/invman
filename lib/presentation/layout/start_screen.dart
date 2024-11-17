import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/login/login_screen.dart';

import '../../functions/easy_loading.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>{

  @override
  void initState() {
    super.initState();

    easyLoadingSetup();

    Timer(const Duration(seconds: 2), () {
      navigateToReplacement(context, const LoginScreen());
      // EasyLoading.show(status: 'loading...');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset( AssetsManager.logo,
                width: 150,
                height: 150,
              ),
            ),
          ),
          Center(
            child: Image.asset( AssetsManager.logo,
              color: Colors.white,
              width: 150,
              height: 150,
            ),
          ),
          Center(
             child: Image.asset( AssetsManager.gif,
              width: 500,
              height: 500,
          ),
           ),
        ],
      ),
    );
  }
}
