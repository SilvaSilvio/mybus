import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/Model/Usuario.dart';
import 'package:mybus/telas/TelaPassageiro/PainelPassageiro.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";


  _validarCampos() {
    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
     
        Usuario usuario = new Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );

      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Email inválido";
      });
    }
  }

  _logarUsuario(Usuario usuario) {

    
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email,
            password: usuario.senha
            ).then((firebaserUser) {

            _direcionamentoPainelPorTipoUsuario( firebaserUser.user.uid );
     
    }).catchError((error) {
        _mensagemErro = "Erro ao autenticar Usuário, verifique e-mail e senha e tente novamente";
    });
  }

  _direcionamentoPainelPorTipoUsuario (String idUsuario ) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
    .document( idUsuario )
    .get();

    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados[ "TipoUsuario" ];

  
      switch ( tipoUsuario ){
        case "Motorista" :
        Navigator.pushReplacementNamed(context, "/painel-motorista");
        break;
      case "Passageiro" :
        Navigator.pushReplacementNamed(context, "/painel-passageiro");
        break;
      }
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser _usuarioLogado = await auth.currentUser();
    if (_usuarioLogado != null) {
       String idUsuario = _usuarioLogado.uid;
       _direcionamentoPainelPorTipoUsuario( idUsuario );
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
      
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
                  "images/LogoBus.png",
                   width: 200, height: 200, color: Colors.blue
                ),
                Center(
                  child: Text(
                    "My Bus", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    //autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
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
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
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
                          fontSize: 15,
                        ),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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
