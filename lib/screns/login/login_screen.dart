import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:michellemirandastore/models/user.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/iconLoja.jpg'),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: globalKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    // CAMPO E_MAIL
                    enabled: !userManager.loading,
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: true,
                    validator: (email) {
                      if (!emailValid(email)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    // CAMPO SENHA
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(
                        hintText: 'Senha', alignLabelWithHint: true),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: true,
                    validator: (senha) {
                      if (!senhaValid(senha)) {
                        return 'Senha Inválida';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(children: [
                      InkWell(
                        onTap: () {
                          print("Senha Não oculta");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {},
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
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: userManager.loading
                        ? null
                        : () {
                            if (globalKey.currentState.validate()) {
                              userManager.signIn(
                                  user: User(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                  onSucess: () {
                                    Navigator.of(context).pop();
                                  },
                                  onFail: (e) {
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Falha ao entrar: $e"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  });
                            }
                          },
                    child: SizedBox(
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  SignInButton(Buttons.Facebook,
                      text: "Entrar Com Facebook",
                      onPressed: (){
                       userManager.facebookLogin(
                           onFail: (e){
                             scaffoldKey.currentState.showSnackBar(
                                 SnackBar(
                                   content: Text('Falha ao entrar: $e'),
                                   backgroundColor: Colors.red,
                                 )
                             );
                           },
                           onSuccess: (){
                             Navigator.of(context).pushNamed('/');
                             //TODO: AJustar o login com facebook para redirecionar pagina
                           }
                       );
                  })
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
