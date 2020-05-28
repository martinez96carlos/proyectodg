import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/orders_logic.dart' as orderL;
import 'package:waste_collection_app/models/orders.dart';
import 'package:waste_collection_app/utils/request.dart' as request;

class CardOrder extends StatelessWidget {
  final Order order;
  final bool search;
  final BuildContext mainContext;
  CardOrder({this.order, this.search = false, @required this.mainContext});
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    final user = Provider.of<UserProviders>(context);
    return InkWell(
      onTap: () async {
        if (user.userType) {
          controllers.isLoading = true;
          if (await request.getRecolections(
              id: order.id.toString(), context: context)) {
            controllers.isLoading = false;
            orderProvider.orderActive = order;
            Navigator.pushNamed(mainContext, 'order_details');
          }
        } else {
          if (!search) {
            controllers.isLoading = true;
            if (await request.getRecolections(
                id: order.id.toString(), context: context)) {
              orderProvider.orderActive = order;
              print('entro');
              controllers.isLoading = false;
              Navigator.pushNamed(context, 'order_details');
            }
          } else {
            orderProvider.orderActive = order;
            Navigator.pushNamed(context, 'order_details');
          }
        }
      },
      child: Container(
          key: Key(order.id.toString()),
          height: 100.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage(orderL.pickImage(order.details.toLowerCase())),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                          child: Text(
                            order.details,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(orderL.dateText(order.dateTime),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
