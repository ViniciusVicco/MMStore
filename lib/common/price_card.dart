import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:provider/provider.dart';
class PriceCard extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const PriceCard({this.buttonText,this.onPressed});

  @override
  Widget build(BuildContext context) {

    final cartManager = context.watch<CartManager>();

    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Resumo do Pedido",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight:  FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Subtotal'),
                Text('${productsPrice.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Total'),
                Text(
                    '${productsPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            cartManager.productsPrice == 0 ?
                Text("Sem produtos, por favor adicione produtos.",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),):
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
                onPressed: onPressed,
              disabledColor: Colors.pink[100],
              child: Text(
                  "$buttonText",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
