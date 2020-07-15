import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/AppBarNativa.dart';
import 'package:michellemirandastore/Materiais/BottomNavyBar.dart';

class LoginToBuy extends StatefulWidget {
  get titulo => null;

  @override
  _LoginToBuyState createState() => _LoginToBuyState();
}

class _LoginToBuyState extends State<LoginToBuy> {
  bool _enabled = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNativa(),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
      ),
//      drawer: Center(
//        child: Text("-"),
//      ),
      bottomNavigationBar: BottomNavyBar(
      ),
    );
  }
}
