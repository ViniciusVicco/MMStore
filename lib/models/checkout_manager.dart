import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier{

  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
    print(cartManager.productsPrice);
  }

  void checkout() {
    _decrementStock();
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

  void _decrementStock(){
    // 1 - Ler todos os estoques.
    // 2 - Se meu estoque for valido, decremento localmente.
    // 3 - Salvar os estoques no Firebase.


  }


}