import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:michellemirandastore/models/address.dart';

class User{
  String id;
  String email;
  String password;
  String name;
  String confirmedPassword;
  bool admin = false;
  Address address;

  User({this.id,this.email,this.password, this.name});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(
        document.data['address'] as Map<String, dynamic>);
    }
  }

  DocumentReference get firestoreRef => Firestore.instance.document('users/$id');

  CollectionReference get cartReference =>
  firestoreRef.collection('cart');

  Future<void> saveData() async{
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(address != null)
          'address' : address.toMap(),
    };
  }

  Future<void> setAddress(Address address) {
    this.address = address;
    saveData();
  }
}