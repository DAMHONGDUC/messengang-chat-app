import 'dart:io';
import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/providers/profileProvider.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "";
  String urlPhoto = "";


  Future getImage(ProfileProvider profileProvider) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString())
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      uploadFile(profileProvider, image);
    }
  }

  Future uploadFile(ProfileProvider profileProvider, File image) async {
    UploadTask uploadTask = profileProvider.uploadImageFile(
        image, FirestoreContants.storage_profileImagePath, "userID");
    try {
      TaskSnapshot snapshot = await uploadTask;
      await snapshot.ref.getDownloadURL().then((value) {
        setState(() {
          urlPhoto = value;
        });
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final ProfileProvider profileProvider = Provider.of<ProfileProvider>(
        context);
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text(email),
              Text('Username'),
              ElevatedButton(
                  onPressed: () {
                    authProvider.SignOut(email);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: ((context) => SignInScreen())));
                  },
                  child: Text('Log Out')),
              ElevatedButton(
                  onPressed: () {
                    getImage(profileProvider);
                  },
                  child: Text('Upload Image')),
              urlPhoto != ""
                  ? CircleAvatar(
                backgroundImage: NetworkImage(urlPhoto),
                radius: 50,
              )
                  : CircleAvatar(
                backgroundImage: AssetImage("assets/images/user_default.png"),
                radius: 50,
              ),
            ],
          ),
        ));
  }
}
