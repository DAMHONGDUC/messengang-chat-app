import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/values/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  initialized,
  uninitilized,
  authenticating,
  authenticated,
  authenticateError,
  creatingAccount,
  createdAccount,
  creatingAccountError
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitilized;
  Status get status => _status;

  AuthProvider(
      {required this.prefs,
      required this.firebaseAuth,
      required this.firestore});

  // Future<QuerySnapshot> getUserByName(String ID) async {
  //   return await firestore
  //       .collection(FirestoreContants.userCollection)
  //       .where(FirestoreContants.id_user, isEqualTo: ID)
  //       .get();
  // }

  Future isLogIn() async {
    if (firebaseAuth.currentUser != null) {
      return true;
    } else
      return false;
  }

  UserChat? _userFromFirebase(User? user) {
    return user != null ? UserChat(id: user.uid, email: user.email) : null;
  }

  Future<QuerySnapshot> getUserByNameID(String ID) async {
    return await firestore
        .collection(FirestoreContants.userCollection)
        .where(FirestoreContants.id_user, isEqualTo: ID)
        .get();

    // await firestore
    //     .collection(FirestoreContants.userCollection)
    //     .where(FirestoreContants.id_user, isEqualTo: ID)
    //     .get()
    //     .then((SnapshotData) {
    //   print("_userFromFirebase2: " +
    //       SnapshotData.docs[0].get(FirestoreContants.photo_user));
    //   return UserChat(
    //       id: SnapshotData.docs[0].get(FirestoreContants.id_user),
    //       email: SnapshotData.docs[0].get(FirestoreContants.email_user),
    //       name: SnapshotData.docs[0].get(FirestoreContants.name_user),
    //       photo: SnapshotData.docs[0].get(FirestoreContants.photo_user));
    // });
  }

  UserChat? currUser() {
    User? user = firebaseAuth.currentUser;
    return user == null ? null : UserChat(id: user.uid, email: user.email);
  }

  Future<UserChat?> SignIn_WithEmailPasword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;

      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserChat?> SignUp_WithEmailPasword(
      String email, String password) async {
    // _status = Status.creatingAccount;
    // notifyListeners();

    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      // _status = Status.creatingAccountError;
      // notifyListeners();
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
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
