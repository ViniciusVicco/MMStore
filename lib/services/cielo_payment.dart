import 'package:cloud_functions/cloud_functions.dart';
import 'package:michellemirandastore/models/credit_card.dart';
import 'package:michellemirandastore/models/user.dart';

class CieloPayment {

  final CloudFunctions functions = CloudFunctions.instance;

  void autorize({CreditCard creditCard, num price, String orderId, User user}) async{
    final Map<String, dynamic> dataSale = {
      'merchantOrderId': orderId,
      'amount': (price*100).toInt(),
      'softDescriptor': 'MM Store',
      'installments': 1,
      'creditCard': creditCard.toJson(),
      'cpf': user.cpf,
      'paymentType': 'CreditCard',
    };
    final HttpsCallable callable = functions.getHttpsCallable(functionName: 'autorizeCreditCard');
    final response = await callable.call(dataSale);
    print(response.data);
  }

}