import 'package:cloud_firestore/cloud_firestore.dart';
class Product{
  // Mapeamento dos dados

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
  }

  String id;
  String name;
  String description;
  List<String> images;
}