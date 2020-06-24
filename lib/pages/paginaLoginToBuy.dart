import 'package:flutter/material.dart';

class LoginToBuy extends StatefulWidget {
  @override
  _LoginToBuyState createState() => _LoginToBuyState();
}

class _LoginToBuyState extends State<LoginToBuy> {
  bool _enabled = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      top: _enabled,
      left: _enabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Text(
              "This widget is below safe area. If you remove the SafeArea "
                  "widget then this text will be behind the notch.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.indigo,
            onPressed: () => setState(() {
              _enabled == true ? _enabled = false : _enabled = true;
            }),
            child: Text(_enabled ? "Disable SafeArea" : "Enable SafeArea"),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Text(
              "This widget is above safe area",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
