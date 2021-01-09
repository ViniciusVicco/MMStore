import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/order.dart';

class CancelOrderDialog extends StatelessWidget {
  final Order order;

  CancelOrderDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cancelar ${order.formattedId} ?"),
      content: const Text("Essa ação não poderá ser desfeita!"),
      actions: [
        FlatButton(
            onPressed: () {
              order.cancel();
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar Pedido")),
      ],
    );
  }
}
