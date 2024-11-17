import 'package:flutter/material.dart';

Future<void> showCustomDialogWidget(context, Widget content) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: content,
      );
    },
  );
}
