import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/order.dart';

class OrderTile extends StatelessWidget {

  @override
  const OrderTile({this.order});
  final Order order;
  Widget build(BuildContext context) {
    final primaryCollor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.formattedId,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryCollor,
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
            Text('Em Transporte',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: primaryCollor,
              fontSize: 14
            ),)
          ],
        ),
      ),
    );
  }
}
