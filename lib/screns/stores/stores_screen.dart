import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/stores_manager.dart';
import 'package:michellemirandastore/screns/stores/components/store_card.dart';
import 'package:provider/provider.dart';
class StoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Lojas',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Consumer<StoresManager>(
        builder: (_, storesManager,__){
          if(storesManager.stores.isEmpty){
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.transparent,
            );
          }

          return ListView.builder(
            itemCount: storesManager.stores.length,
            itemBuilder: (_, index){
              return StoreCard(storesManager.stores[index]);
            }
          );
          return Container();
        },
      ),
    );
  }
}
