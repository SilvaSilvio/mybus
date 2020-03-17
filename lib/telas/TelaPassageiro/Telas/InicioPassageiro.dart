import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Model/Usuario.dart';

class InicioPassageiro extends StatefulWidget {
  @override
  _InicioPassageiroState createState() => _InicioPassageiroState();
}

class _InicioPassageiroState extends State<InicioPassageiro> {
  String _EmailUsuario = "";
  String _nome = "";

  Future _recupararDadosUsuario() async {
    Usuario usuario = Usuario();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _EmailUsuario = usuarioLogado.email;
    });
  }

  @override
  void initState() {
    _recupararDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          "Bem vindo $_nome",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
