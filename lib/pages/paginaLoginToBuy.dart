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
          Container(
            height: 30,
            width: 90,
            color: Colors.blue,
            child: Row(
              children: [
                //Usar um label pra juntar texto + icone;
                Text("Logout"),
                Icon(
                  Icons.call_missed_outgoing,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.grey,
      ),
//      drawer: Center(
//        child: Text("-"),
//      ),
      bottomNavigationBar: BottomNavyBar(
      ),
    );
  }
}
