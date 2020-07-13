import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/produto.dart';

class ProdutoCard extends StatelessWidget {
  final Produto produto;
  final Function delete;

  ProdutoCard({ this.produto, this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/4,
      width: MediaQuery.of(context).size.width/4,
      color: Colors.black12,

      child: Card(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                color: Colors.amber,
                child: Text('${produto.id}'),
              ),
                Text("Nome"),
                Text("Nome"),
                Text("Nome"),
                Text("Nome"),
              ],
            ),
            Text("Nome"),
            Text("Nome"),
            Text("Nome"),
            Text("Nome"),
            Text("Nome"),

          ],
        ),
      ),
    );
  }
}

