import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/listchat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/providers/chatProvider.dart';
import 'package:chat_app/providers/databaseProvider.dart';
import 'package:chat_app/widget/chat_inputfield.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/widget/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatefulWidget {
  final String roomID;
  final UserChat userChat;
  final UserChat currUser;
  const Message(
      {Key? key,
      required this.roomID,
      required this.userChat,
      required this.currUser})
      : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final chatInputController = new TextEditingController();

  @override
  void dispose() {
    chatInputController.dispose();
    super.dispose();
  }

  // chat input
  Widget chatInputField(ChatProvider chatProvider) {
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
                    onChanged: (text) {
                      print(chatInputController.text);
                    },
                    controller: chatInputController,
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
                      onTap: () {
                        // handle send message
                        ChatMessage chatMessage = new ChatMessage(
                          roomID: widget.roomID,
                          FromUser: widget.currUser.id.toString(),
                          text: chatInputController.text,
                          type: FirestoreContants.type_message_text,
                          time: DateTime.now().toString(),
                        );
                        chatProvider.sendChatMessage(chatMessage);
                      },
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

  // list message
  Widget ChatMessageList(ChatProvider chatProvider) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatProvider.getMessageWithChatroomID(widget.roomID),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          // if we got data
          if (snapshot.data!.docs.length == 0) {
            // if they haven't sent message
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/1.png"),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.userChat.name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Say Hi..."),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else {
            // if they have sent message

            // convert QuerySnapShot to List data
            List<ChatMessage> messageData = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              String UserID_sent =
                  snapshot.data!.docs[i][FirestoreContants.FromUser_message];

              messageData.add(ChatMessage(
                  roomID: widget.roomID,
                  FromUser: snapshot.data!.docs[i]
                      [FirestoreContants.FromUser_message],
                  text: snapshot.data!.docs[i][FirestoreContants.text_message],
                  type: snapshot.data!.docs[i][FirestoreContants.type_message],
                  time: snapshot.data!.docs[i]
                      [FirestoreContants.time_message]));
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return messageData[index].FromUser == widget.currUser.id
                      ? itemMessage_Sender(
                          message: messageData[index].text,
                        )
                      : itemMessage_receiver(
                          message: messageData[index].text,
                        );
                });
          }
        } else
          return Center(
            child: Text("Loading..."),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: buildAppbar(context, chatProvider),
      body: buildBody(context, chatProvider),
    );
  }

  // body
  SafeArea buildBody(BuildContext context, ChatProvider chatProvider) {
    return SafeArea(
        child: Container(
      color: Colors.grey.withOpacity(0.00),
      child: Column(
        children: [
          Expanded(
            child: ChatMessageList(chatProvider),
          ),
          chatInputField(chatProvider),
        ],
      ),
    ));
  }

  // appbar
  AppBar buildAppbar(BuildContext context, ChatProvider chatProvider) {
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
                widget.userChat.name!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.8),
                ),
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

// item message (sender)
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
          ]),
    );
  }
}

// item message (receiver)
class itemMessage_receiver extends StatelessWidget {
  final String message;
  const itemMessage_receiver({Key? key, required this.message})
      : super(key: key);

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
