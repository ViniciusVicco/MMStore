import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/AppBarNativa.dart';
import 'package:michellemirandastore/Materiais/CardsProduto.dart';

import 'package:michellemirandastore/pages/paginaLoginTrue.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
import 'package:michellemirandastore/models/produto.dart';
import 'package:michellemirandastore/models/pedido.dart';
import 'package:provider/provider.dart';


//Teste Booleano _enabled == true ? _enabled = false : _enabled = true;

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(titulo: "Michelle Miranda Store",),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 4, 125, 141),//Para barras
        scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141), //Para o fundo de telas
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.pink
        )
      ),


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
    Produto(id: 2,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 3,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 4,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 5,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 6,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 7,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
    Produto(id: 8,marca: "PACO",descricao: "Blusa Azul", estoque: 30,preco: 60,categoria: Categoria.roupas,imagem: Image.network('https://picsum.photos/250?image=9',)),
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
      appBar: AppBarNativa(),
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

//ToDO -> Criar uma página para os tipos de card, por exemplo um drawer para roupas e camisas etc, passar por parametro o tipo do card ex: cards de roupas, acessórios etc.