import 'package:chat_app/providers/chatProvider.dart';
import 'package:chat_app/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);

    return Container(
      color: AppColor.kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: TextField(
            autofocus: true,
            onTap: () {},
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                prefixIcon: InkWell(
                  child: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  onTap: () {},
                ),
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'Search',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
