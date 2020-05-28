import 'package:flutter/material.dart';

class ControllersProvider with ChangeNotifier {
  int _pickerMenu = 1;

  int get pickerMenu => _pickerMenu;
  set pickerMenu(int value) {
    _pickerMenu = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isSearchOrders = false;

  bool get isSearchOrders => _isSearchOrders;
  set isSearchOrders(bool value) {
    _isSearchOrders = value;
    notifyListeners();
  }

  String _valueSearch = "";

  String get valueSearch => _valueSearch;
  set valueSearch(String value) {
    _valueSearch = value;
    notifyListeners();
  }

  bool _isLoadingDB = true;

  bool get isLoadingDB => _isLoadingDB;
  set isLoadingDB(bool value) {
    _isLoadingDB = value;
    notifyListeners();
  }

  bool _stillCreateOrder = false;

  bool get stillCreateOrder => _stillCreateOrder;
  set stillCreateOrder(bool value) {
    _stillCreateOrder = value;
    notifyListeners();
  }
}
