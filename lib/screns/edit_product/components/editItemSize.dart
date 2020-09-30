import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  @override
  const EditItemSize({this.size,this.onRemove});
  final ItemSize size;
  final VoidCallback onRemove;

  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex: 30,
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
            flex: 30,
            child: TextFormField(
              initialValue: size.stock?.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Estoque',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            flex: 40,
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              initialValue: size.price?.toStringAsFixed(2),
              decoration: InputDecoration(
                labelText: 'Preço',
                isDense: true,
                prefix: Text('R\$'),
              ),
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Colors.red,
            onTap: () {
              onRemove();
            },
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_up,
            color: Colors.black,
            onTap: () {},
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_down,
            color: Colors.black,
            onTap: () {},
          ),
        ],
    );
  }
}
