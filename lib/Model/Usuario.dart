
class Usuario1 {
  String _idUsuario;
  String _nome;
  String _telefone;
  String _email;
  String _username;
  String _senha;
  String _tipoUsuario;
  int cpf;
  // List<TiposUsuario> tipoUsuario = [TiposUsuario.Passageiro, TiposUsuario.Motorista, TiposUsuario.Administrador];

  Usuario1();


  

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

  String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }
}
