import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  @override
  const EditItemSize({Key key,this.size,this.onRemove,this.onMoveDown,this.onMoveUp}) : super(key:key); // Key serve pra identificar um elemento na árvore
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown; // Tipo callback para executar um método

  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex: 30,
            child: TextFormField(
              validator: (name){
                if(name.isEmpty){
                  return 'Invalido';
                } else{
                  return null;
                }
              },
              onChanged: (name) => size.name = name,
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
              validator: (stock){
                if(stock.isEmpty|| int.tryParse(stock) == null){
                  return 'Invalido';
                } else {
                  return null;
                }
              },
              onChanged: (stock) => size.stock = int.tryParse(stock),
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
              validator: (price){
                if(price.isEmpty||double.tryParse(price) == null){
                  return 'Invalido';
                } else{
                  return null;
                }
              },
              onChanged: (price) => size.price = num.tryParse(price),
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
            onTap: onMoveUp,
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_down,
            color: Colors.black,
            onTap: onMoveDown,
          ),
        ],
    );
  }
}
