import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/recolections_provider.dart';
import 'package:waste_collection_app/logic/login_logic.dart' as loginL;
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart';

class BottomSheetRecolection extends StatefulWidget {
  @override
  _BottomSheetRecolectionState createState() => _BottomSheetRecolectionState();
}

class _BottomSheetRecolectionState extends State<BottomSheetRecolection> {
  TextEditingController _weight = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProviders>(context);
    final recolectionsProvider = Provider.of<RecolectionsProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16.0)),
      width: double.infinity,
      margin: EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0))),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Registrar",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context)),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Seleccionar pedido',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButtonFormField(
                value: null,
                items: orderProvider.solids
                    .map((value) => DropdownMenuItem(
                        child: Text(value.name), value: value.id))
                    .toList(),
                onChanged: (value) {
                  recolectionsProvider.recolectionActive.nameRecolection =
                      orderProvider
                          .solids[orderProvider.obtainsNameSolid(value)].name;
                  recolectionsProvider.recolectionActive.idSolid = value;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.delete),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Peso (Kg)',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                initialValue: _weight.text,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) => loginL.validate(value, "peso"),
                onChanged: (value) {
                  setState(() {
                    _weight.text = value;
                    recolectionsProvider.recolectionActive.weight =
                        double.parse(value);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(MdiIcons.weight),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: 150.0,
                  child: BoxButton(
                    title: 'Registrar',
                    function: () {
                      if (recolectionsProvider.recolectionActive.weight !=
                              0.0 &&
                          recolectionsProvider
                                  .recolectionActive.nameRecolection !=
                              "") {
                        recolectionsProvider.recolectionActive.orderId =
                            orderProvider.orderActive.id;
                        recolectionsProvider.addRecolection(
                            recolectionsProvider.recolectionActive);
                        recolectionsProvider.recolections[
                                recolectionsProvider.recolections.length - 1]
                            .mostrar();
                        Navigator.pop(context);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }
}
