import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybus/Global/Lojas.dart';

class LojasTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("Lojas").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return ListView(
            children: snapshot.data.documents.map((doc) => Lojas(doc)).toList(),
          );
      },
    );
  }
}
