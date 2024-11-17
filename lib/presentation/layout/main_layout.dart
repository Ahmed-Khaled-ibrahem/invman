import 'package:flutter/material.dart';
import 'package:invman/functions/dialog.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/presentation/layout/analysis/analysis_screen.dart';
import 'package:invman/presentation/layout/clients/clients_screen.dart';
import 'package:invman/presentation/layout/dashboard/dashboard_screen.dart';
import 'package:invman/presentation/layout/inventory/Inventory_screen.dart';
import 'package:invman/presentation/layout/login/login_screen.dart';
import 'package:invman/presentation/layout/notifications/notificaions_screen.dart';
import 'package:invman/presentation/layout/pos/pos.dart';
import 'package:invman/presentation/layout/profile/profile_screen.dart';
import 'package:invman/presentation/layout/transactions/transactions_screen.dart';
import 'package:sidebarx/sidebarx.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  _MainLayoutScreenState createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final _controller = SidebarXController(selectedIndex: 0, extended: false);
  int counter = 3;
  // final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
    });});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          ExampleSidebarX(
            controller: _controller,
          ),
          Expanded(
              child: Stack(
                children: [
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: _Screens(controller: _controller,),
                      )
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.all(0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(_getTitleByIndex(_controller.selectedIndex),style: const TextStyle(
                            fontSize: 30,
                          ),),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 60,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: (){_controller.selectIndex(7);},
                                child: Card(
                                 color: _controller.selectedIndex == 7 ?accentCanvasColor:canvasColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))),
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Icon(Icons.notifications, size: 35,color: _controller.selectedIndex == 7? white : black,),
                                 ),
                                    ),
                              ),
                              counter != 0 ?  Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    '$counter',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ) :  Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                              selected: _controller.selectedIndex == 8,
                              selectedTileColor: accentCanvasColor,
                              onTap: (){_controller.selectIndex(8);},
                              title: Text('Ahmed khaled',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: _controller.selectedIndex == 8? white:black,
                                    fontSize: 16
                                ),),
                              tileColor: canvasColor,
                              subtitle:  Text('Ahmedkhaledibrahem@gmail.com ', overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: _controller.selectedIndex == 8? white:black,
                                    fontSize: 10
                                ),),
                              leading: const CircleAvatar(foregroundImage: AssetImage(AssetsManager.pic)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              )),
        ],
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(color: black),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: accentCanvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 10,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: black,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      // footerDivider: divider,
      footerBuilder: (context, extended) {
        return extended? SizedBox(
          width: double.infinity,
          child: MaterialButton(
             color: Colors.red,
              onPressed: (){

                showConfirmationDialogWidget(context,'Logout','Are you sure that you want to logout?',(){
                  navigateToReplacement(context, const LoginScreen());
                });


               }, child: const Text('Logout')),
        ) : Container();
      },
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AssetsManager.logo),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.dashboard_rounded,
          label: _getTitleByIndex(0),
          onTap: () {
          },
        ),
         SidebarXItem(
          icon: Icons.monetization_on_rounded,
          label: _getTitleByIndex(1),
        ),
         SidebarXItem(
          icon: Icons.input_rounded,
          label: _getTitleByIndex(2),
        ),
         SidebarXItem(
          icon: Icons.store_rounded,
          label: _getTitleByIndex(3),
        ),
         SidebarXItem(
          icon: Icons.history_outlined,
          label: _getTitleByIndex(4),
        ),
         SidebarXItem(
          icon: Icons.supervised_user_circle_sharp,
          label: _getTitleByIndex(5),
        ),
         SidebarXItem(
          icon: Icons.analytics_rounded,
          label: _getTitleByIndex(6),
        ),
        //  SidebarXItem(
        //   icon: Icons.notifications,
        //   label: _getTitleByIndex(7),
        // ),
        //  SidebarXItem(
        //   icon: Icons.person_pin_sharp,
        //   label: _getTitleByIndex(8),
        // ),
      ],
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const DashboardScreen();
          case 1:
            return  POSScreen(true);
          case 2:
            return  POSScreen(false);
          case 3:
            return const InventoryScreen();
          case 4:
            return const TransactionsScreen();
          case 5:
            return const ClientsScreen();
          case 6:
            return const AnalysisScreen();
          case 7:
            return const NotificationsScreen();
          case 8:
            return const ProfileScreen();

          default:
            return const Text(
              'nothing selected',
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Dashboard';
    case 1:
      return 'POS';
    case 2:
      return 'Order';
    case 3:
      return 'Inventory';
    case 4:
      return 'Transactions';
    case 5:
      return 'Clients';
    case 6:
      return 'Analysis';
    case 7:
      return 'Notifications';
    case 8:
      return 'Profile';
    default:
      return 'none';
  }
}

const canvasColor = Color(0xFFD8D9DA);
const accentCanvasColor = Color(0xFF19A7CE);
const white = Colors.white;
const black = Colors.black;
const actionColor = Color(0xFF5F5FA7);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
