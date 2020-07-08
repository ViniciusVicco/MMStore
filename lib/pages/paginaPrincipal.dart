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

      home: HomePage(titulo: "Michelle Miranda Store",),
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
    Produto(id: 1,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 1,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 1,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 1,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
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
          "${"Michelli Miranda Store"}",
          style: TextStyle(
            fontFamily: "Pacifico",

          ),
        ),
        actions: [
          Container(
            height: 30,
            width: 90,
            color: Colors.blue,
            child: Row(
              children: [
                //Usar um label pra juntar texto + icone;
                FlatButton.icon(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  onPressed: () {},
                  icon: Icon(Icons.call_missed_outgoing,
                    color: Colors.white,),
                  label: Text("Logout",
                    style: TextStyle(color: Colors.white,
                        fontFamily: "Pacifico",
                        fontSize: 15
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: ListView(
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




