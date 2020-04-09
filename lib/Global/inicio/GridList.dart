import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Lista no Grid";

    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: GridView.count(
                crossAxisCount: 3,
                children: List.generate(opcoes.length, (index) {
                  return Center(
                    child: OpcaoCard(opcao: opcoes[index]),
                  );
                }))));
  }
}

class Opcao {
  const Opcao({this.titulo, this.icon, this.raisedButton});

  final String titulo;
  final IconData icon;
  final RaisedButton raisedButton;
}

const List<Opcao> opcoes = const <Opcao>[
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Ônibux', icon: Icons.directions_bus),
  const Opcao(titulo: 'Copy', icon: Icons.copyright),
  const Opcao(titulo: 'Ônibus', icon: Icons.directions_bus),
  const Opcao(titulo: 'Andar', icon: Icons.directions_walk),
  const Opcao(titulo: 'Bike', icon: Icons.drafts),
];

class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return ListView(
      children: <Widget>[
        Container(
         color: Colors.green,
          margin: EdgeInsets.all(20),
          //elevation: 0,
          child: Container(
            height: 100,
            child: InkWell(

            ),
          ),
        ),
        Card(
            color: Colors.black12,
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      opcao.icon,
                      size: 80.0,
                      color: textStyle.color,
                    ),
                    Text(opcao.titulo, style: textStyle),
                  ]),
            )),
      ],
    );
  }
}
