import 'package:flutter/material.dart';

class LoginProviders extends ChangeNotifier {
  String _username = "";

  String get username => _username;
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String _password = "";

  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}
