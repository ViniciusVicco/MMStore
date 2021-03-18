import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/page_manager.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';


class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
     builder: (_,userManager, __){
       return Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
         Text('Michele Miranda Store',
         style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 34
         ),
         ),
           Text(userManager.isLoggedIn ?
           'Olá, ${userManager.user?.name ?? ''}':
           'Podemos te ajudar ?',
             overflow: TextOverflow.ellipsis, //Limita o nome que será mostrado em tela
             maxLines: 2,
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
             ),
           ),
           GestureDetector(
             onTap: (){
               if(userManager.isLoggedIn){
                 context.read<PageManager>().setPage(0);
                 userManager.signOut();
                 //TodoSAIR
               }
               else {
                 Navigator.of(context).pushNamed('/login');
               }

             },
             child: Text(
               userManager.isLoggedIn
                   ? 'Sair'
                   : 'Entre ou Cadastre-se aqui',
               style: TextStyle(
                 color: Theme.of(context).scaffoldBackgroundColor,
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
               ),
             ),
           )
         ],
       );
     },
      ),
    );
  }
}
