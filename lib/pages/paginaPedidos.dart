import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/AppBarNativa.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';
class paginaPedidos extends StatefulWidget {
  @override
  _paginaPedidosState createState() => _paginaPedidosState();

}

class _paginaPedidosState extends State<paginaPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNativa(),
      body: Container(
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}
