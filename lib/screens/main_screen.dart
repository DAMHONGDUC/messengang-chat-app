import 'package:chat_app/models/listchat.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/providers/databaseProvider.dart';
import 'package:chat_app/screens/call_screen.dart';
import 'package:chat_app/screens/listchat_screen.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/screens/people_screen.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainsScreen extends StatefulWidget {
  const MainsScreen({Key? key}) : super(key: key);

  @override
  State<MainsScreen> createState() => _MainsScreenState();
}

class _MainsScreenState extends State<MainsScreen> {
  int _selectedIndex = 0;
  final screen = [
    ListChat(data: chatsData),
    PeopleScreen(),
    CallScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: screen[_selectedIndex],
      bottomNavigationBar: buildBottomNavigatorBar(),
    );
  }

  BottomNavigationBar buildBottomNavigatorBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: ((value) {
          setState(() {
            _selectedIndex = value;
          });
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/1.png")),
              label: "Profile"),
        ]);
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text('Messengang Chats'),
      automaticallyImplyLeading: false,
    );
  }
}
