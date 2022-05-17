import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;

  const CustomOutlineButton(
      {Key? key, required this.title, required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onpress,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
          side: MaterialStateProperty.all(BorderSide(
              color: Colors.white, width: 1.0, style: BorderStyle.solid))),
    );
  }
}
