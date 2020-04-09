import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masked_text/masked_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _controllerNome = TextEditingController();
  final _controllerTelefone = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  String tipoUsuario = "Passageiro";

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final googleSignIn = GoogleSignIn();
  Future<Null> googleSigIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) user = await googleSignIn.signIn();
    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;

      await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: credentials.idToken, accessToken: credentials.accessToken));
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Form(
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
                      prefixIcon: Icon(Icons.person),
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
                        prefixIcon: Icon(Icons.phone_android),
                        hintText: "Celular",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  ),
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
                      prefixIcon: Icon(Icons.email),
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
                  obscureText: !model.showPassword,
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
                    prefixIcon: Icon(Icons.security),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye,
                      color: model.showPassword ? Colors.blue : Colors.grey
                      ),
                      onPressed: (){
                        setState(() {
                          model.showPassword = !model.showPassword;
                        });
                      }
                      ),
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
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: RaisedButton(
                    child: Text(
                      "Entrar com o google",
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
                      googleSigIn();
                    }),
              ),
            ],
          ),
        );
      }),
      ),
    );
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
