import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/address.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final address = cartManager.address ?? Address();
            print(address);
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço De Entrega',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  CepInputField(address),
                  if(address.zipCode != null) // Checa se o cep ta nulo pra chamar a tela de inserircamposdeendereço
                    AddressInputField(address),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
