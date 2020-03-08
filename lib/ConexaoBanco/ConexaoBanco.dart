import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexaoBanco extends StatefulWidget {
  @override
  _ConexaoBancoState createState() => _ConexaoBancoState();
}

class _ConexaoBancoState extends State<ConexaoBanco> {
  
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var db = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersionCreate) {
      String sql =
          "CREATE TABLE usuario(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario VARCHAR, senha VARCHAR)";
      db.execute(sql);
    });
    return db;
    //print("Aberto " + retorno.isOpen.toString() );
  }

  _salvarBancoDados() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "usuario": "Silvio",
      "senha": "Silva",
    };
    int id = await bd.insert("usuario", dadosUsuario);
    print("Salvo: $id");
  }

  _listarUsuario() async {
    Database bd = _recuperarBancoDados();

    String sql = "SELECT * FROM usuario";
    // Database bd = _recuperarBancoDados();
    List usuarios = await bd.rawQuery(sql);

    /*for (var usuario in usuarios) {
      print("Item id: " +
          usuario['id'].toString() +
          " Nome " +
          usuario['usuario'] +
          " Senha " +
          usuario['senha']);
    }*/
    print("Usuarios: " + usuarios.toString());
  }

  @override
  Widget build(BuildContext context) {
    _listarUsuario();


    return Container();
  }
}
