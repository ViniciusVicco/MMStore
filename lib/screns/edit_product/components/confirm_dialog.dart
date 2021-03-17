import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Produto cadastrado!'),
      actions: [
        FlatButton(
          textColor: Colors.blue,
          onPressed: (){
            Navigator.of(context).pushNamed('/');
          },
          child: Text(
            "Ok",
          ),
        ),

      ],
    );
  }
}
