import 'package:flutter/material.dart';
import 'package:michellemirandastore/pages/paginaCarrinho.dart';
import 'package:michellemirandastore/pages/paginaLoginToBuy.dart';
class BottomNavyBar extends StatefulWidget {
  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 56,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginToBuy()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Carrinho()),
              );
            },
          )
        ],
      ),
    );
  }
}