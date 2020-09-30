import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/item_size.dart';
import 'package:michellemirandastore/models/product.dart';

import 'editItemSize.dart';

class SizesForm extends StatelessWidget {
  @override
  SizesForm(this.product);
  final Product product;

  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
    initialValue: List.from(product.sizes),
    builder: (state){
      return Column(
        children:[
          Row(
              children:[
                Expanded(//Expande ao máximo o widget filho
                  child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: (){
                    state.value.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ]
          ),
          Column(
          children: state.value.map((size){
            return EditItemSize(
              onRemove: (){
                state.value.remove(size);
                state.didChange(state.value);
              },
              size: size
            );
          }).toList()
        ),
      ]
      );
    },
      );
  }
}
