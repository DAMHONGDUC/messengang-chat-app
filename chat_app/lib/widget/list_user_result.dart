import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListResult extends StatelessWidget {
  final QuerySnapshot SnapshotData;

  const ListResult({Key? key, required this.SnapshotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 5),
        child: ListView.builder(
            itemCount: SnapshotData.docs.length,
            itemBuilder: ((context, index) {
              return rowUser(
                userchat: UserChat(
                  email: "",
                  id: "",
                  name: SnapshotData.docs[index].get('name'),
                  photo: "",
                ),
              );
            })),
      ),
    );
  }
}

class rowUser extends StatelessWidget {
  final UserChat userchat;
  const rowUser({Key? key, required this.userchat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/1.png"),
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
      ]),
      title: Text(userchat.name.toString()),
      subtitle: Text(
        "Đã kết nối",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
