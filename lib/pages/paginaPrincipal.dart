import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/CardsProduto.dart';
import 'package:michellemirandastore/pages/paginaLoginToBuy.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
import 'package:michellemirandastore/models/produto.dart';
import 'package:michellemirandastore/models/pedido.dart';


//Teste Booleano _enabled == true ? _enabled = false : _enabled = true;

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Titulo",
      home: HomePage(titulo: "Michelli Miranda Store",),
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

  ];

  List<Pedido> listaDePedidos = [

  ];


  Widget cardProdutos(produto){
    return ListView(

    );
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
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
            Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => LoginToBuy()),
            );
            },
          )
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: listaDeProdutos.map((produto) => ProdutoCard(
          produto: produto,
    delete: ()  {
    setState(() {
    listaDeProdutos.remove(produto);
    });
    }
    )).toList()


        ),
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}




