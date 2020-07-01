import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
class Carrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Titulo"
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 30,
                  color: Colors.amber,
                  child: Text(
                    "-"
                  ),
                )
              ],
            )
          ),
      bottomNavigationBar: BottomNavyBar(
      ),
    );
  }
}

