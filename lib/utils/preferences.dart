import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveString({@required String key, String value = ""}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> loadString({@required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(key)) {
    await saveString(key: key, value: "");
  }
  return prefs.getString(key) ?? "";
}

Future<void> saveBool({@required String key, bool value = false}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<bool> loadBool({@required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(key)) {
    await saveBool(key: key, value: false);
  }
  return prefs.getBool(key) ?? false;
}
