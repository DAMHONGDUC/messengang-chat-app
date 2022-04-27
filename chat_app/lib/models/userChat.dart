import 'package:chat_app/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String? email;
  String? id;
  String? name;
  String? photo;
  UserChat({this.email, this.id, this.name, this.photo});

  set setPhoto(String photo) {
    this.photo = photo;
  }

  set setName(String name) {
    this.name = name;
  }

  Map<String, String> toJSON() {
    return {
      FirestoreContants.id_user: id!,
      FirestoreContants.email_user: email!,
      FirestoreContants.name_user: name!,
      FirestoreContants.photo_user: photo!,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String email1 = "";
    String id1 = "";
    String name1 = "";
    String photo1 = "";

    try {
      email1 = doc.get(FirestoreContants.email_user);
    } catch (e) {}
    try {
      id1 = doc.get(FirestoreContants.id_user);
    } catch (e) {}
    try {
      name1 = doc.get(FirestoreContants.name_user);
    } catch (e) {}
    try {
      photo1 = doc.get(FirestoreContants.photo_user);
    } catch (e) {}

    return UserChat(email: email1, id: id1, name: name1, photo: photo1);
  }
}
