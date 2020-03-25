import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Tiles/categorias_usuarios_tile.dart';

class UsuarioCadastrados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("usuarios").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map((doc) {
                    return CategoriaUsuario(doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
