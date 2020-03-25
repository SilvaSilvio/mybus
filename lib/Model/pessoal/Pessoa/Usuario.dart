
import 'package:mybus/Model/Pessoa.dart';

class Usuario extends Pessoa
{
  String username;
  dynamic senha;
  String _tipoUsuario;

  // 0: administrador, 1: motorista, 2: cliente
  List<Usuario> tipos;

  Usuario({this.username, this.senha, this.tipos, String nome, dynamic cpf, String sexo, String endereco, String email, dynamic telefone}):
    super(nome: nome, cpf: cpf, sexo: sexo, endereco: endereco, email: email, telefone: telefone);

String identificaUsuario(bool tipoUsuario){
    return tipoUsuario ? "Motorista" : "Passageiro";
  }

  String identificarUsuario(String tipoUsuario) {
    var tipoUsuario;
    if (tipoUsuario == "Passageiro") {
      tipoUsuario = "Passageiro";
    } else if (tipoUsuario == "Motorista") {
      tipoUsuario = "Motorista";
    } else if (tipoUsuario == "Administrador") {
      tipoUsuario = "Administrador";
    }
    return tipoUsuario;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
      "TipoUsuario": this.tipoUsuario,
    };

    return map;
  }

String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }


}
