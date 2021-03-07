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
    final HttpsCallable callable = functions.getHttpsCallable(
        functionName: 'captureCreditCard'
    );
    final response = await callable.call(captureData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

    if (data['success'] == null) {
      print("Nullo no na captura");

      if (data['success'] as bool) {
        debugPrint('Captura feita com sucesso');
      } else {
        debugPrint('${data['error']['message']}');
        return Future.error(data['error']['message']);
      }
    }
  }

  Future<void> cancel(String payId) async {
    final Map<String, dynamic> cancelData = {
      'payId': payId
    };
    final HttpsCallable callable = functions.getHttpsCallable(
        functionName: 'cancelCreditCard'
    );
    final response = await callable.call(cancelData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if(data['success'] == null){
      print("Nullo no cancelamento");
    }
    if (data['success'] as bool) {//Problema no metodo de captura, provavelmente function
      debugPrint('Cancelamento feito com sucesso');

    } else {
      debugPrint('${data['error']['message']}');
      return Future.error(data['error']['message']);
    }
  }

}