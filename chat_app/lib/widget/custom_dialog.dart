import 'package:flutter/material.dart';

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
