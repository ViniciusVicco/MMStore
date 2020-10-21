import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {

  Section({this.id,this.name,this.type,this.items}){
    items = items ?? [];
    originalItems = List.from(items);
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List).map(
            (item) => SectionItem.fromMap(item as Map<String, dynamic>)).toList();
  }


  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }

  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  // Referencias do FireBase:
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('home/$id'); // Faz a referencia ao documento do FireBase puxando a coleção home + id do documento.
  StorageReference get storageRef =>  storage.ref().child('home/$id');


  String _error;

  String get error => _error;

  set error(String value){
    _error = value;
    notifyListeners();
  }

  Section clone() {
  return Section(
    id: id,
    name: name,
    type: type,
    items: items.map((i) => i.clone()).toList(), // Para cada item, se faz um clone
  );
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
    
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();

  }



  Future<void> save() async {
    final Map<String, dynamic> data = {

      "name":name,
      "type":type,
    };

      if(id == null){
        final doc = await firestore.collection('home').add(data); // adiciona a data, caso o id seja nullo, Data -> já mapeada
        id = doc.documentID; // após adicionar, pega o id do documento e coloca dentro do id.
      } else {
        await firestoreRef.updateData(data);
      }

      for(final item in items){
        if(item.image is File){
          final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(item.image as File);
          final StorageTaskSnapshot snapshot = await task.onComplete;
          final String url = await snapshot.ref.getDownloadURL() as String;
          item.image = url;
        }
      }

      for(final original in originalItems){
        if(!items.contains(original)){
          try {
            final ref = await storage.getReferenceFromUrl(
                original.image as String
            );
            await ref.delete();
          } catch (e) {}
        }
      }
    final Map<String, dynamic> itemsData = {
        'items': items.map((e) => e.toMap()).toList(),
    };
      await firestoreRef.updateData(itemsData);
  }

  bool valid(){
    if(name == null || name.isEmpty){
      error = 'Título inválido';
    } else if(items.isEmpty){
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }
    return error == null;
  }

//  List<Map<String,dynamic>> exportItemsList() {
//    return items.map((item) => item.toMap()).toList();
//  }


}



