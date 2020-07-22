import 'package:flutter/material.dart';
import 'package:michellemirandastore/Materiais/CardsPedidos.dart';
import 'package:michellemirandastore/Materiais/CarrinhoDeCompras.dart';
import 'package:michellemirandastore/pages/paginaCarrinho.dart';
import 'package:michellemirandastore/pages/paginaLoginFalse.dart';
import 'package:michellemirandastore/pages/paginaLoginTrue.dart';
import 'package:michellemirandastore/pages/paginaPedidos.dart';
import 'package:michellemirandastore/pages/paginaPrincipal.dart';
import 'dart:async';

class BottomNavyBar extends StatefulWidget {


  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();

}


class _BottomNavyBarState extends State<BottomNavyBar> {
  int selectedIndex;
  static PageController pageController = PageController();
  Color backgroundColor = Colors.white;
  static Color homeColor = Colors.red;
  static Color contaColor = Colors.yellow[900];
  static Color carrinhoColor = Colors.blue;
  static Color pedidosColor = Colors.pink;




  List<NavegationItem> itens = [
    NavegationItem(Icon(Icons.home), Text('Home'), homeColor, Home(),pageController,1),
    NavegationItem(Icon(Icons.person), Text('Conta'), contaColor, LoginScreen(),pageController,2),
    NavegationItem(Icon(Icons.shopping_cart), Text('Carrinho'), carrinhoColor, Carrinho(),pageController,3),
    NavegationItem(Icon(Icons.markunread_mailbox), Text('Pedidos'), pedidosColor, paginaPedidos(),pageController,4),
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
        if(iten.rota == Home()){
          iten.cor = Colors.white;
        }
        return GestureDetector(
          onTap: (){
            var timer = Timer(Duration(milliseconds: 500), () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => iten.rota), ),

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
  final Widget rota;
  int pagina;
  PageController _pageController;

  NavegationItem(this.icon, this.title, this.cor, this.rota, this._pageController,this.pagina);

  int page = 0;

  void setPage(int value){
    if(value == page) return;
    page = value;
    _pageController.jumpToPage(value);
  }
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