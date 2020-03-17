import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

   TextEditingController _controllerNome = TextEditingController();

   Future _recuperarImagem( String origemImagem ) async { 
      File _imagem;
      File _imagemSelecionada;
      switch( origemImagem ){
        case "Camera" :
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
        case "Galeria" :
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
      }
      setState(() {
        _imagem = _imagemSelecionada;
      });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage("https://scontent.fbsb12-1.fna.fbcdn.net/v/t31.0-8/28827008_1435031969942079_3546758467376867058_o.jpg?_nc_cat=109&_nc_sid=85a577&_nc_eui2=AeEXc27ChU6n2R8ERqfaSwGl5q7ziYiDCHhemIozi2PE1V86umS9VFoWzQL7zVvXRqZSVAoGnLpZuhttUdgib1IMcPQcyGOpjW85PRHNhd4yfA&_nc_ohc=0YOz25xYZ_sAX-fRkOQ&_nc_ht=scontent.fbsb12-1.fna&oh=48446923f6ad85253b227a04462277aa&oe=5E967265"),
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: new Text("Camera"),
                      onPressed: () {
                        _recuperarImagem("Camera");
                      },
                    ),
                     FlatButton( 
                      child: new Text("Galeria"),
                      onPressed: () {
                        _recuperarImagem("Galeria");
                      },
                    ),
                  ],
                ),
                 Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    //autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                    Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onPressed: () {
                        
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
