import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/ConexaoBanco/firebase.dart';
import 'package:mybus/Model/Usuario.dart';
import 'package:mybus/telas/Home.dart';
import 'package:mybus/telas/TelaPassageiro/PainelPassageiro.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>  {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

          _validarCampos(){
            String email = _controllerEmail.text;
            String senha = _controllerSenha.text;

             Usuario usuario = new Usuario();
                usuario.email = email;
                usuario.senha = senha;

                _logarUsuario( usuario );


        
            if (email.isNotEmpty && email.contains("@")) {
              if (senha.isNotEmpty) {
                setState(() {
                  _mensagemErro = "";
                });
        
                Usuario usuario = new Usuario();
                usuario.email = email;
                usuario.senha = senha;

                _logarUsuario( usuario );

                } else {
                setState(() {
                  _mensagemErro = "Preencha a senha!";
                });
              }
            } else {
              setState(() {
                _mensagemErro = "Email inválido";
              });
            }
          }

          _logarUsuario( Usuario usuario ){
              FirebaseAuth auth = FirebaseAuth.instance;

              auth.signInWithEmailAndPassword(
                email: usuario.email,
                password: usuario.senha
                ).then((firebaserUser) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PainelPassageiro(),
                    )
                  );

                }).catchError((error){
                  print("Erro " + error.toString());
                  _mensagemErro = "Erro ao autenticar Usuário, verifique e-mail e senha e tente novamente";
                });
          }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/PlanoFundo3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                ),
                Image.asset(
                  "images/MyBus.png",
                  width: 200,
                  height: 150,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    //autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 15),
                  child: RaisedButton(
                      child: Text(
                        "Logar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onPressed: () {
                        _validarCampos();
                      }),
                ),
                  Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
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
