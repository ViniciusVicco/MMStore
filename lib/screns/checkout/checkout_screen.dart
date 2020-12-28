import 'dart:math';

import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/price_card.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/checkout_manager.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void goToCartScreen() {
      Navigator.popUntil(context, (route) => route.settings.name == '/cart');
    }

    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text("Pagamento"),
            centerTitle: true,
          ),
          body: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if(checkoutManager.loading){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      const SizedBox(height: 16,),
                      Text("Processando seu pagamento...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),)
                    ],
                  ),
                );
              }
              return ListView(
                children: [
                  PriceCard(
                    buttonText: 'Finalizar Pedido',
                    onPressed: (){
                      checkoutManager.checkout(
                        onSuccess: (order){
                          //TODO: criar uma página de sucesso informando o produto e para onde ele está indo
                          Navigator.popUntil(context, (route) => route.settings.name == '/base');
                          //context.read<PageManager>().setPage(2);
                          Navigator.of(context).pushNamed('/confirmation', arguments: order);
                        },
                        onStockFail: (e) {
                          Navigator.popUntil(context, (route) => route.settings.name == '/cart');

                        }
                      );

                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
