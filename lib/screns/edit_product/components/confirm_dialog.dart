import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Produto cadastrado!'),
      actions: [
        ElevatedButton(
               style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
    ,),
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
