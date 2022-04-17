import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;

  get isLoading => _isLoading;

  void set_isloading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
