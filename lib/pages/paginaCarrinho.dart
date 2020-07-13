import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/AppBarNativa.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
class Carrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNativa(Colors.pinkAccent),
      body: Container(
        constraints: BoxConstraints.expand(),
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

              ],
            )
          ),
      bottomNavigationBar: BottomNavyBar(
      ),
    );
  }
}

