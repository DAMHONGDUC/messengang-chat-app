import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;

  ChatProvider({required this.firestore});

  Stream<QuerySnapshot> getMessageWithChatroomID(String roomID) {
    return FirebaseFirestore.instance
        .collection(FirestoreContants.messageCollection)
        .where(FirestoreContants.roomID_room, isEqualTo: roomID)
        .snapshots();
  }

  Future<void> sendChatMessage(ChatMessage chatMessage) async {
    // await firestore
    //     .collection(FirestoreContants.messageCollection)
    //     .add(messageMap);
    await firestore
        .collection(FirestoreContants.messageCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      FirestoreContants.roomID_message: chatMessage.roomID,
      FirestoreContants.FromUser_message: chatMessage.FromUser,
      FirestoreContants.text_message: chatMessage.text,
      FirestoreContants.type_message: chatMessage.type,
      FirestoreContants.time_message: chatMessage.time,
    });
  }
}
