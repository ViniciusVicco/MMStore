import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/admim_users_manager.dart';
import 'package:michellemirandastore/models/cart_manager.dart';
import 'package:michellemirandastore/models/home_manager.dart';
import 'package:michellemirandastore/models/productManager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/screns/base_screen.dart';
import 'package:michellemirandastore/screns/cart/cart_screen.dart';
import 'package:michellemirandastore/screns/edit_product/edit_product_screen.dart';
import 'package:michellemirandastore/screns/login/login_screen.dart';
import 'package:michellemirandastore/screns/product/product_screen.dart';
import 'package:michellemirandastore/screns/select_product/select_product_screen.dart';
import 'package:michellemirandastore/screns/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'address/components/address_screen.dart';
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
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'MM Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,//Para barras
          scaffoldBackgroundColor: Colors.red[200], //Para o fundo de telas
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
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AdressScreen()
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

