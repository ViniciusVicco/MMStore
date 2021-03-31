import 'package:flutter/material.dart';

class EmptyCartCard extends StatelessWidget {

  const EmptyCartCard({this.title, this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: 80.0,
            color: Colors.white,
          ),
          const SizedBox(height: 16.0,),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text("Selecionar Produtos", style: TextStyle(color: Colors.black),),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
            onPressed: () { Navigator.of(context).pushNamed('/products');}
          )
        ],
      ),
    );
  }
}