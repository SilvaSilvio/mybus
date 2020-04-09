import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybus/Model/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Teste extends StatelessWidget {
  List<String> events = [
    "Recargas",
    "Historico",
    "Saldo",
    "Informações",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 250,
              color: Colors.green,
             
            )
          ],
        ),
        Center(
          child: Container(
            height: 400,
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}

/*

        Stack(
          children: <Widget>[
            ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading) return Center(child: CircularProgressIndicator(),);
          return Container(
            
          decoration: BoxDecoration(
            color: Colors.white,
           ),
           child: Container(
            
            margin: const EdgeInsets.only(top: 200),
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2), //Itens por linhas.
              children: events.map(
                (title) {
                  //Responsável pelo lop.
                  return GestureDetector(
                      child: Card(
                          margin: const EdgeInsets.all(15),
                          child: getCardByTitle(title)),
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: title + "Click",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      });
                },
              ).toList(),
            ),
          ),
          );
        }),
          ],
        )
      ],
    );
  }
}

Column getCardByTitle(String title) {
  String img = "";
  // Icon(Icons.do_not_disturb_alt);

  switch ( title ){
    case "Recargas" : img = "images/inicio/recarga.png";
    break;
    case "Historico" : img = "images/inicio/historico.png";
    break;
    case "Saldo" : img = "images/inicio/pagamento.png";
   //Navigator.popAndPushNamed(context, "");
    break;
    case "Informações" : img = "images/inicio/informacoes.png";
    break;
   
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Center(
        child: Container(
          child: new Stack(children: <Widget>[
            new Image.asset(img, width: 80.0, height: 80.0),
          ]),
        ),
      ),
      new Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )
    ],
  );
} */
