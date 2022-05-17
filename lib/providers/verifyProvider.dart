import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  bool _isVerify = false;
  bool get isVerify => _isVerify;

  VerifyProvider({required this.firebaseAuth});

  Future sendVerifycationEmail() async {
    User user = firebaseAuth.currentUser!;
    await user.sendEmailVerification();
  }

  Future checkEmailVerifyed() async {
    User user = firebaseAuth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      _isVerify = true;
      notifyListeners();
    } else {
      _isVerify = false;
      notifyListeners();
    }
  }
}
