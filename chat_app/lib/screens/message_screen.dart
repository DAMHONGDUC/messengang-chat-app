import 'package:chat_app/models/listchat.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/widget/chat_inputfield.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final List<ChatMessage> listMessageData;
  final String roomID;
  final UserChat userChat;
  const Message(
      {Key? key,
      required this.listMessageData,
      required this.roomID,
      required this.userChat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: buildBody(context),
    );
  }

  SafeArea buildBody(context) {
    return SafeArea(
        child: Container(
      color: Colors.grey.withOpacity(0.00),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listMessageData.length,
                  itemBuilder: ((context, index) {
                    return listMessageData[index].isSender
                        ? itemMessage_Sender(
                            message: listMessageData[index].text,
                          )
                        : itemMessage(
                            message: listMessageData[index].text,
                          );
                  }))),
          chatsInputField(),
        ],
      ),
    ));
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      elevation: 2,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/1.png"),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userChat.name!,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.65),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.call),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(
          width: 7,
        ),
      ],
    );
  }
}

class itemMessage_Sender extends StatelessWidget {
  final String message;
  const itemMessage_Sender({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 35, 156, 255),
              size: 14,
            )
            // CircleAvatar(
            //   backgroundImage: AssetImage("assets/images/4.png"),
            //   radius: 17,
            // ),
          ]),
    );
  }
}

class itemMessage extends StatelessWidget {
  final String message;
  const itemMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/4.png"),
          radius: 17,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ]),
    );
  }
}
