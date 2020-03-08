import 'package:flutter/material.dart';

class Pagamento extends StatefulWidget {
  @override
  _PagamentoState createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  @override
    Widget build(BuildContext context) {
    return Container(
    child: Column(
    children: <Widget>[
      AppBar(
        title: Text("Pagamento"),
      ),
    ],
    ),      
    );
  }
}