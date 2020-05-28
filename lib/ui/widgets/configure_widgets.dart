import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(color: Colors.black38),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator()),
                  SizedBox(height: 16.0),
                  Text('Cargando...'),
                ],
              ),
            ),
          )),
    );
  }
}
