import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/orders_logic.dart' as orderL;
import 'package:waste_collection_app/ui/widgets/alerts.dart' as alerts;
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart'
    as configure;
import 'package:waste_collection_app/ui/widgets/maps_widget.dart' as maps;
import 'package:waste_collection_app/utils/firebase.dart' as firebase;

GlobalKey<ScaffoldState> scaffoldOrderFormPage = GlobalKey<ScaffoldState>();

class OrdersFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllers = Provider.of<ControllersProvider>(context);
    return Stack(children: [
      GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          key: scaffoldOrderFormPage,
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            brightness: Brightness.light,
            elevation: 0.0,
            title: Text("Formulario de Solicitud",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300)),
            backgroundColor: Colors.white,
          ),
          body: _Body(),
        ),
      ),
      controllers.isLoading ? configure.LoadingWidget() : Container()
    ]);
  }
}

class _Body extends StatelessWidget {
  void timer(BuildContext context) {
    final controllers =
        Provider.of<ControllersProvider>(context, listen: false);
    Timer(Duration(seconds: 1), () {
      if (!controllers.stillCreateOrder) {
        Navigator.of(context).pop();
      } else {
        timer(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controllers = Provider.of<ControllersProvider>(context);
    return Column(
      children: <Widget>[
        Expanded(child: _GeneralInformation()),
        InkWell(
          onTap: () async {
            if (await alerts.createOrderAlert(context)) {
              print("ingresa al timer con valor :" +
                  controllers.stillCreateOrder.toString());
              timer(context);
            }
          },
          child: Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(MdiIcons.contentSave, color: Colors.white),
                Text("Realizar Pedido",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _GeneralInformation extends StatelessWidget {
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
    final order = Provider.of<OrdersProviders>(context);
    return InkWell(
      onTap: () => orderL.addDateTimeToRegisterOrder(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(MdiIcons.calendarMonth, size: 28.0),
            SizedBox(width: 8.0),
            Text(
                order.orderActive.dateTime != ""
                    ? orderL.dateText(order.orderActive.dateTime)
                    : "- / - / - /",
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(child: SizedBox()),
            Icon(Icons.timer),
            SizedBox(width: 8.0),
            Text(
                order.orderActive.dateTime != ""
                    ? order.orderActive.dateTime.split(" ")[1]
                    : " - : - ",
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget photography(BuildContext context) {
    final order = Provider.of<OrdersProviders>(context);
    return Container(
        height: 200.0,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: order.orderActive.imageLink != ""
            ? Image.network(order.orderActive.imageLink)
            : Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      String photo =
                          await firebase.uploadPhoto('orders', context, true);
                      order.changeImageLink(photo);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.camera_alt),
                        SizedBox(height: 4.0),
                        Text('Tomar fotografía',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.grey[600]))
                      ],
                    ),
                  )),
                  VerticalDivider(),
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      String photo =
                          await firebase.uploadPhoto('orders', context, false);
                      order.changeImageLink(photo);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.file_upload),
                        SizedBox(height: 4.0),
                        Text('Subir fotografía',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.grey[600]))
                      ],
                    ),
                  ))
                ],
              ));
  }

  Widget detailsInput(BuildContext context) {
    final order = Provider.of<OrdersProviders>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Escribe los detalles del pedido...'),
        expands: false,
        maxLines: 9,
        onChanged: (value) => order.orderActive.details = value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProviders>(context);
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
          maps.MapFormSelected(),
          SizedBox(height: 16.0),
          titles('Fotografía de residuos', context),
          photography(context),
          SizedBox(height: 16.0),
          titles('Generador', context),
          Text(user.user.name, style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 4.0),
          Row(children: <Widget>[
            Icon(Icons.call, size: 24.0),
            SizedBox(width: 8.0),
            Text(user.user.phone, style: Theme.of(context).textTheme.subtitle1),
          ]),
          SizedBox(height: 16.0),
          titles('Especificaciones', context),
          detailsInput(context),
          SizedBox(height: 16.0),
        ],
      )),
    );
  }
}
