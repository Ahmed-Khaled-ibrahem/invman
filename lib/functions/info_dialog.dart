import 'package:flutter/material.dart';

Future<void> showInfoDialogWidget(context,String title, String content, VoidCallback yesCallback) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
              Container(color: Colors.red,width: 300,height: 300,)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
              yesCallback;
            },
          ),
        ],
      );
    },
  );
}
