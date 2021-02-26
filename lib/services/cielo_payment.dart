import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:michellemirandastore/models/credit_card.dart';
import 'package:michellemirandastore/models/user.dart';

class CieloPayment {

  final CloudFunctions functions = CloudFunctions.instance;

  Future<String> autorize({CreditCard creditCard, num price, String orderId, User user}) async {
    try {
      final Map<String, dynamic> dataSale = {
        'merchantOrderId': orderId,
        'amount': (price * 100).toInt(),
        'softDescriptor': 'MM Store',
        'installments': 1,
        'creditCard': creditCard.toJson(),
        'cpf': user.cpf,
        'paymentType': 'CreditCard',
      };
      final HttpsCallable callable = functions.getHttpsCallable(
          functionName: 'authorizeCreditCard');

      final response = await callable.call(dataSale);
      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
      if (data['sucess'] as bool) {
        return data['paymentId'] as String;
      } else {
        return Future.error(data['error']['message']);
      }
    } catch (e){
      debugPrint('$e');
      return Future.error('Falha ao processar transação. Tente novamente');
    }
  }

  Future<void> capture(String payId) async {
    final Map<String, dynamic> captureData = {
      'payId': payId
    };
    final HttpsCallable callable = functions.getHttpsCallable(functionName: 'captureCreditCard');
    final response = await callable.call(captureData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['sucess'] as bool) {
      return;
    } else {
      return Future.error(data['error']['message']);
    }
  }

}