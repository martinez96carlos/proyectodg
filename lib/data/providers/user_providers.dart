import 'package:flutter/material.dart';
import 'package:waste_collection_app/models/user.dart';

class UserProviders with ChangeNotifier {
  User _user = User();

  User get user => _user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  RecolectorUser _recolectorUser = RecolectorUser();

  RecolectorUser get recolectorUser => _recolectorUser;
  set recolectorUser(RecolectorUser value) {
    _recolectorUser = value;
    notifyListeners();
  }

  GeneratorUser _generatorUser = GeneratorUser();

  GeneratorUser get generatorUser => _generatorUser;
  set generatorUser(GeneratorUser value) {
    _generatorUser = value;
    notifyListeners();
  }

  bool _userType = true;

  bool get userType => _userType;
  set userType(bool value) {
    _userType = value;
    notifyListeners();
  }

  void updatePhoto(String value) {
    _user.imageLink = value;
    notifyListeners();
  }
}
