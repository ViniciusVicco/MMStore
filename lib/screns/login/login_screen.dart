import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:michellemirandastore/helpers/validators.dart';
import 'package:michellemirandastore/models/user.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool senhaOculta = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 27,
          backgroundImage: AssetImage('assets/logo.png'),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15, color: Colors.black),
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
              if (userManager.loadingFace)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).scaffoldBackgroundColor),
                  ),
                );
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
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
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(
                        hintText: 'Senha', alignLabelWithHint: true),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: senhaOculta,
                    validator: (senha) {
                      if (!senhaValid(senha)) {
                        return 'Senha Inválida';
                      }
                      return null;
                    },
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: senhaOculta
                                  ? Icon(
                                      Icons.lock_open_rounded,
                                      color: Theme.of(context).accentColor,
                                    )
                                  : Icon(
                                      Icons.lock_outline,
                                      color: Theme.of(context).accentColor,
                                    ),
                              onPressed: () {
                                setState(() {
                                  this.senhaOculta = !senhaOculta;
                                });
                              },
                            ),
                            SizedBox(
                              width: 140,
                              child: Text(
                                senhaOculta ? "Exibir Senha" : "Ocultar Senha",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor),
                    ),
                    onPressed: userManager.loading
                        ? null
                        : () {
                            FocusScope.of(context).requestFocus(FocusNode());

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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                  SignInButton(Buttons.Facebook, text: "Entrar Com Facebook",
                      onPressed: () {
                    userManager.facebookLogin(onFail: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Falha ao entrar: $e'),
                        backgroundColor: Colors.red,
                      ));
                    }, onSuccess: () {
                      Navigator.of(context).pushNamed('/');
                      //TODO: AJustar o login com facebook para redirecionar pagina
                    });
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
