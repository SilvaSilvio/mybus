import 'package:flutter/material.dart';
import 'package:mybus/Global/Recargas.dart';

class Incio2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.greenAccent,
              height: 200,
              width: 600,
              //transform: new Matrix4.rotationZ(-0.1),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30), right: Radius.circular(30))),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Saldo: ",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add_to_home_screen),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Recarga()));
                      }),
                  GestureDetector(
                    child: Icon(
                      Icons.home,
                      size: 80,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Recarga()));
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.g_translate,
                      size: 80,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.games,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.home,
                      size: 80,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.g_translate,
                      size: 80,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.games,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
