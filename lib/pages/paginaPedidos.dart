import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
class paginaPedidos extends StatefulWidget {
  @override
  _paginaPedidosState createState() => _paginaPedidosState();

}

class _paginaPedidosState extends State<paginaPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá"),
      ),
      body: Text(
        "Ola"
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}
