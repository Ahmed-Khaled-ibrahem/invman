import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/responsive/responsive.dart';

import '../../../functions/show_bottom_sheet.dart';
import '../profile/profile_bottom_sheet.dart';

Widget accountCardWidget(context, item){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){  showBottomSheetWidget(context, const BottomSheetProfile(),
          height: Responsive.isMobile(context) ? 0.9 : 0.6); },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.white,

        child: Column(
          children: [
            ListTile(
              shape:  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              tileColor: Colors.blue.withOpacity(0.4),
              leading: const CircleAvatar(foregroundImage: AssetImage(AssetsManager.pic)),
              title: Text(item,overflow: TextOverflow.ellipsis,maxLines: 2,),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.deepOrange),
                      TextButton(onPressed: (){}, child: const Text('Delete',style: TextStyle(color: Colors.deepOrange),)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.lightGreen),
                      TextButton(onPressed: (){}, child: const Text('Edit',style: TextStyle(color: Colors.lightGreen),)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}