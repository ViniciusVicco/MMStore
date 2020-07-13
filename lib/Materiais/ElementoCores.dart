import 'package:flutter/material.dart';

class ElementoCores extends ChangeNotifier{
  Color corAppBar;
  Color corFundoTelas;

void setAppbarRosa(){
    corAppBar = Colors.pink;
}

void setFundoCinza(){
    corFundoTelas  = Colors.grey[800];
}

}