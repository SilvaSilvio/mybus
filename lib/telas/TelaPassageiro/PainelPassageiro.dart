import 'package:flutter/material.dart';
import 'package:mybus/Global/Inicio.dart';
import 'package:mybus/Global/QrScanner.dart';
import 'package:mybus/Global/Recargas.dart';
import 'package:mybus/Global/perfil.dart';
import 'package:mybus/Model/UserModel.dart';

import 'package:mybus/drawer/custom_drawer.dart';
import 'package:mybus/tabs/LojasTab.dart';
import 'package:mybus/tabs/configuracoes_tab.dart';
import 'package:scoped_model/scoped_model.dart';

class PainelPassageiro extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      return PageView(
        
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              
              body: Inicio(),
              drawer: CustomDrawer(_pageController),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Perfil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: Perfil(),
              drawer: CustomDrawer(_pageController),
            ),
            Scaffold(
              appBar: AppBar(
                title: new Text(
                  "QRCode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: QrScanner(),
              drawer: CustomDrawer(_pageController),
            ),
            Scaffold(
              appBar: AppBar(
                title: new Text(
                  "Lojas Credenciadas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: LojasTab(),
              drawer: CustomDrawer(_pageController),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Scaffold(
              appBar: AppBar(
                title: new Text(
                  "Recarga online",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: Recarga(),
              drawer: CustomDrawer(_pageController),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Scaffold(
              appBar: AppBar(
                title: new Text(
                  "Configurações",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: ConfiguracoesTab(),
              drawer: CustomDrawer(_pageController),
            ),
            Scaffold(
              body: Container(),
              drawer: CustomDrawer(_pageController),
            ),
          ]);
    }));
  }
}
