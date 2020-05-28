import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/ui/widgets/custom_cards.dart' as cards;
import 'package:waste_collection_app/utils/request.dart' as request;

class SearchPage extends StatelessWidget {
  Widget _search(BuildContext context) {
    final controllers = Provider.of<ControllersProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: "",
        textInputAction: TextInputAction.search,
        onChanged: (value) => controllers.valueSearch = value,
        onFieldSubmitted: (value) async {
          FocusScope.of(context).requestFocus(FocusNode());
          controllers.isSearchOrders = true;
          await request.searchOrders(context: context);
          controllers.isSearchOrders = false;
        },
        decoration: InputDecoration(
          hintText: 'Busca una orden',
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controllers.isSearchOrders = true;
                  await request.searchOrders(context: context);
                  controllers.isSearchOrders = false;
                },
                child: Icon(Icons.search)),
          ),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            _search(context),
            Expanded(
                child: controllers.isSearchOrders
                    ? Center(child: CircularProgressIndicator())
                    : ordersProvider.searchOrders.length != 0
                        ? ListView(
                            children: ordersProvider.searchOrders
                                .where((order) => order.details
                                    .contains(controllers.valueSearch))
                                .map((order) => cards.CardOrder(
                                    order: order,
                                    search: true,
                                    mainContext: context))
                                .toList(),
                          )
                        : Center(
                            child: Text('No hay ordenes recientes',
                                style: Theme.of(context).textTheme.headline6)))
          ],
        ),
      ),
    );
  }
}
