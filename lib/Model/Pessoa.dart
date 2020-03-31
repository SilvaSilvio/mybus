import 'package:scoped_model/scoped_model.dart';

class Pessoa extends Model
{
  String nome, sexo, endereco, email;
  dynamic cpf, telefone;

  Pessoa({this.nome, this.cpf, this.sexo, this.endereco, this.email, this.telefone});
}