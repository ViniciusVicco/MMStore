
import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_drawer/custom_drawer.dart';
import 'package:michellemirandastore/models/productManager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'components/product_list_tile.dart';
import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Consumer<ProductManager>(
          builder: (_,productManager,__){
            if(productManager.search.isEmpty){
              return const Text('Produtos',style: TextStyle(color: Colors.white),);
            } else{
              return LayoutBuilder(
                builder: (_,constraints){
                  return GestureDetector(
                    onTap: () async{
                      final search = await showDialog<String>(context: context, builder:  (_) => SearchDialog(productManager.search)); //Dialog aparecerá por cima da tela
                      if(search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                          productManager.search,
                          textAlign: TextAlign.center,
                      ),
                    )

                );
                },
              );
            }
          },
        ) ,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search,color: Colors.white,),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context, builder:  (_) => SearchDialog(productManager.search)); //Dialog aparecerá por cima da tela
                    if(search != null){
                      productManager.search = search;
                    }
                  },
                );
              } else {
               return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context, builder:  (_) => SearchDialog(productManager.search)); //Dialog aparecerá por cima da tela
                    if(search != null){
                      productManager.search = '';
                    }
                  },
                );
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_,userManager,__){
              if(userManager.adminEnabled){
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/edit_product');
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
              itemCount: productManager.filteredProducts.length,
              itemBuilder: (_, index){
                return ProductListTile(productManager.filteredProducts[index]); } );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}