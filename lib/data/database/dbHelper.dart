import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/models/recolections.dart';

class DBHelper {
  Database _db;

  //inicializacion de la base de datos
  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "orders.db");

    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  //la creamos
  void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Orders(dateTime TEXT, latLng TEXT, imageLink TEXT, details TEXT, nameGenerator TEXT, phoneGenerator TEXT, id INTEGER, state INTEGER, rate INTEGER, generatorId INTEGER, recolectorId INTEGER,recolectionRate INTEGER, PRIMARY KEY(id))');
    await db.execute(
        'CREATE TABLE Recolections(nameRecolector TEXT, weight TEXT, orderId INTEGER, id INTEGER, nameRecolection TEXT, PRIMARY KEY(id))');
  }

  //comprobamos si exsiste la base de datos
  Future<Database> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  //metodos
  //orders
  Future<int> createOrder(Order order) async {
    var dbReady = await db;
    try {
      return await dbReady.rawInsert(
          "INSERT INTO Orders(dateTime, latLng, imageLink, details, nameGenerator, phoneGenerator, id, state, rate, generatorId, recolectionRate, recolectorId) VALUES ("
          "'${order.dateTime}',"
          "'${order.latLng}',"
          "'${order.imageLink}',"
          "'${order.details}',"
          "'${order.nameGenerator}',"
          "'${order.phoneGenerator}',"
          "'${order.id}',"
          "'${order.state}',"
          "'${order.rate}',"
          "'${order.generatorId}',"
          "'${order.recolectionRate}',"
          "'${order.recolectorId}')");
    } catch (e) {
      print("error:" + e.toString());
      return 0;
    }
  }

  Future<int> deleteOrder(int id) async {
    try {
      var dbReady = await db;
      return await dbReady.rawInsert("DELETE FROM Orders WHERE id = '$id'");
    } catch (e) {
      print("Exception " + e.toString());
      return 0;
    }
  }

  Future<Order> readOrder(String id) async {
    try {
      var dbReady = await db;
      var read =
          await dbReady.rawQuery("SELECT * FROM Orders WHERE id = '$id'");
      Order aux = Order.fromMap(read[0]);
      return aux;
    } catch (e) {
      print("Exception " + e.toString());
      return Order();
    }
  }

  Future<int> updateStatusOrder(int id, int status) async {
    try {
      var dbReady = await db;
      return await dbReady
          .rawUpdate("UPDATE Orders SET state = $status WHERE id = $id");
    } catch (e) {
      print("Exception " + e.toString());
      return 0;
    }
  }

  Future<int> updateReIdOrder(int id, int reId) async {
    try {
      var dbReady = await db;
      return await dbReady
          .rawUpdate("UPDATE Orders SET recolectorId = $reId WHERE id = $id");
    } catch (e) {
      print("Exception " + e.toString());
      return 0;
    }
  }

  Future<int> updateRateOrder(int id, int rate) async {
    try {
      var dbReady = await db;
      return await dbReady
          .rawUpdate("UPDATE Orders SET rate = $rate WHERE id = $id");
    } catch (e) {
      print("Exception " + e.toString());
      return 0;
    }
  }

  Future<List<Order>> readAllOrders() async {
    var dbReady = await db;
    List<Map> list = await dbReady.rawQuery("SELECT * FROM Orders");
    List<Order> orders = List();
    for (int i = 0; i < list.length; i++) {
      orders.add(Order(
          dateTime: list[i]["dateTime"],
          details: list[i]["details"],
          id: list[i]["id"],
          imageLink: list[i]["imageLink"],
          latLng: list[i]["latLng"],
          nameGenerator: list[i]["nameGenerator"],
          phoneGenerator: list[i]["phoneGenerator"],
          rate: list[i]["rate"],
          state: list[i]["state"],
          generatorId: list[i]["generatorId"],
          recolectionRate: list[i]['recolectionRate'],
          recolectorId: list[i]["recolectorId"]));
    }
    return orders;
  }

  Future<int> deleteAllOrders() async {
    var dbReady = await db;
    return await dbReady.rawInsert("DELETE FROM Orders");
  }

  //recolections
  Future<int> createRecolection(Recolection recolection) async {
    var dbReady = await db;
    try {
      return await dbReady.rawInsert(
          "INSERT INTO Recolections(nameRecolector, weight, orderId, id, nameRecolection) VALUES ("
          "'${recolection.nameRecolector}',"
          "'${recolection.weight}',"
          "'${recolection.orderId}',"
          "'${recolection.id}',"
          "'${recolection.nameRecolection}')");
    } catch (e) {
      print("error:" + e.toString());
      return 0;
    }
  }

  Future<int> deleteRecolection(String id) async {
    var dbReady = await db;
    return await dbReady.rawInsert("DELETE FROM Recolections WHERE id = '$id'");
  }

  Future<Recolection> readRecolection(String id) async {
    var dbReady = await db;
    var read =
        await dbReady.rawQuery("SELECT * FROM Recolections WHERE id = '$id'");
    Recolection aux = Recolection.fromMap(read[0]);
    return aux;
  }

  //TODO: test
  Future<List<Recolection>> readRecolectionsOrder(String id) async {
    var dbReady = await db;
    List<Map> list = await dbReady
        .rawQuery("SELECT * FROM Recolections WHERE orderId = '$id'");
    List<Recolection> recolections = List();
    for (int i = 0; i < list.length; i++) {
      recolections.add(Recolection(
          nameRecolection: list[i]['nameRecolection'],
          id: list[i]["id"],
          nameRecolector: list[i]["nameRecolector"],
          orderId: list[i]["orderId"],
          weight: list[i]["weight"]));
    }
    return recolections;
  }

  Future<List<Recolection>> readAllRecolections() async {
    var dbReady = await db;
    List<Map> list = await dbReady.rawQuery("SELECT * FROM Recolections");
    List<Recolection> recolections = List();
    for (int i = 0; i < list.length; i++) {
      recolections.add(Recolection(
          nameRecolection: list[i]['nameRecolection'],
          id: list[i]["id"],
          nameRecolector: list[i]["nameRecolector"],
          orderId: list[i]["orderId"],
          weight: list[i]["weight"]));
    }
    return recolections;
  }

  Future<int> deleteAllRecolections() async {
    var dbReady = await db;
    return await dbReady.rawInsert("DELETE FROM Recolections");
  }

  Future<void> cleanDB() async {
    await deleteAllOrders();
    await deleteAllRecolections();
  }
}
