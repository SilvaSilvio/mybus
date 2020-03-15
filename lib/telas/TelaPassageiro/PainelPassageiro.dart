import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybus/telas/TelaMotorista/Telas/QrCodeCreate.dart';
import 'Telas/InicioPassageiro.dart';
import 'Telas/Recargas.dart';

class PainelPassageiro extends StatefulWidget {
  @override
  _PainelPassageiroState createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {
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
      InicioPassageiro(),
      RecargasPassageiro(),
      QrCodeCreate(),
     // HistoricoCompra(),

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
      body: telas[_indiceAtual ],
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
            title: Text("Recargas"),
            icon: Icon(Icons.credit_card),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            title: Text("QrCode"),
            icon: Icon(Icons.aspect_ratio),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            title: Text("Historico"),
            icon: Icon(Icons.reorder),
            backgroundColor: Colors.green,
          ),
            
        ], 
        ),
    );
    
  }
}