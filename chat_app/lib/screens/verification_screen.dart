import 'package:chat_app/values/app_asstets.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "Verification",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 23),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'SMS Verification code has been sent',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              email,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Pinput(
              onCompleted: (pin) => print(pin),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: Text('Next')),
            ),
          ],
        ),
      )),
    );
  }
}
