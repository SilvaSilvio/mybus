import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  File _imagem;
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo =
        pastaRaiz.child("Perfil").child(_idUsuarioLogado + ".jpg");

    //Upload da imagem
    StorageUploadTask task = arquivo.putFile(_imagem);
    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent) {
      if (storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(url);

    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _atualizarNomeFirestore() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String telefone = _controllerTelefone.text;
    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "nome": nome,
      "email": email,
      "telefone": telefone
    };

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  _atualizarUrlImagemFirestore(String url) {
    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {"urlImagem": url};

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(_idUsuarioLogado).get();

    Map<String, dynamic> dados = snapshot.data;
    _controllerNome.text = dados["nome"];
    _controllerEmail.text = dados["email"];
    _controllerTelefone.text = dados["telefone"];

    if (dados["urlImagem"] != null) {
      _urlImagemRecuperada = dados["urlImagem"];
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  child: _subindoImagem
                      ? CircularProgressIndicator()
                      : Container(),
                ),
                CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: _urlImagemRecuperada != null
                        ? NetworkImage(_urlImagemRecuperada)
                        : null),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    
                    FlatButton(
                      child: Text("Câmera"),
                      onPressed: () {
                        _recuperarImagem("camera");
                      },
                    ),
                    FlatButton(
                      child: Text("Galeria"),
                      onPressed: () {
                        _recuperarImagem("galeria");
                      },
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    /*onChanged: (texto){
                      _atualizarNomeFirestore(texto);
                    },*/
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerTelefone,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    /*onChanged: (texto){
                      _atualizarNomeFirestore(texto);
                    },*/
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "Telefone",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: RaisedButton(
                      child: Text(
                        "Alterar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        _atualizarNomeFirestore();
                      }),
                )
              ],
            ),
          ),
        ),
    );
  }
}
