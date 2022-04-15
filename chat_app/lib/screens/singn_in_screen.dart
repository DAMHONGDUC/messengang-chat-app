import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/screens/sign_up_screen.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset(
              Assets.Logo,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Sign in",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 23),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'Phone',
                          labelStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatsScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      child: Text('Sign in')),
                ],
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }
}
