import 'package:flutter/material.dart';

class UsernameProvider with ChangeNotifier {
  String _username = 'jack';
  String get username => _username;

  void setUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}
