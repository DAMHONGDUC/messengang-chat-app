import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  void setSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}
