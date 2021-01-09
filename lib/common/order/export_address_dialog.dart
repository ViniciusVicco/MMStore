import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/address.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address address;

  ExportAddressDialog({this.address});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content:
          Text('${address.street}, ${address.number} ${address.complement}\n'
              '${address.district}\n'
              '${address.city}/${address.state}\n'
              '${address.zipCode}'),
      actions: [FlatButton(onPressed: () {

      }, child: Text("Exportar"))],
      contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 0),
    );
  }
}
