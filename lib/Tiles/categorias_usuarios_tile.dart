import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaUsuario extends StatelessWidget {
  
  final DocumentSnapshot snapshot;

  CategoriaUsuario(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        //backgroundImage: NetworkImage(snapshot.data[""]),
      ),
      title: Text(snapshot.data["nome"]),
      subtitle: Text(snapshot.data["email"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
      },

    
    );
  }
}