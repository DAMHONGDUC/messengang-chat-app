import 'package:chat_app/models/chat.dart';
import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/values/app_asstets.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/widget/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 5),
            child: ListView.builder(
                itemCount: chatsData.length,
                itemBuilder: ((context, index) {
                  return rowChat(
                    chat: chatsData[index],
                  );
                })),
          ),
        )
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
