import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;

class Guide extends StatelessWidget {
  Widget photography() => Container(
      margin: EdgeInsets.all(32.0),
      height: 200.0,
      width: double.infinity,
      child: SvgPicture.asset("assets/ecology.svg", height: 100.0));

  Widget _text(BuildContext context, int pointer) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Text(
        constant.textsGuide[pointer],
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Colors.grey[600]),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            photography(),
            _text(context, 0),
            _text(context, 1),
            photography(),
            _text(context, 2),
          ],
        ),
      ),
    );
  }
}
