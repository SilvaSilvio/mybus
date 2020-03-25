import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Tiles/categorias_configuracoes_tile.dart';

class PerfilTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("usuarios").getDocuments(),
      builder: (context, snapshot) {
        (doc) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var divisao = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map((doc) {
                    return CategoriaConfiguracoes(doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: divisao,
          );
        };
      },
    );
  }
}
