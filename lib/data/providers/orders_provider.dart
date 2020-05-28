import 'package:flutter/material.dart';
import 'package:waste_collection_app/models/orders.dart';

class OrdersProviders with ChangeNotifier {
  Order _orderActive = Order();

  Order get orderActive => _orderActive;
  set orderActive(Order value) {
    _orderActive = value;
    notifyListeners();
  }

  List<Order> _orders = [];

  List<Order> get orders => _orders;
  set orders(List<Order> value) {
    _orders = value;
    notifyListeners();
  }

  List<Order> _searchOrders = [];

  List<Order> get searchOrders => _searchOrders;
  set searchOrders(List<Order> value) {
    _searchOrders = value;
    notifyListeners();
  }

  List<Solids> _solids = [];

  List<Solids> get solids => _solids;
  set solids(List<Solids> value) {
    _solids = value;
    notifyListeners();
  }

  int obtainsNameSolid(int id) {
    return _solids.indexWhere((element) => element.id == id);
  }

  void changeStatusList(int value, int id) {
    _orders.forEach((element) {
      if (element.id == id) {
        element.state = value;
        element.recolectorId = 0;
      }
    });
    notifyListeners();
  }

  void changeRate(int value, int id) {
    _orders.forEach((element) {
      if (element.id == id) {
        element.rate = value;
      }
    });
    notifyListeners();
  }

  void changeStatus(int value) {
    _orderActive.state = value;
    notifyListeners();
  }

  void changeRateOrderActive(int value) {
    _orderActive.rate = value;
    notifyListeners();
  }

  void deleteSearchOrder(int id) {
    _searchOrders.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void changeImageLink(String value) {
    _orderActive.imageLink = value;
    notifyListeners();
  }

  void changeDateTime(String value) {
    _orderActive.dateTime = value;
    notifyListeners();
  }

  void addOrder(Order value) {
    _orders.add(value);
    notifyListeners();
  }

  void changeRecolectorId(int id) {
    _orderActive.recolectorId = id;
    notifyListeners();
  }

  void deleteOrder(int id) {
    _orders.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addSearch(Order order) {
    _searchOrders.add(order);
    notifyListeners();
  }
}
