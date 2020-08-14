import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/productManager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/screns/base_screen.dart';
import 'package:michellemirandastore/screns/cart/cart_screen.dart';
import 'package:michellemirandastore/screns/login/login_screen.dart';
import 'package:michellemirandastore/screns/product/product_screen.dart';
import 'package:michellemirandastore/screns/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override



  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        Provider(
          create: (_) => CartManager(),
          lazy: false,
        ),
      ],
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
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen()
              );
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product
                )
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}

