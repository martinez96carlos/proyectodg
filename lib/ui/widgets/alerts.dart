import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/database/dbHelper.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/orders_logic.dart' as logic;
import 'package:waste_collection_app/ui/pages/order_form_page.dart';
import 'package:waste_collection_app/utils/request.dart' as request;

Future<void> exitAlert(BuildContext context) async {
  await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Salir'),
          content: Text('¿Esta seguro que desea salir?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('Si'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      });
}

Future<bool> cancelOrderAlert(
    DismissDirection direction, BuildContext context, int id) async {
  final controllers = Provider.of<ControllersProvider>(context, listen: false);
  final orders = Provider.of<OrdersProviders>(context, listen: false);
  var db = DBHelper();
  return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('¡Cuidado!'),
          content: Text("¿Esta seguro que desea cancelar el pedido?"),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: TextStyle(color: Colors.black),
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text("Si"),
              onPressed: () async {
                Navigator.of(context).pop(true);
                controllers.isLoading = true;
                if (await request.deleteOrder(
                    id: id.toString(), context: context)) {
                  if (await db.deleteOrder(id) != 0) {
                    orders.deleteOrder(id);
                  }
                }
                controllers.isLoading = false;
              },
            )
          ],
        ),
      ) ??
      false;
}

Future<bool> createOrderAlert(BuildContext context) async {
  final controller = Provider.of<ControllersProvider>(context, listen: false);
  final user = Provider.of<UserProviders>(context, listen: false);
  final orderProvider = Provider.of<OrdersProviders>(context, listen: false);
  var dbHelper = DBHelper();
  return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Mensaje'),
          content: Text("¿Esta seguro que desea crear este pedido?"),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: TextStyle(color: Colors.black),
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text("Si"),
              onPressed: () async {
                controller.stillCreateOrder = true;
                if (logic.validateOrder(context)) {
                  Navigator.of(context).pop(true);
                  controller.isLoading = true;
                  if (await request.addOrder(
                      idGenerator: user.user.id, context: context)) {
                    print('entra a crear en la base de datos');
                    await dbHelper.createOrder(orderProvider.orderActive);
                  }
                  controller.isLoading = false;
                  controller.stillCreateOrder = false;
                } else {
                  scaffoldOrderFormPage.currentState.showSnackBar(SnackBar(
                    content: Text('Por favor, llene los campos requeridos'),
                  ));
                  Navigator.of(context).pop(false);
                  controller.stillCreateOrder = false;
                }
              },
            )
          ],
        ),
      ) ??
      false;
}

Future<bool> generalAlert(
    {BuildContext context, Function function, String description}) async {
  return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Mensaje'),
          content: Text(description),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: TextStyle(color: Colors.black),
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text("Si"),
              onPressed: () {
                function();
                Navigator.of(context).pop(true);
              },
            )
          ],
        ),
      ) ??
      false;
}
