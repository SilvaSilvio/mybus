import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;

  FirebaseUser firebaseUser;

  bool showPassword = false;

  Map<String, dynamic> userData = Map();

  get nome => null;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": nome,
    };

    return map;
  }

  bool isLoading = false;

  BuildContext context;

   // Pegar usuario ao iniciar o app
    @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }


  //Para Cadastro de Usuario.
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

          db.
          collection("Usuarios")
          .document(firebaseUser.user.uid)
        .setData( userData );
     // await _saveUserData(userData);

        // _direcionamentoPainelPorTipoUsuario(firebaseUser.user.uid);
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

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("Usuarios")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  //Verificar Usuario logado
  bool isLoggedIn() {
    return firebaseUser != null;
  }

  //Para entrar
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
         //firebaseUser = user as FirebaseUser;
     
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

  void _direcionamentoPainelPorTipoUsuario(String idUsuario) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection("Usuarios").document(idUsuario).get();

    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados["tipoUsuario"];
    print(tipoUsuario);
    switch (tipoUsuario) {
      case "Motorista":
        Navigator.pushReplacementNamed(context, "/painel-motorista");
        Navigator.of(context);
        break;
      case "Passageiro":
        Navigator.pushReplacementNamed(context, "/painel-passageiro");
        break;
      case "Administrador":
        Navigator.pushReplacementNamed(context, "/painel-administrador");
        break;
    }
  }

  signOut() async {
    await _auth.signOut();
   // Navigator.popAndPushNamed(context, "/");

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["nome"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("Usuarios")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

  void recuperarSenha(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  final googleSignIn = GoogleSignIn();

  Future<Null> googleSigIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) user = await googleSignIn.signIn();
    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: credentials.idToken, accessToken: credentials.accessToken));
    }
  }

  void incioCarregamento() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
  }

  void finalCarregamento() {
    isLoading = false;
    notifyListeners();
  }

  void teste() {
    isLoading = false;
    notifyListeners();
  }
}