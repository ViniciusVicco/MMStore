import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  EditProductScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Anúncio',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(product),
          TextFormField(
          )
        ],
      ),
    );
  }
}
