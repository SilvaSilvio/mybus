import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        height: 300.0,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 32,
            ),
            Text(
              "Saldo:                 ",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors
                      .white //controller.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
                  ),
            ),
            //Icon(Icons.remove_red_eye),
          ],
        ),
      ),
    );
  }
}