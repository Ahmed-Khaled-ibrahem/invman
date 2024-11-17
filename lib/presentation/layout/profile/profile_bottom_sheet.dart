import 'package:flutter/material.dart';
import 'package:invman/model/const/assets_manager.dart';

import 'person_data_widget.dart';

class BottomSheetProfile extends StatefulWidget {
  const BottomSheetProfile({Key? key}) : super(key: key);

  @override
  State<BottomSheetProfile> createState() => _BottomSheetProfileState();
}

class _BottomSheetProfileState extends State<BottomSheetProfile> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: personDataWidget()),
            const SizedBox(width: 20,),
            Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(AssetsManager.pic, height: screenHeight/3,)),
            ),
          ],
        ),
      ),
    );
  }
}
