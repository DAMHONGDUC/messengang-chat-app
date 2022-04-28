import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/message.dart';
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
        .collection(FirestoreContants.userCollection)
        .where(FirestoreContants.name_user, isGreaterThanOrEqualTo: name)
        .get();
  }

  // up load user with a custom documentID
  Future<void> UploadUser(userMap, String documentID) async {
    await firestore
        .collection(FirestoreContants.userCollection)
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
        .where(FirestoreContants.roomID_room, isEqualTo: chatRoomID)
        .get();
  }

  getMessageWithChatroomID(String chatRoomID) async {
    return await firestore
        .collection(FirestoreContants.messageCollection)
        .where(FirestoreContants.roomID_room, isEqualTo: chatRoomID)
        .snapshots();
  }

  // Stream<List<ChatMessage>> getMessageWithChatroomID(String chatRoomID, String currUserID)  {

  //    Stream<QuerySnapshot> stream =
  //     firestore.collection(FirestoreContants.messageCollection)
  //     .where(FirestoreContants.roomID_room, isEqualTo: chatRoomID)
  //     .snapshots();

  //   return stream.map(
  //     (qShot) => qShot.docs.map(
  //       (doc) {
  //         String UserID_sent =
  //             doc.get(FirestoreContants.UserID_message);

  //         bool isSender = false;
  //         if (UserID_sent == currUserID) isSender = true;
  //         return ChatMessage(text: doc.get(FirestoreContants.text_message),
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: isSender);
  //       }
  //     ).toList()
  //   );
  // }

  // Future<String> downloadURL(String imageName) async {
  //   return await firestore.re;
  // }
}
