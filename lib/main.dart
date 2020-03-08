import 'package:flutter/material.dart';
import 'package:mybus/Menu/QrCodeCreate.dart';
import 'package:mybus/Menu/QrScanner.dart';
import 'package:mybus/telas/Home.dart';
import 'package:mybus/telas/TelaCadastro.dart';
import 'package:mybus/Menu/SliderMenu.dart';
import 'package:mybus/telas/Login.dart';
import 'package:mybus/Menu/EmpresaDetalhe.dart';
import 'package:mybus/Menu/TermosUso.dart';


/*void main() {


  var materialApp = MaterialApp(
    initialRoute: "/",
    routes: {
      "/SliderMenu": (context) => SliderMenu(),
      "/EmpresaDetalhe": (context) => EmpresaDetalhe(),
      "/TelaCadastro": (context) => TelaCadastro(),
      "/TermosUso": (context) => TermosUso(),
      "/Login": (context) => Login(),
      "/Telas": (context) => Home(),
      "/QrScanner": (context) => QrScanner(),
      "/QrScannerLeitura" : (context) => QrCodeCreate(),
    },
    home: Home(),
    //home: QrCodeCreate(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366),
    ),
  );
  runApp(
    materialApp,
  );
}*/

import 'package:cloud_firestore/cloud_firestore.dart';

void main()
{
  Firestore.instance
    .collection("usuarios")
    .document("pontuacao")
    .setData({"carlos": "80", "silvana": "340"});

  runApp(App());
  
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}