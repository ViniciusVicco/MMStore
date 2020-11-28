import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/empty_cart_card.dart';
import 'package:michellemirandastore/common/login_card.dart';
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
          if(cartManager.user == null) {
            return LoginCard(tittle: "Carrinho",);
          }
          if(cartManager.items.isEmpty){
            return EmptyCartCard(iconData: Icons.remove_shopping_cart, title: "Nenhum Produto no Carrinho",);
          }
          return ListView(
            children: <Widget>[
              Column(
                children: cartManager.items.map((cartProduct) =>
                    CartTile(cartProduct)).toList(),
              ),
              PriceCard(buttonText: "Continuar para Entrega",
                onPressed: cartManager.isCartValid ? (){
                  Navigator.of(context).pushNamed('/address');
                } : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
