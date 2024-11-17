import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// class StockAlertTile{
//    DateTime date ;
//
//    StockAlertTile(){
//
//    }
// }


Widget stockAlertTile(index){
  return Slidable(
    // key: Key(notifications[index]),
    endActionPane:  ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          flex: 2,
          onPressed: (val){},
          backgroundColor: Color(0xFF7BC043),
          foregroundColor: Colors.white,
          icon: Icons.mark_chat_read,
          label: 'Read',
        ),
        SlidableAction(
          onPressed: (val){},
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),

    child: ListTile(
        leading: const Icon(Icons.store),
        trailing: const Text(
          "25-06-2023\n12:15:00",
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        subtitle: const Text("#54611 nike shoesw"),
        title: Text("Out of stock ${index+1}")
    ),
  );
}