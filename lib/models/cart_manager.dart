import 'package:michellemirandastore/models/cart_product.dart';
import 'package:michellemirandastore/models/product.dart';

class CartManager{

  List<CartProduct> items = [];


  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }


}