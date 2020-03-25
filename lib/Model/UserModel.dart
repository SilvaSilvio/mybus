import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  String _tipoUsuario;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;
  void signUp(
      {@required Map<String, dynamic> userData,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: senha)
        .then((firebaseUser) async {
      db
          .collection("usuarios")
          .document(firebaseUser.user.uid)
          .setData(userData);

      //_redirecionaPainelPorTipoUsuario(firebaseUser.user.uid);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {



    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user as FirebaseUser;
      
      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

 void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  String identificaUsuario(String tipoUsuario) {
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

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("usuarios")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }


  void recuperarSenha(String email){
    _auth.sendPasswordResetEmail(email: email);
  }



  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }
  String get tipoUsuario => _tipoUsuario;
}



