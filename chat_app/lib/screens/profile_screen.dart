import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:chat_app/services/authService.dart';
import 'package:chat_app/values/shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthServices authServices = new AuthServices();
  String? email;

  getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString(SharedKeys.email) ?? "nothing";
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text(email ?? "nothing"),
          Text('Username'),
          ElevatedButton(
              onPressed: () {
                authServices.SignOut(email ?? "nothing");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => SignInScreen())));
              },
              child: Text('Log Out'))
        ],
      ),
    ));
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //final authServices = Provider.of<AuthServices>(context);
//     final AuthServices authServices = new AuthServices();
//     String? email;

//     void getUsername() async {
//       // Obtain shared preferences.
//       final prefs = await SharedPreferences.getInstance();
//       email = prefs.getString(SharedKeys.email);
//     }

//     return Scaffold(
//         body: SafeArea(
//       child: Column(
//         children: [
//           Text('Email'),
//           Text('Username'),
//           ElevatedButton(
//               onPressed: () {
//                 authServices.SignOut("hongduc001h@gmail.com");
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: ((context) => SignInScreen())));
//               },
//               child: Text('Log Out'))
//         ],
//       ),
//     )
//     );
//   }
// }
