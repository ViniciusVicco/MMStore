import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/common/empty_cart_card.dart';

import 'package:michellemirandastore/common/order_tile.dart';
import 'package:michellemirandastore/models/admin_orders_manager.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todos Os Pedidos"),
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          final filteredOrders = ordersManager.filteredOrders;
          if (filteredOrders.isEmpty) {
            return EmptyCartCard(
              title: "Nenhuma Venda Realizada",
              iconData: Icons.backpack_outlined,
            );
          }
          return Column(
            children: [
              SizedBox(height: 30,),
              if(ordersManager.userFilter != null)
              //TODO: inserir as coisas com padding aqui
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Pedidos de ${ordersManager.userFilter.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      iconData: Icons.close,
                      color: Colors.white,
                      onTap: () {
                        ordersManager.setUserFilter(null);
                      },
                    )
                  ],
                ),
              ),
              if(filteredOrders.isEmpty)
                Expanded(
                  child: EmptyCartCard(
                    title: "Nenhuma Venda Realizada",
                    iconData: Icons.border_clear,
                  ),
                )
              else
              Expanded(
                child: ListView.builder(
                    itemCount: ordersManager.filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrderTile(
                        order: filteredOrders[index],
                        showControls: true,
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
