import 'package:flutter/material.dart';
import 'stock_alert_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List notifications = List.generate(15, (index) => '$index');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Scaffold(
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){}, child: const Text('Delete all', style: TextStyle(color: Colors.red),)),
                  TextButton(onPressed: (){}, child: const Text('Mark all as read'))
                ],
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Text('Stock alerts'),
                    Expanded(
                      child: ListView.builder(
                          itemCount: notifications.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return stockAlertTile(index);
                          }),
                    ),
                  ],
                ),
              ),
            )),
        const VerticalDivider(thickness: 2),
        Expanded(
            child: Column(
              children: [
                const Text('Messages'),
                true? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 150,),
                    Icon(Icons.message),
                    Text('Empty')
                  ],
                ):ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: const Text(
                            "3 alerts",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("shop number ${index+1}"));
                    }),
              ],
            )),
      ],
    );
  }
}
