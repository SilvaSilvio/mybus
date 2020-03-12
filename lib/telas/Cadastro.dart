import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/Model/Usuario.dart';


class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUsuario = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String nome = _controllerNome.text;
    String telefone = _controllerTelefone.text;
    String email = _controllerEmail.text;
    String usuario = _controllerUsuario.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty && nome.length > 3) {
      if (telefone.isNotEmpty && telefone.length > 8) {
        if (email.isNotEmpty && email.contains("@")) {
         // if (usuario.isNotEmpty) {
            if (senha.length > 6) {

              setState(() {
                _mensagemErro = "";
              });

              Usuario usuarios = new Usuario(); //Criação de um novo objeto.
              usuarios.nome = nome;
              usuarios.telefone = telefone;
              usuarios.email = email;
              usuarios.username = usuario;
              
              _cadastrarUsuario( usuarios );
            } else {
              setState(() {
                _mensagemErro = "Informe uma senha maior que 6 dígitos";
              });
            }
          } /*else {
            setState(() {
              _mensagemErro = "Preencha o campo Usuário";
            });
          }
        } */else {
          setState(() {
            _mensagemErro = "Email inválido";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Informe o celular com o DDD";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
            email: usuario.email,
            password: usuario.senha
            ).then((firebaseUser) {
      /*db
          .collection("Usuarios")
          .document(firebaseUser.user.uid)
          .setData(usuarios.toMap());
      */
      setState(() {
        Navigator.popAndPushNamed(context, "/painel-passageiro");
      });
    }).catchError((error){
      print("Erro: " + error.toString());
      setState(() {
         _mensagemErro = "Deu pau";
      });
    });
  }
    //Redireciona para o painel de acordo com o tipo de usuário..
    /*
      switch ( usuario.tipoUsuario )
      {
        case "Motorista" :
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/painel-motorista",
          (_) => false,
          );
          break;
          case "Passageiro" :
          Navigator.pushNamedAndRemoveUntil(
          context,
          "/painel-passageiro",
          (_) => false,
          );
          break;
      }
      */
    //
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 32)),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 8),
                child: TextField(
                  controller: _controllerNome,
                  //autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome Completo",
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
                  controller: _controllerTelefone,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Celular",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: _controllerEmail,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      )),
                ),
              ),
             /*
               Center(
                child: GestureDetector(
                  child: Text(
                    "Login no aplicativo",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 8),
                child: TextField(
                  controller: _controllerUsuario,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Usuário",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      )),
                ),
              ),
             */
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
                    hintText: "senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
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
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: (){
                      _validarCampos();
                      }),
              ),
              Center(
                child: Text(
                  _mensagemErro,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
