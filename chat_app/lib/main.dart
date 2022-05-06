import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/providers/chatProvider.dart';
import 'package:chat_app/providers/databaseProvider.dart';
import 'package:chat_app/providers/verifyProvider.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:chat_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: ((context) => AuthProvider(
                  prefs: prefs,
                  firebaseAuth: firebaseAuth,
                  firestore: firebaseFirestore))),
          ChangeNotifierProvider(
              create: (context) =>
                  DatabaseProvider(firestore: firebaseFirestore)),
          ChangeNotifierProvider(
              create: (context) => VerifyProvider(
                    firebaseAuth: firebaseAuth,
                  )),
          ChangeNotifierProvider(
              create: (context) => ChatProvider(
                    firestore: firebaseFirestore,
                  )),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Messengang Chat Application',
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          home: WelcomeScreen(),
        ));
  }
}
