import 'dart:io';

import 'package:dio/dio.dart';

//Token p/Api de cepAberto
const token = '1cef423c043c4110455763c3cb48fb8a';

class CepAbertoService {

  Future<void> getAddressFromCep(String cep) async{
    // Como eliminar pontos e traços do cep:
    final cleanCep = cep.replaceAll('.','').replaceAll('-', '');
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try{
      final response = await dio.get<Map>(endPoint); // Map porque retorna um map de strings, numeros objetos etc.
      if(response.data.isEmpty){
        return Future.error('Cep Inválido');
      }
      print(response.data);
    } on DioError catch (e){
    return Future.error('Erro ao buscar Cep');
    }


  }
}