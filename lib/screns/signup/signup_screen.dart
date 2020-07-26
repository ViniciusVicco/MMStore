import 'package:flutter/material.dart';
import 'package:michellemirandastore/helpers/validators.dart';
import 'package:michellemirandastore/models/User.dart';
class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // Para usar Snackbar ( aquele alerta de erros ).

  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nome Completo *',
                  ),
                  validator: (name){
                    if(name.isEmpty)
                      return 'Campo Obrigatório';
                    else if(name.trim().split(' ').length <= 1)
                      return 'Preencha seu Nome Completo';
                    return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'E-mail*',
                  ),
                  validator: (email){
                    if(email.isEmpty){
                      return 'Campo Obrigatório';
                    }
                    else if(!emailValid(email))
                      return 'E-mail Inválido';
                    return null;
                  },
                  onSaved: (email) => user.email = email,

                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Senha",),
                  obscureText: true,
                  validator: (pass){
                    if(pass.isEmpty)
                      return 'Campo Obrigatório';
                    else if(pass.length < 6)
                      return 'Senha muito curta';
                    return null;
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Confirme Sua Senha",),
                  obscureText: true,
                  validator: (pass){
                    if(pass.isEmpty)
                      return 'Campo Obrigatório';
                    else if(pass.length < 6)
                      return 'Senha muito curta';
                    return null;
                  },
                  onSaved: (pass) => user.confirmedPassword = pass,
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      if(formKey.currentState.validate()){ // Ao validar os campos dentro do validate ele deixa entrar
                        print("Os campos foram validados");
                        formKey.currentState.save(); // Vai chamar o texto que está dentro do método onSave de cada TextFormField
                        if(senhasIguais(user.password, user.confirmedPassword)){
                          print("Senhas iguais");
                        }
                        else{
                          scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Senhas não coincidem"),
                                backgroundColor: Colors.red,
                              )
                          );
                        }
                        return;
                      }
                    },
                    child: const Text("Criar Conta"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
