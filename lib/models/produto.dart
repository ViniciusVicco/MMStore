import 'package:flutter/cupertino.dart';

enum Categoria {todos, acessorios, roupas, calcados}
class Produto{
  int id;
  double preco;
  int estoque;
  String descricao;
  String marca;
  Categoria categoria;
  Image imagem;
  Produto({this.id,this.preco,this.estoque,this.descricao,this.marca,this.categoria,this.imagem});

}