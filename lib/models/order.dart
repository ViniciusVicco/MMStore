import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:michellemirandastore/models/address.dart';
import 'package:michellemirandastore/models/cart_product.dart';

class Order{

  String orderId;
  List<CartProduct> items;
  num price;
  String userId;
  Address address;
  Timestamp date;


}