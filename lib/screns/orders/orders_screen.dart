import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/empty_cart_card.dart';
import 'package:michellemirandastore/common/login_card.dart';
import 'package:michellemirandastore/models/orders_manager.dart';
import 'package:provider/provider.dart';

import 'components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meus Pedidos"),
      ),
      body: Consumer<OrdersManager>(
        builder: (_,ordersManager,__){
          if(ordersManager.user == null){
    return LoginCard();
    }
          if(ordersManager.orders.isEmpty){
            return EmptyCartCard(
              title: "Nenhuma Compra Encontrada",
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index){
            return OrderTile(
                  order: ordersManager.orders.reversed.toList()[index],
                );
          });
        },
      ),
    );
  }
}
