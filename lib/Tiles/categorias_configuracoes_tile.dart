import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                 //   builder: (context) => aqui será passado uma página(snapshot),
                ),
            );
          },
        );
       
     
  }
}
