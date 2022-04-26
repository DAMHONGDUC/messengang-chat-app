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
      FirestoreContants.idUser: id!,
      FirestoreContants.emailUser: email!,
      FirestoreContants.nameUser: name!,
      FirestoreContants.photoUser: photo!,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String email1 = "";
    String id1 = "";
    String name1 = "";
    String photo1 = "";

    try {
      email1 = doc.get(FirestoreContants.emailUser);
    } catch (e) {}
    try {
      id1 = doc.get(FirestoreContants.idUser);
    } catch (e) {}
    try {
      name1 = doc.get(FirestoreContants.nameUser);
    } catch (e) {}
    try {
      photo1 = doc.get(FirestoreContants.photoUser);
    } catch (e) {}

    return UserChat(email: email1, id: id1, name: name1, photo: photo1);
  }
}
