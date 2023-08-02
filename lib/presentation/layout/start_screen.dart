import 'package:flutter/material.dart';
import 'package:invman/model/const/assets_manager.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset( AssetsManager.gif,
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
