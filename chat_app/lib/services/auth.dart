import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebase(User user) {
    return user != null ? MyUser(userID: user.uid, email: user.email) : null;
  }

  Future SignIn_WithEmailPasword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignUp_WithEmailPasword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebase(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future ResetPasword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignOut(String email) async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
