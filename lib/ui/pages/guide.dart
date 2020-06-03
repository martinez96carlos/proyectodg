import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/providers/user_providers.dart';

class Guide extends StatelessWidget {
  Widget photography(String asset) => Container(
      margin: EdgeInsets.all(32.0),
      height: 150.0,
      width: double.infinity,
      child: SvgPicture.asset(asset));

  Widget _text(BuildContext context, int pointer) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
      child: Text(
        constant.textsGuide[pointer],
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.grey[600]),
      ));

  Widget _title(BuildContext context) {
    final user = Provider.of<UserProviders>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _subtitle(context, 'Cómo separar tus residuos \nsolidos'),
          SizedBox(height: 8.0),
          Text('¡Hola ${user.user.name}!',
              style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 4.0),
          Text(
              'Ahora que elegiste separar los residuos en la casa, aquí te traemos una guía de cómo debes separar los mismos.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey[600]))
        ],
      ),
    );
  }

  Widget _subtitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget _table(Map<String, List<String>> mapa, BuildContext context,double height) {
    List<String> valuesSi = mapa['si'];
    List<String> valuesNo = mapa['no'];

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:
                      Text('Si', style: Theme.of(context).textTheme.subtitle2),
                ),
                Divider(height: 0.0, color: Colors.grey, thickness: 1.0),
                SizedBox(height: 8.0),
                for (int i = 0; i < valuesSi.length; i++)
                  Row(
                    children: <Widget>[
                      Icon(Icons.check, color: Colors.green),
                      SizedBox(width: 8.0),
                      Flexible(
                          child: Text(valuesSi[i],
                              style: Theme.of(context).textTheme.caption))
                    ],
                  ),
              ],
            ),
          )),
          Expanded(
              child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:
                      Text('No', style: Theme.of(context).textTheme.subtitle2),
                ),
                Divider(height: 0.0, color: Colors.grey, thickness: 1.0),
                SizedBox(height: 8.0),
                for (int i = 0; i < valuesNo.length; i++)
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.close, color: Colors.red),
                      SizedBox(width: 8.0),
                      Flexible(
                          child: Text(valuesNo[i],
                              style: Theme.of(context).textTheme.caption))
                    ],
                  )
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _title(context),
            photography("assets/ecology.svg"),
            _text(context, 0),
            _text(context, 1),
            Divider(),
            _subtitle(context, 'Papel y carton'),
            photography("assets/paper.svg"),
            _table(constant.paper, context,250.0),
            SizedBox(height: 16.0),
            Divider(),
            _subtitle(context, 'Plasticos'),
            photography("assets/plastic.svg"),
            _table(constant.plastic, context,180),
            SizedBox(height: 16.0),
            Divider(),
            _subtitle(context, 'Vidrios'),
            photography("assets/vodka.svg"),
            _table(constant.vidrios, context,100),
            SizedBox(height: 16.0),
            Divider(),
            _subtitle(context, 'Metales'),
            photography("assets/frying-pan.svg"),
            _table(constant.metales, context,120),
            SizedBox(height: 16.0),
            Divider(),
            _subtitle(context, 'Otros'),
            photography("assets/clothes.svg"),
            _table(constant.otros, context,170),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
