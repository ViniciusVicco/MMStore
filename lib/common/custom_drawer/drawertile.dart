import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:provider/provider.dart';
class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;
  const DrawerTile({this.iconData,this.title,this.page});

  @override
  Widget build(BuildContext context) {
  final int curPage = context.watch<PageManager>().page; //Pega o índice da página atual
    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
              iconData,
                size: 32,
                color: curPage == page ? Colors.pink : Colors.grey[800],
              ),
            ),
            Text(title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//keytool -genkey -v -keystore c:\Users\vinic\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
