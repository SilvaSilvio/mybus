import 'package:flutter/material.dart';
import 'package:mybus/Login/EsqueciMinhaSenha.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            key: _scaffoldKey,

            body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
                    child: ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Form(
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
                           
                              Image.asset(
                              "images/LogoBus.png",
                              width: 150,
                              height: 200,
                              color: Colors.blue,
                            ),
                            Center(
                              child: Text(
                                "Pay Carbus",
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
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "E-mail",
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  prefixIcon: Icon(Icons.security),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye,
                                          color: model.showPassword
                                              ? Colors.blue
                                              : Colors.grey),
                                      onPressed: () {
                                        setState(() {
                                          model.showPassword =
                                              !model.showPassword;
                                        });
                                      }),
                                  hintText: "Senha",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
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
                                    model.recuperarSenha(_controllerEmail.text);
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Confira seu e-mail!"),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                child: GestureDetector(
                                  child: Text(
                                  "Esqueci minha senha",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
                                      model.signIn(
                                        email: _controllerEmail.text,
                                        pass: _controllerSenha.text,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail,
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Sucesso",
          textAlign: TextAlign.center,
        ),
      ),
    );
    Navigator.pushNamed(context, "/painel-passageiro");
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Falha ao Entrar! Verifique usuario e senha e tente novamente",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
