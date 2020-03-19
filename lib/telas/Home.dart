import 'package:flutter/material.dart';
import 'package:mybus/telas/Cadastro.dart';

import 'Login.dart';



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
        fixedColor: Colors.blue,
        backgroundColor: Colors.black,
        
        items: [
          BottomNavigationBarItem(
            title: Text("Login", style: TextStyle(
               color: Colors.white,
            ),
            ),
            icon: Icon(Icons.home, color: Colors.white),
            
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            title: Text("Cadastro", style: TextStyle(
                color: Colors.white)),
            icon: Icon(Icons.person_add, color: Colors.white,),
            backgroundColor: Colors.yellow,
          ),
        ], 
        ),
    );
  }
}