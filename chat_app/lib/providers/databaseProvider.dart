import 'package:chat_app/constants/firestore_constants.dart';
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
        .collection(FirestoreContants.UserCollection)
        .where(FirestoreContants.nameUser, isGreaterThanOrEqualTo: name)
        .get();
  }

  // up load user with a custom documentID
  Future<void> UploadUser(userMap, String documentID) async {
    await firestore
        .collection(FirestoreContants.UserCollection)
        .doc(documentID)
        .set(userMap);
  }

  Future<void> createChatRoom(String chatRoomID, chatRoomMap) async {
    await firestore
        .collection(FirestoreContants.roomCollection)
        .add(chatRoomMap);
  }

  Future<QuerySnapshot> getChatRoom(String chatRoomID) async {
    return await firestore
        .collection(FirestoreContants.roomCollection)
        .where(FirestoreContants.roomID, isEqualTo: chatRoomID)
        .get();
  }

  // Future<String> downloadURL(String imageName) async {
  //   return await firestore.re;
  // }
}
