

import 'package:flutter/material.dart';

void showBottomSheetWidget(BuildContext context, Widget content, {double height=0.5}){
  showModalBottomSheet(
    useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight:  Radius.circular(20), topLeft: Radius.circular(20))),
      context: context,
      builder: (BuildContext bc){
        return FractionallySizedBox
          (heightFactor: height,
            child: content);
      }
  );
}