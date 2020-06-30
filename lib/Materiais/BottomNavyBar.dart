import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/CardsPedidos.dart';
import 'package:michellemirandastore/Materiais/CarrinhoDeCompras.dart';
import 'package:michellemirandastore/pages/paginaCarrinho.dart';
import 'package:michellemirandastore/pages/paginaLoginToBuy.dart';
import 'package:michellemirandastore/pages/paginaPrincipal.dart';
import 'dart:async';

class BottomNavyBar extends StatefulWidget {
  int status;

  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
  BottomNavyBar({this.status});
}


class _BottomNavyBarState extends State<BottomNavyBar> {
  int selectedIndex;
  Color backgroundColor = Colors.white;
  static Color homeColor = Colors.red;
  static Color contaColor = Colors.yellow[900];
  static Color carrinhoColor = Colors.blue;
  static Color pedidosColor = Colors.pink;




  List<NavegationItem> itens = [
    NavegationItem(Icon(Icons.home), Text('Home'), homeColor, Home()),
    NavegationItem(Icon(Icons.person), Text('Conta'), contaColor, LoginToBuy()),
    NavegationItem(Icon(Icons.shopping_cart), Text('Carrinho'), carrinhoColor, Carrinho()),
    NavegationItem(Icon(Icons.markunread_mailbox), Text('Pedidos'), pedidosColor, PedidoCard()),
  ];

  Widget _buildItem(NavegationItem item, bool isSelected){
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: double.maxFinite,
      width: isSelected? 125: 50,
      padding: isSelected? EdgeInsets.only(left: 16,right: 16): null,
      decoration: isSelected? BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: isSelected? item.cor : Colors.white
      ): null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(
                  size: 24,
                  color: isSelected? backgroundColor : Colors.black
              ),
              child: item.icon,
            ),
            isSelected ? Padding(
              padding: const EdgeInsets.only(left: 10,),
              child: isSelected? DefaultTextStyle.merge(style: TextStyle(
                  color: backgroundColor
              ), child: item.title)
                  : null,
            ) : Container()
          ],
        )
        ],
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5
        )
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
        itens.map((iten){
        var itenIndex = itens.indexOf(iten);
        if(iten.pagina == Home()){
          iten.cor = Colors.white;
        }
        return GestureDetector(
          onTap: (){
            var timer = Timer(Duration(milliseconds: 500), () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => iten.pagina), ),

);
            setState(() {
              selectedIndex = itenIndex;
            });
          },
          child: _buildItem(iten, selectedIndex == itenIndex),
        );
        }).toList(),
      ),
    );
  }
}

class NavegationItem {
  final Icon icon;
  Text title;
  Color cor;
  final Widget pagina;
  NavegationItem(this.icon, this.title, this.cor, this.pagina);
}
//home,person,cart,mail
//IconButton(
//icon: Icon(
//Icons.markunread_mailbox
//),
//onPressed: () {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => Carrinho()),
//);
//},
//)