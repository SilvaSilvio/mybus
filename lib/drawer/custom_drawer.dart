import 'package:flutter/material.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:mybus/drawer/drawer_tile.dart';
import 'package:mybus/telas/Home.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
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
                height: 190,
                child: Stack(children: <Widget>[
                  Positioned(
                    top: 8.0,
                    left: 15.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.nature_people, size: 38,),
                        new Text(
                      "  My Bus   ",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
                    ),
                    Icon(Icons.directions_bus, size: 34)
                      ],  
                    )
                    
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                      print(model.isLoading);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person_outline, size: 50,),
                          new Text("${!model.isLoggedIn() ? "Não logado" : model.userData["nome"]}", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),),
                          new Text(
                            "${!model.isLoggedIn() ? "" : model.userData["email"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      );
                      
                    }),
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
              DrawerTile(Icons.settings, "Termos de uso", pageController, 5),
              Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  height: 45,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 4.0,
                        // left: -1,
                        child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model) {
                          if (model.isLoading)
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          return GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 32,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    "       Sair",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (model.isLoggedIn()) model.signOut();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Home()));
                              });
                        })),
                  ])),
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

/* */
