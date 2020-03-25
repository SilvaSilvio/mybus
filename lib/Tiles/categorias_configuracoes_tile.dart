import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Screen/categoria_perfil.dart';

class CategoriaConfiguracoes extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoriaConfiguracoes(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return 
        ListTile(
          leading: Icon(Icons.person_pin),
          title: Text(snapshot.data["nome"]),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => CategoriaPerfil(snapshot),
                ),
            );
          },
        );
       
     
  }
}
