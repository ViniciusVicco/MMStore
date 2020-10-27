import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '77.777-777'
          ),
          // Bloqueando caracteres:
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
        ),
        RaisedButton(
          onPressed: () {

          },
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text(
            'Buscar Cep',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}
