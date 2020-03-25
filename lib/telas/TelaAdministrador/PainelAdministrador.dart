import 'package:flutter/material.dart';
import 'package:mybus/Global/Inicio_Screen.dart';
import 'package:mybus/Global/QrScanner.dart';
import 'package:mybus/Global/Termo_Uso.dart';
import 'package:mybus/Global/UsuarioCadastrados.dart';
import 'package:mybus/Global/perfil.dart';
import 'package:mybus/drawer/custom_drawer.dart';
import 'package:mybus/tabs/LojasTab.dart';

class PainelAdministrador extends StatelessWidget {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
         Scaffold(
           appBar: AppBar(title: new Text("Painel Administrador"),),
          body: Inicio(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
           appBar: AppBar(title: new Text("Perfil"),),
          body: Perfil(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
           appBar: AppBar(title: new Text("Usuarios Cadastrados"),),
          body: UsuarioCadastrados(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
           appBar: AppBar(title: new Text("Locais de Recargas"),),
         body: LojasTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
           appBar: AppBar(title: new Text("Termos de Uso"),),
          body: TermosUso(),
          drawer: CustomDrawer(_pageController),
        ),
       
      ]
    );
  }
}