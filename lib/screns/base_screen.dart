import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:michellemirandastore/screns/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
//      physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          LoginScreen(

          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Produtos"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Meus Pedidos"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Lojas"),
            ),
          ),
          Container(color: Colors.red,),
          Container(color: Colors.yellow,),
          Container(color: Colors.green,),
        ],
      ),
    );
  }
}
