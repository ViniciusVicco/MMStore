import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/screns/admin_orders/admin_orders_screen.dart';
import 'package:michellemirandastore/screns/admin_users/admin_users_screen.dart';
import 'package:michellemirandastore/screns/home/home_screen.dart';
import 'package:michellemirandastore/screns/orders/orders_screen.dart';
import 'package:michellemirandastore/screns/products/products_screen.dart';
import 'package:michellemirandastore/screns/stores/stores_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp]
    );

  }
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_,userManager,__){
          return PageView(
//      physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              StoresScreen(),
              if(userManager.adminEnabled)...[

                AdminOrdersScreen(),
              ]
            ],
          );
        },
      )
    );
  }

}
