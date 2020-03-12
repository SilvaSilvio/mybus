import 'package:mybus/Model/TiposUsuario.dart';

class Usuario {
  String _idUsuario;
  String _nome;
  String _telefone;
  String _email;
  String _username;
  String _senha;
    List<TiposUsuario> tipoUsuario = [];

  Usuario();

  String verificarTipoUsuario(int tipoUsuario) {
    var tipoUsuario;
    if (tipoUsuario == 1) {
      tipoUsuario = "Passageiro";
    } else if (tipoUsuario == 2) {
      tipoUsuario = "Motorista";
    } else {
      tipoUsuario = "Administrador";
    }
    return tipoUsuario;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
      "TipoUsuario ": this.tipoUsuario,
    };

    return map;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }
}

enum TiposUsuario { Passageiro, Motorista, Administrador }
