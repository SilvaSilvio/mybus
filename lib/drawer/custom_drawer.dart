import 'package:flutter/material.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:mybus/drawer/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  _sair(){
     UserModel user = UserModel();
     user.signOut();
  }

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 203, 236, 241), //
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
           ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 180,
                child: Stack(children: <Widget>[
                  Positioned(
                    top: 8.0,
                    left: 0.0,
                    child: new Text(
                      "My Bus",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "Olá, ", //${!model.isLoggedIn() ? "" : model.userData["nome"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                      ),
                ]),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.account_circle, "Perfil", pageController, 1),
              DrawerTile(
                  Icons.aspect_ratio, "Vincular QRCode", pageController, 2),
              DrawerTile(
                  Icons.location_on, "Postos de recargas", pageController, 3),
              DrawerTile(Icons.list, "Recarga online", pageController, 4),
              DrawerTile(Icons.settings, "Configurações", pageController, 5),
              DrawerTile(Icons.redeem, "Convide Amigos", pageController, 6,
              ),
              Divider(),
              Text("Versão"),
              DrawerTile(
                  Icons.stay_current_portrait, "Beuga 1.0", pageController, 7),
            ],
          ),
        ],
      ),
    );
  }
}
