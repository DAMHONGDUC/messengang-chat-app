import 'package:chat_app/models/userChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class DatabaseProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;

  DatabaseProvider({required this.firestore});

  UserChat? _userFromFirebase(User? user) {
    return user != null ? UserChat(id: user.uid, email: user.email) : null;
  }

  Future<QuerySnapshot> getUserByName(String name) async {
    return await firestore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: name)
        .get();
  }

  Future<void> UploadUser(userMap) async {
    await firestore.collection("users").add(userMap);
  }
}
