import 'package:flutter/material.dart';

class Carteira extends StatefulWidget {
  @override
  _CarteiraState createState() => _CarteiraState();
}

class _CarteiraState extends State<Carteira> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Carteira"),
          ),
        ],
      ),
    );
  }
}
