import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/product.dart';

class ImagesForm extends StatelessWidget {
  Product product;
  ImagesForm(this.product);
  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state){

      }
    );
  }
}
