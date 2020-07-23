import 'package:firebase_auth/firebase_auth.dart';
import 'package:michellemirandastore/models/User.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Align(
            alignment: Alignment.center,
            child: const CircleAvatar(
              radius: 25,
              backgroundImage:AssetImage('assets/iconLoja.jpg'),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: globalKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField( // CAMPO E_MAIL
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email){ if(!emailValid(email)) {
                    return 'E-mail inválido';
                  }
                    return null;


                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField( // CAMPO SENHA
                  decoration: const InputDecoration(hintText: 'Senha',alignLabelWithHint: true),
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  obscureText: true,
                  validator: (senha){
                    if(!senhaValid(senha)){
                      return 'Senha Inválida';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print("Senha Não oculta");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,),
                              onPressed: () {

                              },
                            ),
                            SizedBox(
                              width: 140,
                              child: Text(
                                "Ocultar Senha",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.zero ,
                      child: Text(
                        "Esqueci minha senha",
                      ),
                      onPressed: () {},
                    ),
                    ]
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if(globalKey.currentState.validate()){
                        context.read<UserManager>().signIn(
                         User(
                           email: emailController.text,
                           passworld: passwordController.text,
                         )
                        );

                      }

                    },
                    child: SizedBox(
                      child: const Text(
                          "Entrar",
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
