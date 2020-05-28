import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/database/dbHelper.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/login_providers.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/ui/pages/login_page.dart';
import 'package:waste_collection_app/utils/preferences.dart' as preferences;

String validate(String value, String key) =>
    value.isEmpty ? "Por favor ingresa tu $key" : null;

void fieldFocusChange(
    FocusNode currentFocus, FocusNode nextFocus, BuildContext context) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

bool validateAll() {
  try {
    if (formLoginKey.currentState.validate()) {
      return true;
    } else {
      scaffoldLoginKey.currentState.showSnackBar(SnackBar(
        content: Text('Por favor llena los campos vacios'),
      ));
      return false;
    }
  } catch (e) {
    scaffoldLoginKey.currentState.showSnackBar(SnackBar(
      content: Text(
          'Ah ocurrido un error, vuelva a intentar, si el error persiste, reporte el error por favor'),
    ));
    return false;
  }
}

Future<void> savePreferences(BuildContext context) async {
  final login = Provider.of<LoginProviders>(context, listen: false);
  if (login.rememberMe) {
    await preferences.saveString(key: 'username', value: login.username);
    await preferences.saveString(key: 'password', value: login.password);
    await preferences.saveBool(key: 'rememberMe', value: true);
  }
  //print(await preferences.loadString(key: 'username'));
  //print(await preferences.loadString(key: 'password'));
  //print(await preferences.loadBool(key: 'rememberMe'));
}

Future<List<Order>> getAllOrders() async {
  var dbHelper = DBHelper();
  Future<List<Order>> orders = dbHelper.readAllOrders();
  return orders;
}

void initDataBase(BuildContext context) async {
  final ordersProvider = Provider.of<OrdersProviders>(context, listen: false);
  final controllers = Provider.of<ControllersProvider>(context, listen: false);
  List<Order> _orders = await getAllOrders();
  ordersProvider.orders = _orders;
  ordersProvider.orders.forEach((element) {
    element.mostrar();
  });
  controllers.isLoadingDB = false;
}

void chargePreferences(BuildContext context) async {
  final login = Provider.of<LoginProviders>(context, listen: false);
  //print(await preferences.loadString(key: 'username'));
  //print(await preferences.loadString(key: 'password'));
  //print(await preferences.loadBool(key: 'rememberMe'));

  if (await preferences.loadBool(key: 'rememberMe')) {
    login.username = await preferences.loadString(key: 'username');
    login.password = await preferences.loadString(key: 'password');
    login.rememberMe = await preferences.loadBool(key: 'rememberMe');
  }
}
