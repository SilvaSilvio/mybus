import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:mybus/ConexaoBanco/firebase.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

   TextEditingController _controllerNome = TextEditingController();
   File _imagem;
   String _idUsuarioLogado;
   bool _subindoImagem = false;
   String __urlImagemRecuperada;

   Future _recuperarImagem( String origemImagem ) async { 
      
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
        if ( _imagem != null ){
          _subindoImagem = true;
          _uploadImagem();
        }
      });
   }

   Future _uploadImagem() async { 
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference pastaRaiz = storage.ref();
      StorageReference arquivo = pastaRaiz
      .child("Perfil")
      .child( _idUsuarioLogado + ".jpg");

      // Upload da imagem
      StorageUploadTask task = arquivo.putFile( _imagem );

      //Controlar progresso do upload.
      task.events.listen((StorageTaskEvent storageEvent){
        if (storageEvent.type == StorageTaskEventType.progress ){
            setState(() {
              _subindoImagem = true;
            });
        }else if (storageEvent.type == StorageTaskEventType.success){
            setState(() {
              _subindoImagem = false;
            });
        }
      });

      task.onComplete.then(( StorageTaskSnapshot snapshot ){
          _recuperarUrlImagem( snapshot );
      });
   }
   _recuperarUrlImagem( StorageTaskSnapshot snapshot ) async {
     String  url = await snapshot.ref.getDownloadURL();
     _atualizarUrlImagemFirestore( url);

      setState(() {
        __urlImagemRecuperada = url;
      });

   }

   _recuperarDadosUsuario() async {
     FirebaseAuth auth = FirebaseAuth.instance;
     Firestore db = Firestore.instance;

     FirebaseUser usuarioLogado = await auth.currentUser();
     _idUsuarioLogado = usuarioLogado.uid;

     DocumentSnapshot snapshot = await db.collection("usuarios")
     .document( _idUsuarioLogado )
     .get();

     Map<String, dynamic> dados = snapshot.data;
     _controllerNome.text = dados["nome"];

     if ( "urlImagem" != null ){
        __urlImagemRecuperada = dados[ "urlImagem" ];
     }

   }

   _atualizarUrlImagemFirestore( String url ){
     Firestore db = Firestore.instance;

     Map<String, dynamic> dadosAtualizar = {
       "urlImagem" : url
     };

     db.collection("usuarios")
     .document(_idUsuarioLogado )
     .updateData( dadosAtualizar );
   }

    _atualizarNomeFirestore(){
      String nome = _controllerNome.text;
     Firestore db = Firestore.instance;

     Map<String, dynamic> dadosAtualizar = {
       "nome" : nome
     };

     db.collection("usuarios")
     .document(_idUsuarioLogado )
     .updateData( dadosAtualizar );
   }

   @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
    
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
                Container(
                  padding: EdgeInsets.all(16),
                  child: _subindoImagem
                ? CircularProgressIndicator() : Container()
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: 
                  __urlImagemRecuperada != null 
                  ? NetworkImage(__urlImagemRecuperada)
                  : null
                  
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
                        _atualizarNomeFirestore();
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
