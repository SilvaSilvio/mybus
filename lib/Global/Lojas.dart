import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Lojas extends StatelessWidget {
  final DocumentSnapshot snapshot;

  Lojas(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.data["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                   snapshot.data["nome"],
                   textAlign: TextAlign.start,
                   style: TextStyle(
                     fontSize: 17,
                     fontWeight: FontWeight.bold
                   ),
                 ),
                 Text(
                    snapshot.data["endereco"],
                    textAlign: TextAlign.start,
                 ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
              child: new Text("Ver no Mapa"),
              textColor: Colors.blue,
              padding: EdgeInsets.zero,
              onPressed: (){
                  launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]},"
                  "${snapshot.data["long"]}");
                },
              ),

              FlatButton(
              child: new Text("Ligar"),
              textColor: Colors.blue,
              padding: EdgeInsets.zero,
              onPressed: (){
                  launch("tel: ${snapshot.data["telefone"]}");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}