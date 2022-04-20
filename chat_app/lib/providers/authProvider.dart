import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SharedPreferences prefs;

  Status _status = Status.authenticating;
  Status get status => _status;

  AuthProvider(
      {required this.prefs,
      required this.firebaseAuth,
      required this.firestore});

  String? getUserFirebaseID() {
    return prefs.getString(FirestoreContants.id);
  }

  Future isLogIn() async {
    // code
  }

  UserChat? _userFromFirebase(User user) {
    return user != null ? UserChat(id: user.uid, email: user.email) : null;
  }

  Future SignIn_WithEmailPasword(String email, String password) async {
    _status = Status.authenticating;
    notifyListeners();

    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignUp_WithEmailPasword(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future ResetPasword(String email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignOut(String email) async {
    _status = Status.uninitialized;

    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
