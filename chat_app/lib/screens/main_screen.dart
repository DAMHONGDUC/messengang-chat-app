import 'package:chat_app/screens/call_screen.dart';
import 'package:chat_app/screens/chats_screen.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/screens/people_screen.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainsScreen extends StatefulWidget {
  const MainsScreen({Key? key}) : super(key: key);

  @override
  State<MainsScreen> createState() => _MainsScreenState();
}

class _MainsScreenState extends State<MainsScreen> {
  int _selectedIndex = 0;
  final screen = [
    ChatsScreen(),
    PeopleScreen(),
    CallScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: screen[_selectedIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: Icon(Icons.person_add_alt_1)),
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
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 28,
          ),
        ),
      ],
    );
  }
}
