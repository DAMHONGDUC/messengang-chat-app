import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/screens/singn_in_screen.dart';
import 'package:chat_app/screens/verification_screen.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
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
              "Sign Up",
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
                        labelText: 'Fullname',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
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
                        labelText: 'Country',
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
                                builder: (context) => VerificationScreen(
                                    number_phone: "+8435 521 1735")));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      child: Text('Sign up')),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Text(
                      'Sign in',
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
