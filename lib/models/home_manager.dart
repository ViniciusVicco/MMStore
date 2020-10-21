import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/section.dart';
import 'package:michellemirandastore/models/user_manager.dart';

class HomeManager extends ChangeNotifier {

  HomeManager(){
    _loadSections();
  }

  final List<Section> _sections = [];

  List<Section> _editingSections = [];

  bool editing = false;

  final Firestore firestore = Firestore.instance;

  List<Section> get sections {
    if(editing)
      return _editingSections;
    else
      return _sections;
  }

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) { // snapshots.listen -> faz com que fique ouvindo a qualquer momento as atualizações
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _sections.add(Section.fromDocument(document));
      }
      print(_sections);
      notifyListeners();
    });
  }

  void enterEditting(){
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }

  void saveEditing() async{
    bool valid = true;
    for(final section in _editingSections){
      if(!section.valid()) valid = false;
    }
    if(!valid) return;

    print("Salvo");

    for(final section in _editingSections){
      await section.save();
    }
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }

}