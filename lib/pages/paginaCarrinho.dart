import 'package:flutter/material.dart';
class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
    body: SafeArea(
      minimum: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
              child: Text(
                ''
              ),
            )
          ],
        ),
      ),
    );
  }
}
