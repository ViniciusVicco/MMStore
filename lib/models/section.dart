import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/section_item.dart';

class Section extends ChangeNotifier {

  Section({this.name,this.type,this.items}){
    items = items ?? [];
  }

  Section.fromDocument(DocumentSnapshot document){
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List).map(
            (item) => SectionItem.fromMap(item as Map<String, dynamic>)).toList();
  }


  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }

  String name;
  String type;
  List<SectionItem> items;

  Section clone() {
  return Section(
    name: name,
    type: type,
    items: items.map((i) => i.clone()).toList(), // Para cada item, se faz um clone
  );
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
    
  }
}

