import 'package:flutter/material.dart';
import 'package:mybus/Cadastro/Cadastro.dart';
import 'package:mybus/Login/Login.dart';

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
      Cadastro(),
    ];
    return Stack(
      children: <Widget>[
        Scaffold(
          body: telas[_indiceAtual],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 15,
            currentIndex: _indiceAtual,
            onTap: (indice) {
              setState(() {
                _indiceAtual = indice;
              });
            },
            type: BottomNavigationBarType.shifting,
            //fixedColor: Colors.blue,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                title: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(Icons.home),
                backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                title: Text("Cadastro", style: TextStyle(
                  //color: Colors.white
                  )),
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        )
      ],
    );
  }
}
