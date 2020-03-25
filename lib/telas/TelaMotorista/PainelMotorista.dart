import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Global/Inicio_Screen.dart';
import 'Telas/QrCodeCreate.dart';


class PainelMotorista extends StatefulWidget {
  @override
  _PainelMotoristaState createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {
 String _emailUsuario = "";

  Future _recuperarDadosUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser _usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = _usuarioLogado.email;
    });
    
  }

  @override
  void initState(){
    _recuperarDadosUsuario();
  }

  List<String> itensMenu = [
    "Deslogar"
  ];

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
  
  _escolhaMenuItem( String escolha ){

    switch ( escolha ){
      case "Deslogar" : _deslogarUsuario();
      break;
    }
  }
  int _indiceAtual = 0;
  List<Widget> telas = [
      Inicio(),
      QrCodeCreate(),
     

    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Painel Motorista"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){

              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            }
          )
        ],
      ),
      body:   
      
      telas[_indiceAtual ],
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
            title: Text("Inicio"),
            icon: Icon(Icons.home),
            backgroundColor: Colors.yellow,
          ),
          
          BottomNavigationBarItem(
            title: Text("QrCode"),
            icon: Icon(Icons.aspect_ratio),
            backgroundColor: Colors.green,
          ),
          
            
        ], 
        ),
    );
    
  }
}