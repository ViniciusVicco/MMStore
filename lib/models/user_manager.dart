import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:michellemirandastore/helpers/firebase_erros.dart';
import 'User.dart';

class UserManager extends ChangeNotifier{

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      this.user = result.user;

      onSucess();
    } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async{
    final FirebaseUser currentUser = await auth.currentUser();
    if(currentUser != null){
      user = currentUser;
      print(user.uid);
      notifyListeners();
    }
  }

}
