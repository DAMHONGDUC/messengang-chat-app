import 'dart:async';
import 'dart:ffi';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/providers/databaseProvider.dart';

import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/screens/search_screen.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/widget/custom_outline_button.dart';
import 'package:chat_app/widget/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListChat(data: chatsData);
  }
}

class ListChat extends StatelessWidget {
  final List<dynamic> data;
  const ListChat({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          child: Container(
            height: 68,
            width: double.infinity,
            color: AppColor.kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 15),
                      )
                    ],
                  )),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 5),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return rowChat(
                    chat: data[index],
                  );
                })),
          ),
        ),
      ],
    );
  }
}

class rowChat extends StatelessWidget {
  const rowChat({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Message(
                      chat: chat,
                    )));
      },
      child: ListTile(
        leading: chat.isActive
            ? Stack(children: [
                CircleAvatar(
                  backgroundImage: AssetImage(chat.image),
                  radius: 25,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: AppColor.kPrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).scaffoldBackgroundColor)),
                  ),
                )
              ])
            : CircleAvatar(
                backgroundImage: AssetImage(chat.image),
                radius: 25,
              ),
        trailing: Text(chat.time.toString()),
        title: Text(chat.name.toString()),
        subtitle: Text(
          chat.latestMess.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
