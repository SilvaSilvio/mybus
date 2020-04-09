import 'package:flutter/material.dart';

class OnePage extends StatelessWidget {

  final userModel = ["Car", "Bus", "Train", "plane"];
 // Icon Icon1 = [ Icon(Icons.directions_car, size: 50),



  Map<String, Icon> types() => {
    "car": Icon(Icons.directions_car, size: 50),
    "bus": Icon(Icons.directions_bus, size: 50),
    "train": Icon(Icons.train, size: 50),
    "plane": Icon(Icons.airplanemode_active, size: 50),
    //"ship": Icon(Icons.directions_boat, size: 50),
    //"other": Icon(Icons.directions, size: 50),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
               crossAxisCount: 3,
               scrollDirection: Axis.vertical,
               primary: false,
               children: List.generate(userModel.length, ( types ) {
                 return FlatButton.icon(
                 icon: Icon(Icons.home ),
                 
                   onPressed: (){

                   },
                   label:Text(userModel[ types ]),
                 

                   );
               })

               ), 
            ),
          ],
        ),
      ),
    );
  }
}