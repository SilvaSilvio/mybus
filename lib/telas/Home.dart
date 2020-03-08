import 'package:flutter/material.dart';

import 'Login.dart';
import 'TelaCadastro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Login(),
      TelaCadastro(),
    ];
    return Scaffold(
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text("Login"),
            icon: Icon(Icons.home),
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            title: Text("Cadastro"),
            icon: Icon(Icons.person_add),
            backgroundColor: Colors.green,
          ),
        ], 
        ),
    );
  }
}