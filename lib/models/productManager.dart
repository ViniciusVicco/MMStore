import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/product.dart';

class ProductManager extends ChangeNotifier{
  ProductManager(){
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  String _search = '';
  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts{
    final List<Product> filteredProducts = [];
    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  void update(Product product){
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  Future<void> _loadAllProducts() async{
    final QuerySnapshot snapProducts = await firestore.collection('products').where('deleted', isEqualTo: false).getDocuments();
    allProducts = snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();
    // Estou pegando cada um dos meus documentos, colocando na variável doc e depois transformando em uma lista de produtos.
    notifyListeners();
  }

  Product findProductById(String id){
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e){
      return null;
    }
  }

  void delete(Product product) {
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

}