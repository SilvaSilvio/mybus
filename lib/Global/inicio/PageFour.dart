import 'package:flutter/material.dart';
import 'package:mybus/Global/Recargas.dart';

class PageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: <Widget>[
            Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.credit_card,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("Recargas"),
                      ]),
                )),
            Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.monetization_on,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("adicionar \n dinheiro "),
                      ]),
                )),
            Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.storage,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("Historico"),
                      ]),
                )),
            Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.home,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("outros"),
                      ]),
                )),
            Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.home,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("outros"),
                      ]),
                )),
                 Card(
                elevation: 10,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.home,
                            size: 60.0,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recarga())),
                        ),
                        Text("outros"),
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
