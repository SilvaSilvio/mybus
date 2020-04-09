import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybus/Global/Inicio.dart';
import 'package:mybus/Global/Recargas.dart';

class GridDashboard extends StatelessWidget {


  Items item1 = new Items(
    title: "Calendar",
    icon: Icons.add_to_queue,
  // gestureDetector: Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => Recarga()));
  );

  Items item2 = new Items(
    title: "Groceries",
    icon: Icons.add_to_queue,
  );
  Items item3 = new Items(
    title: "Locations",
    icon: Icons.add_to_queue,
  );
  Items item4 = new Items(
    title: "Activity",

    // img: "images/inicio/pagamento.png",
  );
  Items item5 = new Items(
    title: "To do",

    //img: "assets/todo.png",
  );
  Items item6 = new Items(
    title: "Settings",

    //img: "images/inicio/informacoes.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 3,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(data.icon, color: Colors.white, size: 30),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () => data.gestureDetector,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  IconData icon;
  String raisedButton;
  GestureDetector gestureDetector;
  Items({this.title, this.icon, this.gestureDetector});
}

/*
 Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.event,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ), */
