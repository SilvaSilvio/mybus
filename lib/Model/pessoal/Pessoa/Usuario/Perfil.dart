import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybus/Model/pessoal/Pessoa/Usuario.dart';

class Perfil extends Usuario {
  String id;

    Perfil({String nome,  String sexo, String endereco, String email, dynamic telefone}):
    super();

    Perfil.fromDocument(DocumentSnapshot snapshot){
      id = snapshot.documentID;
      nome = snapshot.data["nome"];
      telefone = snapshot.data["telefone"];
      email = snapshot.data["email"];
      
    }

}
