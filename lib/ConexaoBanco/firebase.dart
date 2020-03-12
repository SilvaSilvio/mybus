import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase extends StatefulWidget {
  @override
  _FirebaseState createState() => _FirebaseState();
}

class _FirebaseState extends State<Firebase> {

  @override
  Future<void> initState() async {

   /* Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios")
    .where("nome", isEqualTo: "Darkson")
    .getDocuments();

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      print("Filtro nome:  ${dados["nome"]} idade: ${dados["idade"]}");
      
    }
*/

      FirebaseAuth auth = FirebaseAuth.instance;
  String email = "silviosilva@gmail.com";
  String password = "123456";
  auth.createUserWithEmailAndPassword(
    email: email,
    password: password
    );

    auth.signInWithEmailAndPassword(
      email: email,
      password: password
      ).then((firebaseUser){
       // print("Logado com sucesso " + firebaseUser.email);
      });

  


  //O primeiro caso ele solicita que defina um código.
    /*db.collection("Animais")
    .document("001")
    .setData(
      {
          "nome": "Furacão",
          "Pelo": "Preto"
      }
    );
    DocumentReference ref = await db.collection("Plantas")
    .add(
      {
        "nome":"Loiro Bosta",
        "Comprimento": 12
      }
      

    );
  print("Item Salvo" + ref.documentID );

//db.collection("Usuarios").document("002").delete();
  DocumentSnapshot snapshot = await db.collection("Usuarios").document("001").get();
   print(snapshot.data.toString());
  
//Responsável por realizar as buscas de uma coleção no banco de dados. O principal problema deste é que não atualiza os dados cadastrados.
  QuerySnapshot querySnapshot = await db.collection("Plantas").getDocuments();
    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
    print("Apareceça " + dados.toString());  
    }
     
    //Fala ao banco caso tenha alguma mudança no firebase.
     db.collection("Plantas").snapshots().listen(
       (snapshot){
         for (DocumentSnapshot item in snapshot.documents) {
      var dados = item.data;
    print("Apareceça " + dados.toString());  
    }
       }
     );
     */

    //Aplicando filtros.


    
  super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("dob")
        ],
      ),
    );
  }
}