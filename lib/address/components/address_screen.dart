import 'package:flutter/material.dart';

import 'address_card.dart';

class AdressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrega"),
        centerTitle: true,
        actions: [

        ],
      ),
      body: ListView(
        children: [
          AddressCard(

          ),
        ],
      ),
    );
  }
}
