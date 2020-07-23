import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/screns/base_screen.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override



  Widget build(BuildContext context) {
    
    return Provider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'MM Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,//Para barras
          scaffoldBackgroundColor: Colors.pink, //Para o fundo de telas
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen()
      ),
    );
  }
}

