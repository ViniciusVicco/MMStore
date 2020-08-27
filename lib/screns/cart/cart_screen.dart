import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/price_card.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __){
          if(context.read<UserManager>().isLoggedIn) {

            return ListView(
              children: <Widget>[
                Column(
                children: cartManager.items.map((cartProduct) =>
                    CartTile(cartProduct)).toList(),
              ),
                PriceCard(buttonText: "Continuar para Entrega",
                onPressed: cartManager.isCartValid ? (){} : null,
                ),
              ],
            );
          } else {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Por favor Faça Login para ver seu carrinho",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20)),
                      color: Theme.of(context).primaryColor,
                      child: Text(""
                          "Clique Aqui para efetuar Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                    )
                  ],
                ),
            );
          }
        },
      ),
    );
  }
}
