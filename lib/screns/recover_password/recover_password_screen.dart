import 'package:flutter/material.dart';

class RecoverPassowrd extends StatefulWidget {
  @override
  _RecoverPassowrdState createState() => _RecoverPassowrdState();
}

class _RecoverPassowrdState extends State<RecoverPassowrd> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Enviar e-mail de recuperação"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).hoverColor)),
                      )
                    ],
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
