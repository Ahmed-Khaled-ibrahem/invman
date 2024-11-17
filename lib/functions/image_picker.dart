import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invman/functions/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



Future<ImageSource?> imageDialog(BuildContext context) {
  return showGeneralDialog<ImageSource>(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: const Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context, ImageSource.gallery),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 200,height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.image,
                          size: 100,
                        ),
                        Text('Gallery',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context, ImageSource.camera),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 200,height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 110,
                        ),
                        Text('Camera',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

