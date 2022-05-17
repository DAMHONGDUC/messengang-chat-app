import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firestore;

  ProfileProvider({required this.firebaseStorage, required this.firestore});

  UploadTask uploadImageFile(File image, String path, String fileName) {
    Reference reference = firebaseStorage.ref().child(path + fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(String collectionPath, String path,
      Map<String, dynamic> dataUpdateNeeded) {
    return firestore
        .collection(collectionPath)
        .doc(path)
        .update(dataUpdateNeeded);
  }
}
