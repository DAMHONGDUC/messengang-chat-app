import 'package:chat_app/values/app_asstets.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:email_auth/email_auth.dart';
//import 'package:email_auth_example/auth.config.dart';

// class VerificationScreen extends StatelessWidget {
//   final String email;
//   const VerificationScreen({Key? key, required this.email}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 70,
//             ),
//             Image.asset(
//               Assets.Logo,
//               height: 100,
//               width: 100,
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Text(
//               "Verification",
//               style: Theme.of(context).textTheme.headline4!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 23),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               'SMS Verification code has been sent',
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               email,
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Pinput(
//               onCompleted: (pin) => print(pin),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                       minimumSize: Size.fromHeight(40),
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20)))),
//                   child: Text('Next')),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  EmailAuth? emailAuth;
  final TextEditingController _otpcontroller = TextEditingController();

  @override
  void initState() {
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    //emailAuth.config(remoteServerConfiguration);
    super.initState();
  }

  void verify() {
    print(emailAuth!.validateOtp(
        recipientMail: widget.email, userOtp: _otpcontroller.value.text));
  }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
    bool result =
        await emailAuth!.sendOtp(recipientMail: widget.email, otpLength: 2);
    if (result) {
    } else {}
  }

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
              widget.email,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Pinput(
                length: 6,
                controller: _otpcontroller,
                onCompleted: (pin) => print(pin),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  onPressed: () {
                    sendOtp();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: Text('Send OTP')),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  onPressed: () {
                    verify();
                  },
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
