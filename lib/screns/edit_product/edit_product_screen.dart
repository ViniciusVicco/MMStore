import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/product.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;



  EditProductScreen(this.product);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final primaryCollor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Editar Anúncio',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                      hintText: "Título",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                    validator: (name){
                      if(name.length<6){
                        return 'Muito Curto';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4,bottom: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Descrição",
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (desc){
                      if(desc.length<10){
                        return "Descrição muito Curta";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizesForm(product),
                  RaisedButton(
                    onPressed: (){
                      if(formKey.currentState.validate()){
                        print("Valido");
                      } else {
                        print("Invalido");
                      }

                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            ),
            TextFormField(
            )
          ],
        ),
      ),
    );
  }
}
