import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/cart_product.dart';
class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;
  OrderProductTile({this.cartProduct});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { Navigator.of(context).pushNamed('/product', arguments: cartProduct.product);},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8 ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.network(cartProduct.product.images.first),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartProduct.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  ),
                  Text("Tamanho: ${cartProduct.size}",
                    style: TextStyle(
                        fontWeight: FontWeight.w300),
                  ),
                  Text("R\$  ${(cartProduct.fixedPrice ?? cartProduct.unitPrice.toStringAsFixed(2))}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Text("${cartProduct.quantity}",
            style: const TextStyle(
              fontSize: 20,
            ),
            )
          ],
        ),
      ),
    );
  }
}
