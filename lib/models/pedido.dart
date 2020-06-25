import 'package:michellemirandastore/models/produto.dart';

class Pedido {
  int id;
  String numeroPedido;
  String status;
  double valor;
  List<Produto> listaDeProdutos = [];

  Pedido({this.id,this.numeroPedido,this.status,this.valor,this.listaDeProdutos});
}