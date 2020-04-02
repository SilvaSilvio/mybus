import 'package:flutter/material.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:mybus/telas/Home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Rotas.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff8B4513), //0xff075E54
  accentColor: Color(0xffD37682), //0xff25D366
);

void main() => runApp(new MyBus());

class MyBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "MyBus",
        theme: temaPadrao,
        initialRoute: "/",
        onGenerateRoute: Rotas.gerarRotas,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
