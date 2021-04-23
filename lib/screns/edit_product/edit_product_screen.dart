import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/product.dart';
import 'package:michellemirandastore/models/productManager.dart';
import 'package:provider/provider.dart';
import 'components/confirm_dialog.dart';
import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final bool editing;

  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed('/');


      },
      child: ChangeNotifierProvider.value(
        value: product,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              editing ? 'Editar Anúncio' : 'Criar Produto',
            ),
            actions: [
              if (editing)
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<ProductManager>().delete(product);
                    Navigator.of(context).pop();
                  },
                ),
            ],
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
                        enableSuggestions: false,
                        initialValue: product.name,
                        decoration: const InputDecoration(
                          hintText: "Título",
                          border: InputBorder.none,
                        ),
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        validator: (name) {
                          if (name.length < 6) {
                            return 'Muito Curto';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (name) => product.name = name,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          'A partir de',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        product.basePrice.isInfinite
                            ? 'R\$...'
                            : 'R\$ ${product.basePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).accentColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextFormField(
                        autocorrect: false,
                        initialValue: product.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Descrição",
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        validator: (desc) {
                          if (desc.length < 10) {
                            return "Descrição muito Curta";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (desc) => product.description = desc,
                      ),
                      SizesForm(product),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<Product>(
                        builder: (_, product, __) {
                          return SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: !product.loading ? () async {
                                if(formKey.currentState.validate()){
                                  formKey.currentState.save();

                                  await product.save();

                                  context.read<ProductManager>()
                                      .update(product);

                                showDialog(context: context, builder: (_){
                                  return ConfirmDialog();
                                });
                                }
                              } : null,
             style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
  ),
                              child: product.loading
                                  ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              )
                                  : const Text(
                                'Salvar',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
