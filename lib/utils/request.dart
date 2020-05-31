import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/database/dbHelper.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/recolections_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/models/recolections.dart';
import 'package:waste_collection_app/models/user.dart';
import 'package:waste_collection_app/ui/pages/home_page.dart';
import 'package:waste_collection_app/ui/pages/order_form_page.dart';
import 'package:waste_collection_app/utils/configure.dart' as configure;
import 'package:http/http.dart' as http;
import 'package:waste_collection_app/ui/pages/orders_details_page.dart';

Future<bool> login(
    {@required String email,
    @required String password,
    @required BuildContext context}) async {
  final userProvider = Provider.of<UserProviders>(context, listen: false);

  if (await configure.checkInternet()) {
    try {
      var response = await http.get(Uri.encodeFull("${constant.urlBase}/login"),
          headers: {
            'email': '$email',
            'pass': '$password',
            'content-type': 'application/json'
          }).timeout(Duration(seconds: 10));
      print("decode: " + response.body);
      var decode = json.decode(response.body);
      if (decode['generator']) {
        GeneratorUser generator = GeneratorUser.fromJson(decode);
        User user = User(
            date: generator.date,
            rate: generator.rate,
            id: generator.id,
            secondName: generator.secondName,
            dni: generator.dni,
            secondLastName: generator.secondLastName,
            email: generator.email,
            gender: generator.gender,
            imageLink: generator.imageLink,
            lastName: generator.lastName,
            name: generator.name,
            phone: generator.phone);
        userProvider.generatorUser = generator;
        userProvider.user = user;
        userProvider.userType = true;
        return true;
      } else {
        RecolectorUser generator = RecolectorUser.fromJson(decode);
        User user = User(
            date: generator.date,
            rate: generator.rate,
            id: generator.id,
            secondName: generator.secondName,
            dni: generator.dni,
            secondLastName: generator.secondLastName,
            email: generator.email,
            gender: generator.gender,
            imageLink: generator.imageLink,
            lastName: generator.lastName,
            name: generator.name,
            phone: generator.phone);
        userProvider.recolectorUser = generator;
        userProvider.user = user;
        userProvider.userType = false;
        return true;
      }
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
      return false;
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> registerGenerator(
    {@required GeneratorUser user, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      final _body = jsonEncode({
        'generator_first_name': '${user.name}',
        'generator_second_name': '${user.secondName}',
        'generator_first_lastname': '${user.lastName}',
        'generator_second_lastname': '${user.secondLastName}',
        'generator_born_date': '${user.date}',
        'generator_gender': user.gender,
        'generator_email': '${user.email}',
        'generator_password': '${user.password}',
        'generator_phone': '${user.phone}',
        'generator_place': user.residence,
        'generator_ci': '${user.dni}'
      });
      var response = await http
          .post(Uri.encodeFull("${constant.urlBase}/createge"),
              headers: {"content-type": "application/json"}, body: _body)
          .timeout(Duration(seconds: 5));
      print(response.body);
      if (response.body.contains('true')) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> registerRecolector(
    {@required RecolectorUser user, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      final _body = jsonEncode({
        'recolector_first_name': '${user.name}',
        'recolector_second_name': '${user.secondName}',
        'recolector_first_lastname': '${user.secondName}',
        'recolector_second_lastname': '${user.secondLastName}',
        'recolector_born_date': '${user.date}',
        'recolector_gender': user.gender,
        'recolector_email': '${user.email}',
        'recolector_password': '${user.password}',
        'recolector_phone': '${user.phone}',
        'recolector_ci': '${user.dni}',
        'recolector_city': user.city
      });
      var response = await http
          .post(Uri.encodeFull("${constant.urlBase}/createre"),
              headers: {"content-type": "application/json"}, body: _body)
          .timeout(Duration(seconds: 5));
      print(response.body);
      if (response.body.contains('true')) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> editGenerator(
    {@required GeneratorUser user, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      final _body = jsonEncode({
        'generator_first_name': '${user.name}',
        'generator_second_name': '${user.secondName}',
        'generator_first_lastname': '${user.lastName}',
        'generator_second_lastname': '${user.secondLastName}',
        'generator_born_date': '${user.date}',
        'generator_gender': user.gender,
        'generator_email': '${user.email}',
        'generator_password': '${user.password}',
        'generator_phone': '${user.phone}',
        'generator_place': user.residence,
        'generator_ci': '${user.dni}',
        'generator_picture_url': ''
      });
      var response = await http
          .put(Uri.encodeFull("${constant.urlBase}/editge"),
              headers: {
                "content-type": "application/json",
                'id': user.id.toString()
              },
              body: _body)
          .timeout(Duration(seconds: 5));
      Map<String, dynamic> decode = json.decode(response.body);
      if (decode['status'] == 'Datos actualizados correctamente') {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> editRecolector(
    {@required RecolectorUser user, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      final _body = jsonEncode({
        'recolector_first_name': '${user.name}',
        'recolector_second_name': '${user.secondName}',
        'recolector_first_lastname': '${user.secondName}',
        'recolector_second_lastname': '${user.secondLastName}',
        'recolector_born_date': '${user.date}',
        'recolector_gender': user.gender,
        'recolector_email': '${user.email}',
        'recolector_password': '${user.password}',
        'recolector_phone': '${user.phone}',
        'recolector_ci': '${user.dni}',
        'recolector_city': user.city,
        'recolector_picture_url': ''
      });
      var response = await http
          .put(Uri.encodeFull("${constant.urlBase}/editre"),
              headers: {
                "content-type": "application/json",
                'id': user.id.toString()
              },
              body: _body)
          .timeout(Duration(seconds: 5));
      Map<String, dynamic> decode = json.decode(response.body);
      if (decode['status'] == 'Datos actualizados correctamente') {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> deleteOrder(
    {@required String id, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      var response = await http.put(
          Uri.encodeFull("${constant.urlBase}/orders/$id"),
          headers: {"content-type": "application/json"});
      print(response.body);
      Map<dynamic, dynamic> decode = json.decode(response.body);
      print("decode: " + decode.toString());
      if (decode['status'] == 'Orden eliminada') {
        return true;
      } else if (decode['status'] == 'El pedido se esta recolectando') {
        scaffoldHomeKey.currentState.showSnackBar(SnackBar(
          content: Text('No puede cancelarse, ya fue asignada a un recolector'),
        ));
      } else {
        scaffoldHomeKey.currentState.showSnackBar(SnackBar(
          content: Text('Ocurrio un error, no se pudo eliminar'),
        ));
      }
      return false;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldHomeKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> addOrder(
    {@required int idGenerator, @required BuildContext context}) async {
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  final user = Provider.of<UserProviders>(context, listen: false);

  final _body = jsonEncode({
    "generator_id": idGenerator,
    "order_date": orderProvider.orderActive.dateTime + ":00",
    "order_detail": orderProvider.orderActive.details,
    "order_image_url": orderProvider.orderActive.imageLink,
    "order_latitude": orderProvider.orderActive.latLng.split(",")[0],
    "order_longitude": orderProvider.orderActive.latLng.split(",")[1]
  });

  if (await configure.checkInternet()) {
    try {
      var response = await http
          .post(Uri.encodeFull("${constant.urlBase}/orders"),
              headers: {"content-type": "application/json"}, body: _body)
          .timeout(Duration(seconds: 5));
      Map<dynamic, dynamic> decode = json.decode(response.body);
      print("decode: " + decode.toString());
      print(decode);
      orderProvider.orderActive.id = decode['order_id'];
      orderProvider.orderActive.generatorId = user.user.id;
      orderProvider.orderActive.mostrar();
      orderProvider.addOrder(orderProvider.orderActive);
      scaffoldOrderFormPage.currentState
          .showSnackBar(SnackBar(content: Text('Se registro correctamante')));
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldOrderFormPage.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldOrderFormPage.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldOrderFormPage.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> getOrdersByGenerator(
    {@required String id, @required BuildContext context}) async {
  print(id);
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  var dbHelper = DBHelper();
  if (await configure.checkInternet()) {
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/ordergenerator/$id"));
      print("decode: " + response.body);
      var data = json.decode(response.body) as List;
      List<Order> _orders = data.map((data) => Order.fromJson(data)).toList();
      _orders.forEach((order) async {
        order.mostrar();
        if (await dbHelper.createOrder(order) != 0) {
          print("registro en BD");
          orderProvider.addOrder(order);
        }
      });
      return true;
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldHomeKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> getOrdersByRecolector(
    {@required String id, @required BuildContext context}) async {
  print(id);
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  var dbHelper = DBHelper();
  if (await configure.checkInternet()) {
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/orderrecolector/$id"));
      print("decode: " + response.body);
      var data = json.decode(response.body) as List;
      List<Order> _orders = data.map((data) => Order.fromJson(data)).toList();
      _orders.forEach((order) async {
        order.mostrar();
        if (await dbHelper.createOrder(order) != 0) {
          print("registro en BD");
          orderProvider.addOrder(order);
        }
      });
      return true;
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldHomeKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> searchOrders({@required BuildContext context}) async {
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  if (await configure.checkInternet()) {
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/orders"))
          .timeout(Duration(seconds: 5));
      print("decode: " + response.body);
      var data = json.decode(response.body) as List;
      List<Order> _orders = data.map((data) => Order.fromJson(data)).toList();
      orderProvider.searchOrders = _orders;
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      orderProvider.searchOrders = [];
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
      return false;
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      orderProvider.searchOrders = [];
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> getSolids({@required BuildContext context}) async {
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  if (await configure.checkInternet()) {
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/solids"))
          .timeout(Duration(seconds: 5));
      print("decode: " + response.body);
      var data = json.decode(response.body) as List;
      List<Solids> _solids = data.map((data) => Solids.fromJson(data)).toList();
      orderProvider.solids = _solids;
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      orderProvider.orders = [];
      return false;
    }
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> orderPick(
    {@required int orderId,
    @required int recolectorId,
    @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    print(orderId);
    print(recolectorId);
    try {
      final _body =
          jsonEncode({'order_id': orderId, 'recolector_id': recolectorId});
      var response = await http.put(
          Uri.encodeFull("${constant.urlBase}/orderpick"),
          body: _body,
          headers: {"content-type": "application/json"});
      print("decode: " + response.body);
      var data = json.decode(response.body);
      if (data['status'] == "Ya puedes recolectar la orden") {
        return true;
      } else {
        orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                'No se puede recolectar esta orden, alguien mas ya lo esta haciendo')));
      }
      return false;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
      return false;
    } catch (e) {
      print('Excepcion del server: ' + e.toString());
      orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> cancelPick(
    {@required int orderId,
    @required int recolectorId,
    @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      final _body =
          jsonEncode({'order_id': orderId, 'recolector_id': recolectorId});
      var response = await http.put(
          Uri.encodeFull("${constant.urlBase}/cancelpick"),
          body: _body,
          headers: {"content-type": "application/json"});
      print("decode: " + response.body);
      if (response.body.contains("Recolección cancelada")) {
        return true;
      } else {
        scaffoldHomeKey.currentState.showSnackBar(SnackBar(
          content: Text('Ocurrio un error, vuelva a intentarlo'),
        ));
      }
      return false;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> updateRateRecolection(
    {@required int orderId,
    @required int rate,
    @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    try {
      var response = await http
          .put(Uri.encodeFull("${constant.urlBase}/ratere"), headers: {
        "content-type": "application/json",
        "order_id": orderId.toString(),
        "recolection_rate": rate.toString()
      });
      print("decode: " + response.body);
      Map<String, dynamic> decode = json.decode(response.body);
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text(decode['status']),
      ));
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> sendRecolections(
    {@required String id,
    @required dynamic recolections,
    @required int orderRate,
    @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    print("id: $id orderRate: $orderRate");
    print(recolections);
    try {
      var response = await http
          .post(Uri.encodeFull("${constant.urlBase}/recolections"),
              headers: {
                'Content-Type': 'application/json',
                'orderid': id,
                'rate': orderRate.toString()
              },
              body: recolections)
          .timeout(Duration(seconds: 5));
      print(response.body);
      Map<String, dynamic> decode = json.decode(response.body);
      if (decode['status'] == "Recoleccion finalizada correctamente") {
        return true;
      } else {
        orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('No se puedo recolectar, vuelva a intentar'),
        ));
      }
      return false;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    orderDetatilsScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> getRecolections(
    {@required String id, @required BuildContext context}) async {
  if (await configure.checkInternet()) {
    final recolectionProvider =
        Provider.of<RecolectionsProvider>(context, listen: false);
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/recolections/$id"))
          .timeout(Duration(seconds: 5));
      print(response.body);
      var data = json.decode(response.body) as List;
      List<Recolection> _recolections =
          data.map((data) => Recolection.fromJson(data)).toList();
      recolectionProvider.recolections = _recolections;
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldHomeKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}

Future<bool> getRateOrder(
    {@required String id, @required BuildContext context}) async {
  final db = DBHelper();
  if (await configure.checkInternet()) {
    final order = Provider.of<OrdersProviders>(context, listen: false);
    try {
      var response = await http
          .get(Uri.encodeFull("${constant.urlBase}/rates/$id"))
          .timeout(Duration(seconds: 5));
      print(response.body);
      Map<String, dynamic> data = json.decode(response.body);
      order.changeRateOrderActive(data['order_rate']);
      order.changeRate(data['order_rate'], int.parse(id), 2);
      await db.updateStatusOrder(order.orderActive.id, 2);
      await db.updateRateOrder(order.orderActive.id, order.orderActive.rate);
      return true;
    } on TimeoutException catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Esto esta demorando bastante, vuelva a intentarlo mas tarde'),
      ));
    } catch (e) {
      print('Excepcion: ' + e.toString());
      scaffoldHomeKey.currentState.showSnackBar(SnackBar(
        content: Text('Ah ocurrido un error, vuelva a intentarlo'),
      ));
      return false;
    }
  } else {
    scaffoldHomeKey.currentState.showSnackBar(SnackBar(
      content: Text('No hay conexión a internet'),
    ));
  }
  return false;
}
