import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          "${"Michelli Miranda Store"}",
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
        child: Text("Olá"),
      ),
      drawer: Center(
        child: Text("-"),
      ),
      bottomNavigationBar: BottomNavyBar(

      ),
    );
  }
}
