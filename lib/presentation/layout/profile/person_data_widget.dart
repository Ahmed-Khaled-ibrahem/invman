import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget personDataWidget(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      const Text('Ahmed Khaled Ibrahem',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,maxLines: 1,),
      line(Icons.confirmation_number, "#2265165"),
      line(Icons.person, "Admin"),
      line(Icons.phone, "+201288534459"),
      line(Icons.location_on_sharp, "88 nasreldin str - Elgomrok - alexandria"),
      line(Icons.mail, "ahmedkhaledibrahem@gmail.com"),

    ],
  );
}


Widget line(IconData icon,String text){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon),
      const SizedBox(width: 20,),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,),
      ),
    ],
  );
}