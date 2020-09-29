import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  @override
  const EditItemSize({this.size});
  final ItemSize size;

  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: size.name,
              decoration: InputDecoration(
                labelText: 'Titulo',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            child: TextFormField(
              initialValue: size.stock.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Estoque',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              initialValue: size.price.toStringAsFixed(2),
              decoration: InputDecoration(
                labelText: 'Preço',
                isDense: true,
              ),
            ),
          ),
        ],
    );
  }
}
