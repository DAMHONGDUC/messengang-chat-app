import 'package:chat_app/models/userChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  UserChat? getUserByUsername(String username) {
    FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  void UploadUser(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
}
