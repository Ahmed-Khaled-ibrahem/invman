import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {ToastType type = ToastType.error}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: type ==ToastType.note ? ToastGravity.CENTER :ToastGravity.BOTTOM ,
      timeInSecForIosWeb: 1,
      backgroundColor: type == ToastType.error ? Colors.deepOrange : Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastType { info, error, note }