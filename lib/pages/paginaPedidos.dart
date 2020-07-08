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
                        fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey,
      ),
      bottomNavigationBar: BottomNavyBar(),
    );
  }
}
