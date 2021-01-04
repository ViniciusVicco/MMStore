import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/order.dart';
import 'file:///C:/Users/vinic/AndroidStudioProjects/MMStore/lib/common/order_product_tile.dart';

class ConfirmationScreen extends StatelessWidget {

  final Order order;
  ConfirmationScreen(this.order);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${order.formattedId} Confirmado'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.formattedId,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text('R\$ ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children:
                order.items.map((e){
                  return OrderProductTile(cartProduct: e,);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
