import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function function;
  BoxButton({this.color, @required this.title, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: color == null ? Colors.white : color,
            border: Border.all(
                color: color == null ? Theme.of(context).primaryColor : color)),
        child: Center(
          child: Text(title,
              style: Theme.of(context).textTheme.button.copyWith(
                  color: color == null
                      ? Theme.of(context).primaryColor
                      : Colors.white)),
        ),
      ),
    );
  }
}

class GeneralButtonMap extends StatelessWidget {
  final Widget contain;
  final Function function;
  final double height;

  GeneralButtonMap({this.contain, this.function, this.height});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 0.5,
                    offset: Offset(1.0, 1.0))
              ]),
          child: contain),
      onTap: () {
        function();
      },
    );
  }
}