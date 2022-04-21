import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/providers/verifyProvider.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/screens/sign_in_screen.dart';
import 'package:chat_app/widget/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:email_auth/email_auth.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController? _otpcontroller;

  @override
  void initState() {
    _otpcontroller = new TextEditingController();
    VerifyProvider verifyProvider =
        Provider.of<VerifyProvider>(context, listen: false);
    verifyProvider.sendVerifycationEmail();
    super.initState();
  }

  @override
  void dispose() {
    _otpcontroller!.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, String text, VoidCallback onpress) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: onpress,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notification"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void Verify(VerifyProvider verifyProvider, BuildContext context) {
    verifyProvider.checkEmailVerifyed();
    if (verifyProvider.isVerify == true) {
      showAlertDialog(context, "Verification successful", () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => SignInScreen())));
      });
    } else {
      showAlertDialog(context, "Verification failed", () {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final VerifyProvider verifyProvider = Provider.of<VerifyProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.Logo,
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Verification",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Verification link has been sent to',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.email,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Please check your email',
            style: TextStyle(color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
                onPressed: () {
                  Verify(verifyProvider, context);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                child: Text('Verify')),
          ),
        ],
      )),
    );
  }
}
