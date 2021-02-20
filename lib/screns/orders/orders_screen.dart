import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/common/empty_cart_card.dart';
import 'package:michellemirandastore/common/login_card.dart';
import 'package:michellemirandastore/common/order/order_tile.dart';
import 'package:michellemirandastore/models/orders_manager.dart';
import 'package:provider/provider.dart';



class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
              title: "Nenhuma Pedido Encontrado",
              iconData: Icons.backpack_outlined,
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ordersManager.orders.length,
                  itemBuilder: (_, index){
                  return OrderTile(
                        order: ordersManager.orders.reversed.toList()[index],
                    showControls: false,
                      );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
