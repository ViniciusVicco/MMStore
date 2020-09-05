import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/home_manager.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red[200],
                  Colors.pink[100],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
            ),
          ),
          CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true, // Só funciona com FLoating
              floating: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("Michelle Miranda Store"),
                centerTitle: true,
              ) ,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  
                )
              ],
            ),
            Consumer<HomeManager>(
              builder: (_, homeManager, __){
                final List<Widget> children = homeManager.sections.map<Widget>((section) {
                  switch (section.type){
                    case 'Staggered':
                      return SectionStaggered(section);
                    case 'List':
                      return SectionList(section);
                    default:
                      return Container(
                        child: Text("Deu ruim"),
                      );
                  }
                }).toList();
                return  SliverList(
                    delegate: SliverChildListDelegate(children),
                );
              },
           ),
          ],
        ),
      ]
      ),
    );
  }
}
