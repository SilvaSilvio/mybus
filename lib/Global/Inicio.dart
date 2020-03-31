import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<String> itensMenu = ["Deslogar"];

  _escolhaItemMenu(String escolha) async{
     await FirebaseAuth.instance.signOut();
     Navigator.pushReplacementNamed(context, "/");
    }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Inicio"),
                centerTitle: true,
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: _escolhaItemMenu,
                  itemBuilder: (context) {
                    return itensMenu.map((String item) {
                      return PopupMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("Inicio")
                  .orderBy("pos")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map((doc) {
                      return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                    }).toList(),
                    children: snapshot.data.documents.map((doc) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: doc.data["image"],
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}

/*Scaffold(
      body: Container(
        color: Colors.green,
        height: 300.0,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 32,
            ),
            Text(
              "Saldo:                 ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors
                      .white //controller.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
                  ),
            ),
            //Icon(Icons.remove_red_eye),
          ],
        ),
      ),*/