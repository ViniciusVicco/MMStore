
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'item_size.dart';

class Product extends ChangeNotifier {
  
  Firestore firestore = Firestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  Product({this.id,this.sizes,this.images,this.name,this.description}){
    images = images ?? [];
    sizes = sizes?? [];
  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    sizes = (document.data['sizes'] as List<dynamic> ?? []).map((s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();

    print(sizes);
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  List<dynamic> newImages;

  //TODO: Como exportar uma lista de Map de objeto (size)
  List<Map<String, dynamic>> exportSizeList(){
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async{ // Para se enviar dados (salvar no Firebase)
    //TODO: Primeiro passo é transformar em um mapa:
    final Map<String, dynamic> data = {
      'name':name,
      'description':description,
      'sizes':exportSizeList(),

    };

    if(id == null){ // Caso não exista será adicionado novos dados
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else { // Caso os dados já existam ele será atualizado  update -> atualiza/ setData -> sobrescreve
      await firestoreRef.updateData(data);
    }
    // Images [URL1, URL2, URL3,] - Removeu 1
    // Ficou : NEWImages [Url2, Url3]
    //TODO: Checar quais imagens adicionou
    //TODO: Checar quais imagens removeu
    // UPATED[] -> Atualizar cada um que ficou atualizado
    // Manda File1 pro Storage -> Link será FURL 1 (F porque é arquivo).
    // MANDA FILE2 pro Storage - > FURL2
    // Verificar quais imagens foram removidas para poder remover no FIREBASE
    // Excluir imagens que são do Images mas não estão contidas no New Images.

    // Images[ URl1, Url2, URL3]
    // NewImages [ Url3, File1]
    // Manda cada arquivo para o storage, daí ele retorna um tipo de URL e adapta o arquivo ao url
    // UpdatedLista[Url3, UrlFile1]
    final List<String> updateImages = [];
    for(final newImage in newImages){
      if(images.contains(newImage)){ // Verificou se o File1 não estava nas imagens anteriores
        updateImages.add(newImage as String);
      }
      else{
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File); // Mandou-se o file1 para o Storage
        final StorageTaskSnapshot snapshot = await task.onComplete; // Criou a task de envio
        final String url = await snapshot.ref.getDownloadURL() as String; // Buscou a url para downlaod do Storage
        updateImages.add(url); // adicionou-se a url na lista
      }
    }
    for(final image in images){
      if(!newImages.contains(image)){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) { debugPrint("Falha ao deletar $image");}
      }
    }

    firestoreRef.updateData({'images' : updateImages});
  }

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value){
    _selectedSize = value;
    print(_selectedSize);
    notifyListeners();
  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes){
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock{
    return totalStock > 0;
  }

  num get basePrice{
    num lowest = double.infinity;
    for(final size in sizes){
      if(size.price < lowest && size.hasStock)
        lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      print("tamanho não encontrado");
      return null;
    }
  }

  Product clone(){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }

}