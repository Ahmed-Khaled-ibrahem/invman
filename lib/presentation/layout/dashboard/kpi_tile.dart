import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget kpiTile(double screenWidth, String title, String val, String unit){
  return Card(
    color: Colors.indigo.withOpacity(0.7),
    child: SizedBox(
      width: screenWidth/5,
      child:  ListTile(
        textColor: Colors.white,
        iconColor: Colors.white,
        leading: Icon(Icons.monetization_on_rounded, size: 40,),
        title: AutoSizeText(title,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), maxLines: 1,minFontSize: 2,),
        subtitle: AutoSizeText('$val $unit',style: TextStyle(fontSize: 28),maxLines: 1),
      ),
    ),
  );
}