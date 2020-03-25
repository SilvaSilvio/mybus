import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:mybus/Model/pessoal/Pessoa/Usuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    Usuario usuario = new Usuario();
    usuario.email = email;
    usuario.senha = senha;

    _logarUsuario(usuario);
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaserUser) {
          _onSuccess();
      _direcionamentoPainelPorTipoUsuario(firebaserUser.user.uid);
    }).catchError((error) {
      _onFail();
    });
  }

  _direcionamentoPainelPorTipoUsuario(String idUsuario) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(idUsuario).get();

    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados["TipoUsuario"];

    switch (tipoUsuario) {
      case "Motorista":
        Navigator.pushReplacementNamed(context, "/painel-motorista");
        break;
      case "Passageiro":
        Navigator.pushReplacementNamed(context, "/painel-passageiro");
        break;
      case "Administrador":
        Navigator.pushReplacementNamed(context, "/painel-administrador");
        break;
    }
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser _usuarioLogado = await auth.currentUser();
    if (_usuarioLogado != null) {
      String idUsuario = _usuarioLogado.uid;
      _direcionamentoPainelPorTipoUsuario(idUsuario);
    }
  }


  @override
  void initState() {
    super.initState();
   _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          key: _scaffoldKey,
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset("images/LogoBus.png",
                            width: 200, height: 200, color: Colors.blue,),
                        Center(
                          child: Text(
                            "My Bus",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 8),
                          child: TextFormField(
                            controller: _controllerEmail,
                            //autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text.isEmpty || !text.contains("@"))
                                return "E-mail inválido!";
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                hintText: "E-mail",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: TextFormField(
                            controller: _controllerSenha,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (text) {
                              if (text.isEmpty || text.length < 6)
                                return "Senha inválida, informe uma senha maior que 6 digitos!";
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                hintText: "Senha",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              if (_controllerEmail.text.isEmpty)
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Insira seu e-mail para recuperação!"),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              else {
                                UserModel model = UserModel();
                                model.recuperarSenha(_controllerEmail.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Confira seu e-mail!"),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: new Text(
                              "Esqueci minha senha",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: RaisedButton(
                              child: Text(
                                "Logar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.blue,
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                ),
              ],
            ),
          ),
        ),
      ],
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
