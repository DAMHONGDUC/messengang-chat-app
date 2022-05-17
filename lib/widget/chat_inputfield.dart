import 'package:chat_app/values/app_colors.dart';
import 'package:flutter/material.dart';

class chatsInputField extends StatelessWidget {
  const chatsInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              top: 10,
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mic,
                  color: Color.fromARGB(255, 0, 127, 232),
                )),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                top: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Type message', border: InputBorder.none),
                  )),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.attach_file,
                        color: Color.fromARGB(255, 0, 127, 232),
                        size: 20,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Color.fromARGB(255, 0, 127, 232),
                        size: 20,
                      )),
                  SizedBox(
                    width: 13,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 0, 127, 232),
                        size: 20,
                      )),
                  SizedBox(
                    width: 13,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
