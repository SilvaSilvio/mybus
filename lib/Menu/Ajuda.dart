import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Ajuda"),
          ),
        ],
      ),
    );
  }
}