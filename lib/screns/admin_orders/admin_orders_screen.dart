import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/common/empty_cart_card.dart';

import 'package:michellemirandastore/common/order_tile.dart';
import 'package:michellemirandastore/models/admin_orders_manager.dart';
import 'package:michellemirandastore/models/order.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatelessWidget {
  final PanelController panelController = PanelController();
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
          return SlidingUpPanel(
            controller: panelController,
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                if (ordersManager.userFilter != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pedidos de ${ordersManager.userFilter.name}',
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
                if (filteredOrders.isEmpty)
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
                const SizedBox(height: 120,),
              ],
            ),
            minHeight: 40,
            maxHeight: 240,
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: (){
                    if(panelController.isPanelClosed){
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 40,
                    constraints: const BoxConstraints.expand(height: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Status.values.map((s){
                      return CheckboxListTile(
                        title: Text(Order.getStatusText(s)),
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        value: ordersManager.statusFilter.contains(s),
                        onChanged: (v){
                          ordersManager.setStatusFilter(
                            status: s,
                            enabled: v,
                          );
                        },
                      );
                    }).toList()
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
