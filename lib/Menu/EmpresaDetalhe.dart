import 'package:flutter/material.dart';

class EmpresaDetalhe extends StatefulWidget {
  @override
  _EmpresaDetalheState createState() => _EmpresaDetalheState();
}

class _EmpresaDetalheState extends State<EmpresaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Detalhes da empresa"),
          ),
        ],
      ),
    );
  }
}
