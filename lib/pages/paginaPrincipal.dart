import 'package:flutter/material.dart';
import 'package:michellemirandastore/Models/ProdutoClass.dart';
import 'package:michellemirandastore/pages/paginaLoginToBuy.dart';


class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Titulo",
      home: HomePage(titulo: "MeuApp",),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.titulo}) : super(key: key);

  final String titulo;


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 0;

  List<Produto> listaDeProdutos = [
    Produto(id: 1,preco: 65.0,estoque: 20,descricao: "Camisa Vermelha",marca: "PACO"),
    Produto(id: 2,preco: 130.0,estoque: 10,descricao: "Calça Azul",marca: "PACO"),
    Produto(id: 2,preco: 32.0,estoque: 10,descricao: "Regata Branca",marca: "PACO"),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.titulo}",
          style: TextStyle(
            fontFamily: "Pacifico",

          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: listaDeProdutos.map((listaProdutos) => Container(
              child: Text(
                "${listaProdutos.preco}"
              ),
          )).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}



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
          )
//          Icon(Icons.home),
//          Icon(Icons.favorite_border),
//          Icon(Icons.search),
//          Icon(Icons.person),
        ],
      ),
    );
  }
}
