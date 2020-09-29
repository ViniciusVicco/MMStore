import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/item_size.dart';
import 'package:michellemirandastore/models/product.dart';

import 'editItemSize.dart';

class SizesForm extends StatelessWidget {
  @override
  SizesForm(this.product);
  final Product product;

  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state){
        return Column(
          children: state.value.map((size){
            return EditItemSize(

              size: size
            );
          }).toList()
        );
      },
    );
  }
}
