import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/address.dart';
class AddressInputField extends StatelessWidget {
  @override
  final Address address;
  const AddressInputField(this.address);
  Widget build(BuildContext context) {

    String emptyValidator(String text){
      text.isEmpty ? 'Campo Obrigatório' : null;
    }

    return Column(
      children: [
        TextFormField(
          initialValue: address.streat,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av.Brasil'
          ),
          validator: emptyValidator,
          onSaved: (t) => address.streat = t,
        ),
        TextFormField(
          initialValue: address.city,
          decoration: const InputDecoration(
              isDense: true,
              labelText: 'Cidade',
              hintText: 'São Paulo'
          ),
          validator: emptyValidator,
          onSaved: (t) => address.city = t,
        ),
        TextFormField(
          initialValue: address.state,
          decoration: const InputDecoration(
              isDense: true,
              labelText: 'UF',
              hintText: 'SP'
          ),
          validator: emptyValidator,
          onSaved: (t) => address.state = t,
        ),
      ],
    );
  }
}
