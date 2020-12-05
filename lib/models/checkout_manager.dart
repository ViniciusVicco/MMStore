import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/product.dart';

class CheckoutManager extends ChangeNotifier{

  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
    print(cartManager.productsPrice);
  }

  Future<void> checkout() async{
    try {
      _decrementStock();
    } catch(e){
      debugPrint(e.toString());
    }

    _getOrderId().then((value) => print(value));
  }

  Future<int> _getOrderId() async{
    final ref = firestore.document('aux/ordercounter');
    try {
      final result = await firestore.runTransaction((transacao) async {
        final doc = await transacao.get(ref); // 4
        final orderId = doc.data['current'] as int; // 4
        await transacao.update(ref, {'current': orderId + 1}); // 4+1 (5)
        //Por meio da transação ele tenta garantir o valor correto dos dados recuperados.
        return {'orderId': orderId};
      }, timeout: const Duration(seconds: 10));
      return result['orderId'] as int;
    } catch(e){
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock(){
    // 1. Ler todos os estoques 3xM	    // 1. Ler todos os estoques 3xM
    // 2. Decremento localmente os estoques 2xM	    // 2. Decremento localmente os estoques 2xM
    // 3. Salvar os estoques no firebase 2xM	    // 3. Salvar os estoques no firebase 2xM

    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for(final cartProduct in cartManager.items){

        Product product;

        if(productsToUpdate.any((p) => p.id == cartProduct.productId)){
          product = productsToUpdate.firstWhere(
                  (p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(
              firestore.document('products/${cartProduct.productId}')
          );
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if(size.stock - cartProduct.quantity < 0){
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }

        cartProduct.product = product;

      }

      if(productsWithoutStock.isNotEmpty){
        return Future.error(
            '${productsWithoutStock.length} produtos sem estoque');
      }

      for(final product in productsToUpdate){
        tx.update(firestore.document('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });

  }


}