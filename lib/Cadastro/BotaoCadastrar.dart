import 'package:flutter/material.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class BotaoCadastrar extends StatelessWidget {
  final _controllerNome = TextEditingController();
  final _controllerTelefone = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String tipoUsuario = "Passageiro";

  BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Form(
        key: _formKey,
        child: RaisedButton(
            child: Text(
              "Cadastrar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Map<String, dynamic> userData = {
                  "nome": _controllerNome.text,
                  "email": _controllerEmail.text,
                  "telefone": _controllerTelefone.text,
                  "passageiro": tipoUsuario
                };
                model.signUp(
                    userData: userData,
                    senha: _controllerSenha.text,
                    onSuccess: _onSuccess,
                    onFail: _onFail);
              }
            }),
      );
    }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).popAndPushNamed("/painel-passageiro");
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
