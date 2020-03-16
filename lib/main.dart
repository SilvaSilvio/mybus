import 'package:flutter/material.dart';
import 'package:mybus/telas/Home.dart';

import 'Rotas.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366),
);

void main() => runApp(MaterialApp(
  title: "MyBus",
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Rotas.gerarRotas,
  debugShowCheckedModeBanner: false,
)
);