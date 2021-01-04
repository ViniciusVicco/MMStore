import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/user.dart';

import 'order.dart';

class AdminOrdersManager extends ChangeNotifier{
  User user;

  List<Order> orders = [];

  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateAdmin({bool adminEnabled}){
    orders.clear();

    _subscription?.cancel();
    if(adminEnabled){
      _listenToOrders();
    }
  }

  void _listenToOrders(){
    _subscription = firestore.collection('orders').snapshots().listen(
            (event) {
          for(final change in event.documentChanges){
            switch(change.type){
              case DocumentChangeType.added:
                orders.add(Order.fromDocument(change.document));
                break;
              case DocumentChangeType.modified:
                final modOrder = orders.firstWhere((o) => o.orderId == change.document.documentID);
                modOrder.updateFromDocument(change.document);
                break;
              case DocumentChangeType.removed:
                debugPrint("Erro Sério de Remoção de arquivo!!!");
                break;

            }
          }
          notifyListeners();
        });
  }

  @override
  void dispose(){
    super.dispose();
    _subscription?.cancel();
  }

}
