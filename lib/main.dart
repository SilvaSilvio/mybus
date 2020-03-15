import 'package:flutter/material.dart';
import 'package:mybus/ConexaoBanco/firebase.dart';
import 'package:mybus/telas/Cadastro.dart';

import 'package:mybus/telas/Home.dart';
import 'package:mybus/Menu/SliderMenu.dart';
import 'package:mybus/telas/Login.dart';
import 'package:mybus/Menu/EmpresaDetalhe.dart';
import 'package:mybus/Menu/TermosUso.dart';
import 'package:mybus/telas/TelaMotorista/Telas/QrCodeCreate.dart';


void main() {
  var materialApp = MaterialApp(
    initialRoute: "/",
    routes: {
      "/SliderMenu": (context) => SliderMenu(),
      "/EmpresaDetalhe": (context) => EmpresaDetalhe(),
      "/TermosUso": (context) => TermosUso(),
      "/Login": (context) => Login(),
      "/Telas": (context) => Home(),
      "/QrScannerLeitura": (context) => QrCodeCreate(),
    },
    home: Cadastro(), //Home(),
   
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366),
    ),
  );
  runApp(
    materialApp,
  );
}
