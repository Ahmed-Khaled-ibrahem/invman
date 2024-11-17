import 'package:flutter/material.dart';
import 'package:invman/presentation/layout/profile/person_data_widget.dart';

Widget normalViewWidget(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            personDataWidget(),
            Row(
              children: [
                const SizedBox(width: 440,),
                IconButton(onPressed: (){ }, icon: const Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
      TextButton(
          onPressed: (){}, child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.lock),
          Text('Change Password')
        ],
      )),
      Expanded(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: TextButton(
              onPressed: (){}, child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.manage_accounts,size: 37,),
              Text('Manage Accounts',style: TextStyle(fontSize: 20),)
            ],
          )),
        ),
      )
    ],
  );
}