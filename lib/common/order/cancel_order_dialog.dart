import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/order.dart';

class CancelOrderDialog extends StatefulWidget {
  final Order order;

  CancelOrderDialog(this.order);

  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text("Cancelar ${widget.order.formattedId} ?"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                loading ? "Cancelando..." : "Essa ação não poderá ser desfeita!"),
            if(error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error,style: TextStyle(color: Colors.red),),
              ),

          ],
        ),
        actions: [
          TextButton(
              onPressed: loading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: const Text("Voltar")),
          TextButton(
              onPressed: loading
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await widget.order.cancel();
                        setState(() {
                          loading = false;
                        });
                        Navigator.of(context).pop();
                      } catch (e) {
                        setState(() {
                          loading = false;
                          error = e.toString();
                        });
                      }

                    },
              child: const Text("Cancelar Pedido",style: TextStyle(color: Colors.red),)),
        ],
      ),
    );
  }
}
