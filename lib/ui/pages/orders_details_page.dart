import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/database/dbHelper.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/recolections_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/orders_logic.dart' as orderL;
import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/models/recolections.dart';
import 'package:waste_collection_app/ui/widgets/alerts.dart' as alerts;
import 'package:waste_collection_app/ui/widgets/bottomSheets.dart'
    as bottomSheet;
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart'
    as configure;
import 'package:waste_collection_app/ui/widgets/maps_widget.dart' as maps;
import 'package:waste_collection_app/utils/request.dart' as request;

GlobalKey<ScaffoldState> orderDetatilsScaffoldKey = GlobalKey<ScaffoldState>();

class OrdersDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllers = Provider.of<ControllersProvider>(context);
    final order = Provider.of<OrdersProviders>(context);
    final user = Provider.of<UserProviders>(context);
    return WillPopScope(
      onWillPop: () async {
        if (!user.userType && order.orderActive.state == 1) {
          return alerts.generalAlert(
              context: context,
              function: () async {
                controllers.isLoading = true;
                var db = DBHelper();
                if (await request.cancelPick(
                    context: context,
                    recolectorId: user.user.id,
                    orderId: order.orderActive.id)) {
                  order.deleteOrder(order.orderActive.id);
                  order.changeStatus(0);
                  order.addSearch(order.orderActive);
                  await db.deleteOrder(order.orderActive.id);
                }
                controllers.isLoading = false;
              },
              description: '¿Esta seguro que desea cancelar el pedido?');
        } else {
          Navigator.of(context).pop(true);
          return true;
        }
      },
      child: Stack(children: [
        Scaffold(
          key: orderDetatilsScaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading:
                !user.userType && order.orderActive.state == 1 ? false : true,
            iconTheme: IconThemeData(color: Colors.black),
            brightness: Brightness.light,
            elevation: 0.0,
            title: Text("Detalle de pedido",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300)),
            backgroundColor: Colors.white,
          ),
          body: _Body(),
        ),
        controllers.isLoading ? configure.LoadingWidget() : Container()
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  final db = DBHelper();

  Widget buttonBottom(
      {String text,
      Function function,
      Color color,
      IconData icon,
      BuildContext context}) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsetsDirectional.only(top: 8.0),
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1.0, blurRadius: 10.0)
            ],
            color:
                color != null ? Colors.white : Theme.of(context).primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color != null ? color : Colors.white),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: color != null ? color : Colors.white))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrdersProviders>(context);
    final user = Provider.of<UserProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    final recolections = Provider.of<RecolectionsProvider>(context);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: _GeneralInformation(order: order.orderActive)),
            !user.userType && order.orderActive.state != 2
                ? order.orderActive.state == 1
                    ? Row(children: <Widget>[
                        Expanded(
                          child: buttonBottom(
                              context: context,
                              color: Colors.red,
                              text: 'Cancelar',
                              icon: Icons.cancel,
                              function: () => alerts.generalAlert(
                                  context: context,
                                  function: () async {
                                    controllers.isLoading = true;

                                    if (await request.cancelPick(
                                        context: context,
                                        recolectorId: user.user.id,
                                        orderId: order.orderActive.id)) {
                                      order.deleteOrder(order.orderActive.id);
                                      order.changeStatus(0);
                                      order.addSearch(order.orderActive);
                                      await db
                                          .deleteOrder(order.orderActive.id);
                                    }
                                    controllers.isLoading = false;
                                    Navigator.pop(context);
                                  },
                                  description:
                                      '¿Esta seguro que desea cancelar el pedido?')),
                        ),
                        Expanded(
                          child: buttonBottom(
                              context: context,
                              function: () => alerts.generalAlert(
                                  context: context,
                                  function: () async {
                                    //List jsonList = Recolection.encondeToJson(
                                    //  recolections.recolections);
                                    final jsonList = jsonEncode(recolections
                                        .recolections
                                        .map((e) => e.toJson())
                                        .toList());
                                    if (await request.sendRecolections(
                                        id: order.orderActive.id.toString(),
                                        recolections: jsonList.toString(),
                                        orderRate: order.orderActive.rate,
                                        context: context)) {
                                      await db.updateStatusOrder(
                                          order.orderActive.id, 2);
                                      order.changeRate(order.orderActive.rate,
                                          order.orderActive.id, 2);
                                      await db.updateRateOrder(
                                          order.orderActive.id,
                                          order.orderActive.rate);
                                      Navigator.pop(context);
                                    }
                                  },
                                  description:
                                      '¿Desea finalizar la recolección?'),
                              icon: Icons.send,
                              text: 'Finalizar'),
                        )
                      ])
                    : buttonBottom(
                        context: context,
                        icon: MdiIcons.cartPlus,
                        text: 'Recolectar',
                        function: () async {
                          controllers.isLoading = true;
                          var db = DBHelper();
                          if (await request.orderPick(
                              context: context,
                              recolectorId: user.user.id,
                              orderId: order.orderActive.id)) {
                            order.changeStatus(1);
                            order.changeRecolectorId(user.user.id);
                            order.addOrder(order.orderActive);
                            order.deleteSearchOrder(order.orderActive.id);
                            if (await db.createOrder(order.orderActive) == 0) {
                              await db.updateStatusOrder(
                                  order.orderActive.id, 1);
                              await db.updateReIdOrder(order.orderActive.id, 0);
                            }
                          }
                          controllers.isLoading = false;
                        })
                : Container(),
          ],
        ),
        Positioned(
          bottom: 70.0,
          right: 10.0,
          child: !user.userType && order.orderActive.state == 1
              ? FloatingActionButton(
                  onPressed: () {
                    recolections.recolectionActive = Recolection();
                    orderDetatilsScaffoldKey.currentState.showBottomSheet(
                        (context) => bottomSheet.BottomSheetRecolection());
                  },
                  child: Icon(Icons.add),
                )
              : Container(),
        )
      ],
    );
  }
}

class _GeneralInformation extends StatelessWidget {
  final Order order;
  _GeneralInformation({this.order});

  Widget titles(String title, BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w300),
        ),
      );

  Widget dateTime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(MdiIcons.calendarMonth, size: 28.0),
          SizedBox(width: 8.0),
          Text(orderL.dateText(order.dateTime),
              style: Theme.of(context).textTheme.subtitle1),
          Expanded(child: SizedBox()),
          Icon(Icons.timer),
          SizedBox(width: 8.0),
          Text(order.dateTime.split(" ")[1],
              style: Theme.of(context).textTheme.subtitle1),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget photography(BuildContext context) => Container(
      height: 200.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: order.imageLink != ""
          ? Image.network(order.imageLink)
          : Center(
              child: Text('No hay imagen\ndisponible',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.grey[600])),
            ));

  Widget rate(BuildContext context) {
    final orderProvider = Provider.of<OrdersProviders>(context);
    final user = Provider.of<UserProviders>(context);
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: titles('Calidad de la separación', context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < orderProvider.orderActive.rate ~/ 1; i++)
              InkWell(
                  onTap: () {
                    if (!user.userType && order.state == 1)
                      orderProvider.changeRateOrderActive(i + 1);
                  },
                  child:
                      Icon(Icons.star, color: Theme.of(context).primaryColor)),
            (orderProvider.orderActive.rate -
                        orderProvider.orderActive.rate ~/ 1) ==
                    0
                ? Container()
                : Icon(Icons.star_half, color: Theme.of(context).primaryColor),
            if (orderProvider.orderActive.rate != 5.0)
              for (int i = 1;
                  i <= 5 - (orderProvider.orderActive.rate % 5);
                  i++)
                InkWell(
                    onTap: () {
                      if (!user.userType && order.state == 1)
                        orderProvider.changeRateOrderActive(
                            i + orderProvider.orderActive.rate);
                    },
                    child: Icon(Icons.star_border,
                        color: Theme.of(context).primaryColor))
          ],
        )
      ],
    );
  }

  Widget recolectionRate(BuildContext context) {
    final orderProvider = Provider.of<OrdersProviders>(context);
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: titles('Calidad de la recolección', context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0;
                i < orderProvider.orderActive.recolectionRate ~/ 1;
                i++)
              Icon(Icons.star, color: Theme.of(context).primaryColor),
            if (orderProvider.orderActive.recolectionRate != 5.0)
              for (int i = 1;
                  i <= 5 - (orderProvider.orderActive.recolectionRate % 5);
                  i++)
                Icon(Icons.star_border, color: Theme.of(context).primaryColor)
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProviders>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titles("Fecha y Hora", context),
          dateTime(context),
          SizedBox(height: 16.0),
          titles('Ubicación', context),
          maps.MapContainer(position: order.latLng),
          SizedBox(height: 16.0),
          titles('Fotografía de residuos', context),
          photography(context),
          order.state != 0 ? rate(context) : Container(),
          _RecolectionsList(
              state: !userProvider.userType && order.state == 1 ? true : false),
          titles('Generador', context),
          Text(
              userProvider.userType
                  ? userProvider.user.name
                  : order.nameGenerator,
              style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 4.0),
          Row(children: <Widget>[
            Icon(Icons.call, size: 24.0),
            SizedBox(width: 8.0),
            Text(
                userProvider.userType
                    ? userProvider.user.phone
                    : order.phoneGenerator,
                style: Theme.of(context).textTheme.subtitle1),
          ]),
          SizedBox(height: 16.0),
          titles('Especificaciones', context),
          Text(order.details,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
          SizedBox(height: 16.0),
          order.recolectionRate != 0 ? recolectionRate(context) : Container(),
          order.recolectionRate != 0 ? SizedBox(height: 16.0) : Container(),
        ],
      )),
    );
  }
}

class _RecolectionsList extends StatelessWidget {
  final bool state;
  _RecolectionsList({this.state});

  Widget titles(String title, BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w300),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final recolections = Provider.of<RecolectionsProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          titles('Residuos recolectados', context),
          if (recolections.recolections.length == 0)
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 100.0,
                  child: Center(
                      child: Text(
                    'No hay residuos recolectados',
                    style: TextStyle(color: Colors.grey[600]),
                  ))),
            ),
          for (int i = 0; i < recolections.recolections.length; i++)
            ListTile(
                title: Text("${recolections.recolections[i].nameRecolection}"),
                subtitle:
                    Text("Peso: ${recolections.recolections[i].weight} Kg."),
                trailing: state
                    ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => recolections.deleteRecolection(i),
                      )
                    : Text("")),
          Divider()
        ],
      ),
    );
  }
}
