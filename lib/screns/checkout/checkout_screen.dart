import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/price_card.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/checkout_manager.dart';
import 'package:michellemirandastore/models/credit_card.dart';

import 'package:provider/provider.dart';

import 'components/cpf_field.dart';
import 'components/credit_card_widget.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CreditCard creditCard = CreditCard();

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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Consumer<CheckoutManager>(
              builder: (_, checkoutManager, __) {
                if (checkoutManager.loading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Processando seu pagamento...",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      CreditCardWidget(creditCard),
                      CpfField(),
                      PriceCard(
                          buttonText: 'Finalizar Pedido',
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              print(creditCard);
                              checkoutManager.checkout(
                                  creditCard: creditCard,
                                  onSuccess: (order) {
                                    Navigator.popUntil(context,
                                        (route) => route.settings.name == '/');
                                    Navigator.of(context).pushNamed(
                                        '/confirmation',
                                        arguments: order);
                                  },
                                  onPayFail: (e){
                                    if(!(e == null))
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("$e"),
                                        backgroundColor: Colors.red,
                                      )
                                    );
                                  },
                                  onStockFail: (e) {
                                    goToCartScreen();
                                  });
                            }
                          })
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
