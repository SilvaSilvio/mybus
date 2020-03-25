import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaPerfil extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoriaPerfil(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["nome"]),
            centerTitle: true,
            backgroundColor: Theme.of(context).accentColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("Configuracoes").document(snapshot.documentID)
            .collection("itens").getDocuments(),
            builder: (context, snapshot){
              if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),
              );
              else{
                return TabBarView(
                  children: [
                    Container(color: Colors.green,),
                    Container(color: Colors.yellowAccent,)
                  ]
                  );
              }
            }
          ),
        ));
  }
}
