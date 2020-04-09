import 'package:flutter/material.dart';

class PageOne1 extends StatefulWidget {
  @override
  _PageOne1State createState() => _PageOne1State();
}

class _PageOne1State extends State<PageOne1> {
 
  singleCard(iconcode, icontitle) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(iconcode, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 50,
            ),
            //Text
            Text(icontitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliverGrid.count(
        crossAxisCount: 2,
        children: <Widget>[
          singleCard(5774, 'teste'),
          singleCard(59470, 'teste'),
        
        ],
      ),
    );
  }
}
