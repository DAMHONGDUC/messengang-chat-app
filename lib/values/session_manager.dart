import 'package:chat_app/models/userChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String currUser = "currently_user";

  Future<void> setCurrUser(
      String email, String id, String name, String photo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(this.currUser, <String>[email, id, name, photo]);
  }

  Future<UserChat?> getCurrUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? items = pref.getStringList(this.currUser);
    print(items);
    if (items != null)
      return UserChat(
          email: items[0], id: items[1], name: items[2], photo: items[3]);
    else
      return null;
  }
}
