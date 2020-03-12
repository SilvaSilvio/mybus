
enum tipoUsuario{
  passageiro,
  motorista,
  administrador,

}

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