import 'package:flutter/material.dart';
import 'package:mybus/telas/Home.dart';
import 'package:mybus/telas/TelaAdministrador/PainelAdministrador.dart';
import 'package:mybus/telas/TelaMotorista/PainelMotorista.dart';
import 'package:mybus/telas/TelaPassageiro/PainelPassageiro.dart';
import 'package:mybus/telas/TelaPassageiro/Telas/Configura%C3%A7%C3%B5es.dart';


class Rotas {

  static Route<dynamic> gerarRotas(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
        break;
      case "/painel-passageiro" :
        return MaterialPageRoute(
            builder: (_) => PainelPassageiro()
        );
        break;
         case "/painel-motorista" :
        return MaterialPageRoute(
            builder: (_) => PainelMotorista()
        );
        break;
        case "/painel-administrador" :
        return MaterialPageRoute(
            builder: (_) => PainelAdministrador()
        );
        case "/configuracoes" :
        return MaterialPageRoute(
          builder: (_) => Configuracoes()
           );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );

  }

}