import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/product.dart';

class ProductManager extends ChangeNotifier{
  ProductManager(){
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> _allProducts = [];

  Future<void> _loadAllProducts() async{
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
    _allProducts = snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();
    // Estou pegando cada um dos meus documentos, colocando na variável doc e depois transformando em uma lista de produtos.
    notifyListeners();
  }

}