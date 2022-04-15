import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/widget/custom_outline_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColor.kPrimaryColor,
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              CustomOutlineButton(
                title: 'Recent Message',
                onpress: () {},
              ),
              SizedBox(
                width: 15,
              ),
              CustomOutlineButton(
                title: 'Active',
                onpress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
