import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/user.dart';

import 'order.dart';

class AdminOrdersManager extends ChangeNotifier{
  User user;

  final List<Order> _orders = [];

  User userFilter;
  
  List<Status> statusFilter = [Status.preparing];
  

  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateAdmin({bool adminEnabled}){
    _orders.clear();

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
                _orders.add(Order.fromDocument(change.document));
                break;
              case DocumentChangeType.modified:
                final modOrder = _orders.firstWhere((o) => o.orderId == change.document.documentID);
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

  void setUserFilter(User user){
    userFilter = user;
    notifyListeners();
  }
  List<Order> get filteredOrders{
    List<Order> output = _orders.reversed.toList();
    //TODO: Adicione Filtros aqui
    if(userFilter != null){
      output = output.where((o) => o.userId == userFilter.id).toList();
    }

      output = output.where((o) => statusFilter.contains(o.status)).toList();

    
    return output;
  }

  @override
  void dispose(){
    super.dispose();
    _subscription?.cancel();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if(enabled) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

}
