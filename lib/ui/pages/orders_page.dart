import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/ui/widgets/alerts.dart' as alerts;
import 'package:waste_collection_app/ui/widgets/custom_cards.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProviders = Provider.of<UserProviders>(context);
    final order = Provider.of<OrdersProviders>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: <Widget>[
          _Body(),
          userProviders.userType
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton(
                        onPressed: () {
                          order.orderActive = Order();
                          Navigator.pushNamed(context, 'order_form');
                        },
                        child: Icon(Icons.add)),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  Widget _cancelOrderText(Alignment alignment) => Container(
        padding: EdgeInsets.all(8.0),
        child: Align(
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.cancel, color: Colors.white),
                Text('Cancelar Pedido', style: TextStyle(color: Colors.white))
              ],
            )),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.symmetric(vertical: 8.0),
      );

  Widget _updateOrderRate(Alignment alignment) => Container(
        padding: EdgeInsets.all(8.0),
        child: Align(
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star, color: Colors.white),
                Text('Calificación', style: TextStyle(color: Colors.white))
              ],
            )),
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.symmetric(vertical: 8.0),
      );

  @override
  Widget build(BuildContext context) {
    final userProviders = Provider.of<UserProviders>(context);
    final orderProviders = Provider.of<OrdersProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    return !controllers.isLoadingDB
        ? orderProviders.orders.length == 0
            ? Center(
                child: Text('No hay ordenes recientes',
                    style: Theme.of(context).textTheme.headline6))
            : ListView.builder(
                itemCount: orderProviders.orders.length,
                itemBuilder: (context, pointer) {
                  if (userProviders.userType &&
                      userProviders.user.id ==
                          orderProviders.orders[pointer].generatorId &&
                      orderProviders.orders[pointer].state != 3) {
                    return Dismissible(
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await alerts.cancelOrderAlert(direction,
                              context, orderProviders.orders[pointer].id);
                        } else {
                          orderProviders.orderActive =
                              orderProviders.orders[pointer];
                          print(orderProviders.orderActive.state);
                          return await alerts.updateRateAlert(direction,
                              context, orderProviders.orders[pointer].id);
                        }
                      },
                      secondaryBackground:
                          _cancelOrderText(Alignment.centerRight),
                      background: _updateOrderRate(Alignment.centerLeft),
                      key: UniqueKey(),
                      child: CardOrder(
                          order: orderProviders.orders[pointer],
                          mainContext: context),
                    );
                  } else if (orderProviders.orders[pointer].state != 3 &&
                      orderProviders.orders[pointer].recolectorId ==
                          userProviders.user.id) {
                    return CardOrder(
                        order: orderProviders.orders[pointer],
                        mainContext: context);
                  } else {
                    return Container();
                  }
                },
              )
        : Center(child: CircularProgressIndicator());
  }
}
