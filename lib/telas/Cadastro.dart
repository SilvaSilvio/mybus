import 'package:flutter/material.dart';
import 'package:mybus/Model/Usuario.dart';
import 'package:masked_text/masked_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybus/Model/pessoal/Pessoa/Usuario.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  bool _tipoUsuario = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _validarCampos() {
    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String telefone = _controllerTelefone.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    Usuario usuario = Usuario();
    usuario.nome = nome;
    usuario.telefone = telefone;
    usuario.email = email;
    usuario.senha = senha;

    usuario.tipoUsuario = usuario.identificaUsuario(_tipoUsuario);
    _cadastrarUsuario(usuario);
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
          _onSuccess();
          
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
        case "Administrador":
          Navigator.pushNamedAndRemoveUntil(
              context, "/painel-administrador", (_) => false);
          break;
      }
    }).catchError((error){
      _onFail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            SizedBox(
            height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Image.asset("images/LoginCadastro1.png",
                  width: 100, height: 100, color: Colors.blue),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: TextFormField(
                controller: _controllerNome,
                //autofocus: true,
                keyboardType: TextInputType.text,
                validator: (text) {
                  if (text.isEmpty) return "Informe um nome";
                },
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
                padding: EdgeInsets.only(top: 5),
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
                          borderRadius: BorderRadius.circular(15))),
                )),
            Align(
              alignment: Alignment.center,
              child: new Text(
                "Para logar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.zero,
              child: TextFormField(
                controller: _controllerEmail,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "E-mail inválido";
                },
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
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: _controllerSenha,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return "Informe uma senha maior que 6 dígitos";
                },
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
                    if (_formKey.currentState.validate()) {
                      _validarCampos();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
   void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
