import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class FormFielCadastro extends StatelessWidget {

  final _controllerNome = TextEditingController();
  final _controllerTelefone = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
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
                      color: Colors.black,
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
                    prefixIcon: Icon(Icons.visibility_off),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
        ],
        
      ),
    );
  }
}