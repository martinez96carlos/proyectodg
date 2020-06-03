import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/utils/request.dart' as request;

String pickImage(String title) {
  if (title.contains('metal') || title.contains('metales')) {
    return constant.assetsCards['metal'];
  } else if (title.contains('plastico') ||
      title.contains('plasticos') ||
      title.contains('plastica') ||
      title.contains('plasticas')) {
    return constant.assetsCards['pet'];
  } else if (title.contains('papel') || title.contains('papeles')) {
    return constant.assetsCards['papel'];
  } else if (title.contains('vidrio') || title.contains('vidrios')) {
    return constant.assetsCards['vidrio'];
  } else {
    return constant.assetsCards['papel'];
  }
}

String dateText(String dateReceived) {
  try {
    String date = dateReceived.split(" ")[0];

    DateTime now = DateTime.now();

    String day = date.split("-")[0];
    if (day[0] == '0') {
      day = day.substring(1, day.length);
    }
    String month = date.split("-")[1];
    if (month[0] == '0') {
      month = month.substring(1, month.length);
    }
    String year = date.split("-")[2];

    if (year == now.year.toString() && month == now.month.toString()) {
      if (int.parse(day) == now.day - 1) {
        return "Ayer";
      } else if (int.parse(day) == now.day) {
        return "Hoy";
      } else if (int.parse(day) == now.day + 1) {
        return "Mañana";
      }
    }
    return date;
  } catch (e) {
    return dateReceived;
  }
}

String changeDate(int date) {
  if (date < 10) {
    return "0${date.toString()}";
  }
  return date.toString();
}

void addDateTimeToRegisterOrder(BuildContext context) async {
  final order = Provider.of<OrdersProviders>(context, listen: false);
  try {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 5),
        lastDate: DateTime(2100, 8));
    if (date != null) {
      final TimeOfDay time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      order.changeDateTime(
          "${date.year.toString()}-${changeDate(date.month)}-${changeDate(date.day)}" +
              " ${changeDate(time.hour)}:${changeDate(time.minute)}");
      print(order.orderActive.dateTime);
    }
  } catch (e) {
    print("Exception: " + e.toString());
    order.orderActive.dateTime = "";
  }
}

bool validateOrder(BuildContext context) {
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  if (orderProvider.orderActive.details.length > 5 &&
      orderProvider.orderActive.latLng != "" &&
      orderProvider.orderActive.dateTime != "") {
    return true;
  }
  return false;
}

Future<void> getOrdersGenerator(BuildContext context, String id) async {
  await request.getOrdersByGenerator(id: id, context: context);
}

Future<void> getOrdersRecolector(BuildContext context, String id) async {
  await request.getOrdersByRecolector(id: id, context: context);
}
