import 'package:chat_app/models/listchat.dart';
import 'package:chat_app/models/userChat.dart';
import 'package:chat_app/providers/databaseProvider.dart';
import 'package:chat_app/screens/message_screen.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:chat_app/widget/list_user_result_search.dart';
import 'package:chat_app/widget/loadingWidget.dart';
import 'package:chat_app/widget/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  late QuerySnapshot searchSnapshot;
  bool isExecuted = false;
  bool isExecuting = false;

  @override
  void initState() {
    searchController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // handle when click to search button
  void Search(DatabaseProvider databaseProvider) {
    setState(() {
      isExecuting = true;
    });
    databaseProvider.getUserByName(searchController.text).then((value) {
      if (value != null) {
        searchSnapshot = value;

        setState(() {
          isExecuted = true;
        });
        setState(() {
          isExecuting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isExecuted = false;
            searchController.text = "";
          });
        },
        child: Icon(Icons.clear),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text('Messengang Chats'),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: TextField(
                  onChanged: (text) {
                    if (text.length == 0) {
                      setState(() {
                        isExecuted = false;
                      });
                    }
                  },
                  controller: searchController,
                  autofocus: true,
                  onTap: () {},
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        child: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(1),
                        ),
                        onTap: () {
                          Search(databaseProvider);
                        },
                      ),
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          isExecuted
              ? searchSnapshot.docs.length == 0
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "No result",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  : ListResult(
                      SnapshotData: searchSnapshot,
                    )
              : isExecuting
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: LoadingWidget())
                  : Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Search any people",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
