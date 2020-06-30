import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/produto.dart';

class ProdutoCard extends StatelessWidget {
  final Produto produto;
  final Function delete;

  ProdutoCard({ this.produto, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.grey[700],
      margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: SafeArea(
        minimum: EdgeInsets.fromLTRB(60, 60, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'R\$ ' + produto.preco.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.amber,
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: (){},
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              produto.descricao.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}

