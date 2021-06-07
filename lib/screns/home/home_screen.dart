import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/home_manager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/add_section_widget.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: CustomDrawer(),
      body: Stack(children: <Widget>[
        CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              snap: true, // Só funciona com FLoating
              floating: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  "Michelle Miranda Store",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              actions: <Widget>[
                Consumer2<UserManager, HomeManager>(
                  builder: (_, userManager, homeManager, __) {
                    if (userManager.adminEnabled && !homeManager.loading) {
                      if (homeManager.editing) {
                        return PopupMenuButton(
                          onSelected: (e) {
                            if (e == 'Salvar') {
                              homeManager.saveEditing();
                            } else {
                              homeManager.discardEditing();
                            }
                          },
                          itemBuilder: (_) {
                            return ['Salvar', 'Descartar'].map((e) {
                              return PopupMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList();
                          },
                        );
                      } else {
                        return IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.edit),
                          onPressed: homeManager.enterEditing,
                        );
                      }
                    } else {
                      return IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/cart'),
                      );
                    }
                  },
                ),
              ],
            ),
            Consumer<HomeManager>(
              builder: (_, homeManager, __) {
                if (homeManager.loading) {
                  return SliverToBoxAdapter(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }
                final List<Widget> children =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'Staggered':
                      return SectionStaggered(section);
                    case 'List':
                      return SectionList(section);
                    default:
                      return Container(
                        child: Text("Ocorreu um problema"),
                      );
                  }
                }).toList();
                if (homeManager.editing)
                  children.add(AddSectionWidget(homeManager));
                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
