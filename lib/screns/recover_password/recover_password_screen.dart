import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:provider/provider.dart';

class RecoverPassowrd extends StatefulWidget {
  @override
  _RecoverPassowrdState createState() => _RecoverPassowrdState();
}

class _RecoverPassowrdState extends State<RecoverPassowrd> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController textEmailEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Recuperação de senha"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.loading)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).scaffoldBackgroundColor),
                      ),
                    );
                  return Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: heigth * 0.03,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Digite o seu e-mail para recuperar senha",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )),
                            child: TextFormField(
                              controller: textEmailEditingController,
                              validator: (email) {
                                if (!email.contains('@')) {
                                  return 'E-mail inválido';
                                }
                                if (!email.contains('.com')) {
                                  return 'E-mail inválido';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                userManager.recoverPassword(
                                    email: textEmailEditingController.text,
                                    onSuccess: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        content: Text(
                                          "A Recuperação de senha foi enviada para seu e-mail",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ));
                                    },
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Falha ao enviar recuperação de senha: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                              }
                            },
                            child: Text("Enviar e-mail de recuperação"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).hoverColor)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
