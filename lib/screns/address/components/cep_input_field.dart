import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/address.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  final Address address;

  final TextEditingController cepController = TextEditingController();

  CepInputField(this.address);

  @override
  Widget build(BuildContext context) {
    if (address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CEP', hintText: '77.777-777'),
            keyboardType: TextInputType.number,
            // Aqui muda o teclado pro tipo de númeral 1,2,3 . /
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo Obrigatorio';
              } else if (cep.length != 10) {
                return 'Cep Inválido';
              }
              return null;
            },
            // Bloqueando caracteres:
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              // Aqui só permite a entrada de digitos: 1 , 2 , a ,c d
              CepInputFormatter(),
              // Aqui é a mascara p/ o Cep
            ],
          ),
          RaisedButton(
            onPressed: () {
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(cepController.text);
                print(cepController.text);
              }
            },
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Buscar Cep',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              size: 24,
              color: Theme.of(context).primaryColor,
              onTap: () {
                context.read<CartManager>().removeAddres();
              },
            )
          ],
        ),
      );
    }
  }
}
