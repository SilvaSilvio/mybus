import 'package:flutter/material.dart';
import 'package:mybus/Model/Usuario.dart';
import 'package:masked_text/masked_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _textCPFController = TextEditingController();
  bool _tipoUsuario = false;
  String _mensagemErro = "";

  _validarCampos() {
    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String telefone = _controllerTelefone.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    //validar campos
    if (nome.isNotEmpty) {
      if (telefone.isNotEmpty && telefone.length > 8) {
        if (email.isNotEmpty && email.contains("@")) {
          if (senha.isNotEmpty && senha.length > 6) {
            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.telefone = telefone;
            usuario.email = email;
            usuario.senha = senha;
            //usuario.tipoUsuario = usuario.verificaTipoUsuario( _tipoUsuario );
            usuario.tipoUsuario = usuario.identificaUsuario(_tipoUsuario);
            _cadastrarUsuario(usuario);
          } else {
            setState(() {
              _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
            });
          }
        } else {
          setState(() {
            _mensagemErro = "Preencha o E-mail válido";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Informe um número com pelo menos 9 dǵitos";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      db
          .collection("usuarios")
          .document(firebaseUser.user.uid)
          .setData(usuario.toMap());

      //  redireciona para o painel, de acordo com o tipoUsuario
      switch (usuario.tipoUsuario) {
        //usuario.tipoUsuario
        case "Passageiro":
          Navigator.pushNamedAndRemoveUntil(
              context, "/painel-passageiro", (_) => false);
          break;
        case "Motorista":
          Navigator.pushNamedAndRemoveUntil(
              context, "/painel-motorista", (_) => false);
          break;
        case "administrador":
          Navigator.pushNamedAndRemoveUntil(
              context, "/painel-administrador", (_) => false);
          break;
      }
    });
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
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  child: Image.asset("images/LoginCadastro1.png",
                      width: 100, height: 100, color: Colors.blue),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _controllerNome,
                    //autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "Nome Completo",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                
                Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: MaskedTextField(
                      maskedTextFieldController: _controllerTelefone,
                      mask: "(xx) xxxxx-xxxx",
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      inputDecoration: new InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      hintText: "Celular",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                      ),
                      
                    )
                    ),

                  Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _controllerEmail,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "Email",
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
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Passageiro",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Switch(
                          value: _tipoUsuario,
                          onChanged: (bool valor) {
                            setState(() {
                              _tipoUsuario = valor;
                            });
                          }),
                      Text("Motorista",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
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
                        _validarCampos();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 15),
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
