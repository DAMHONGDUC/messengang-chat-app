import 'package:chat_app/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String? email;
  String? id;
  String? name;
  String? photo;
  UserChat({this.email, this.id, this.name, this.photo});

  Map<String, String> toJSON() {
    return {
      FirestoreContants.id: id!,
      FirestoreContants.email: email!,
      FirestoreContants.name: name!,
      FirestoreContants.photo: photo!,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String email1 = "";
    String id1 = "";
    String name1 = "";
    String photo1 = "";

    try {
      email1 = doc.get(FirestoreContants.email);
    } catch (e) {}
    try {
      id1 = doc.get(FirestoreContants.id);
    } catch (e) {}
    try {
      name1 = doc.get(FirestoreContants.name);
    } catch (e) {}
    try {
      photo1 = doc.get(FirestoreContants.photo);
    } catch (e) {}

    return UserChat(email: email1, id: id1, name: name1, photo: photo1);
  }
}
