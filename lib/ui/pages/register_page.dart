import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/models/user.dart';
import 'package:waste_collection_app/ui/pages/register_form_page.dart';
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart' as buttons;
import 'package:waste_collection_app/data/constant.dart' as constant;

class RegisterPage extends StatelessWidget {
  Widget _texts() {
    final keys = constant.registerTexts.keys.toList();
    final values = constant.registerTexts.values.toList();
    return Column(children: [
      for (int i = 0; i < keys.length; i++)
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                i % 2 != 0
                    ? SvgPicture.asset(constant.svgPageRegister[i],
                        height: 100.0)
                    : Container(),
                Expanded(
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: keys[i],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0)),
                      TextSpan(
                          text: values[i],
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                    ]),
                  ),
                ),
                i % 2 == 0
                    ? SvgPicture.asset(constant.svgPageRegister[i],
                        height: 100.0)
                    : Container()
              ],
            )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        title: Text('Registrarse',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _texts(),
            _RegisterButtons(),
          ],
        ),
      ),
    );
  }
}

class _RegisterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProviders>(context);
    return Column(
      children: <Widget>[
        buttons.BoxButton(
            function: () {
              userProvider.user = User();
              userProvider.generatorUser = GeneratorUser();
              Navigator.pushNamed(context, 'register_form',
                  arguments: RegisterFormArguments());
            },
            title: 'RECOLECTOR',
            color: Theme.of(context).primaryColor),
        SizedBox(height: 8.0),
        buttons.BoxButton(
            function: () {
              userProvider.user = User();
              userProvider.generatorUser = GeneratorUser();
              Navigator.pushNamed(context, 'register_form',
                  arguments: RegisterFormArguments(generator: true));
            },
            title: 'GENERADOR',
            color: Theme.of(context).primaryColor),
      ],
    );
  }
}
