import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/screns/admin_users/amin_users_screen.dart';
import 'package:michellemirandastore/screns/home/home_screen.dart';
import 'package:michellemirandastore/screns/orders/orders_screen.dart';
import 'package:michellemirandastore/screns/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

//    List<int> lista = [1,2,3,4,5, if(1==2)...[7,8]];
//    print(lista);

    // os ...[lista] permite inserir uma lista em qualquer lugar de um array, também é possível adicioanr um if


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
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text("Lojas"),
                ),
              ),
              if(userManager.adminEnabled)...[
                AdminUsersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text("Gerênciar"),
                  ),
                ),
              ]
            ],
          );
        },
      )
    );
  }
}
