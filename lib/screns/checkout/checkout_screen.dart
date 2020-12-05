import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/price_card.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/checkout_manager.dart';
import 'package:provider/provider.dart';
class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pagamento"),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __){
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: () {
                    checkoutManager.checkout();
                  },
                )
              ],
            );
          },
        )
      ),
    );
  }
}
