import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/login_providers.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/login_logic.dart' as logic;
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart'
    as configure;
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart' as buttons;
import 'package:waste_collection_app/utils/request.dart' as request;

final GlobalKey<ScaffoldState> scaffoldLoginKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _logo() {
    return Container(
        width: double.infinity,
        height: 120.0,
        child: SvgPicture.asset('assets/arrows.svg'));
  }

  @override
  void initState() {
    super.initState();
    logic.initDataBase(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => (context));
    //    logic.chargePreferences(context));
  }

  @override
  Widget build(BuildContext context) {
    final controllers = Provider.of<ControllersProvider>(context);
    return Stack(children: [
      GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          key: scaffoldLoginKey,
          body: SafeArea(
            child: Container(
              height: double.infinity,
              padding:
                  const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56.0),
                      child: _logo()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: _InputEntries()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: _LoginButtons()),
                ],
              ),
            ),
          ),
        ),
      ),
      controllers.isLoading ? configure.LoadingWidget() : Container()
    ]);
  }
}

class _InputEntries extends StatefulWidget {
  static List<FocusNode> _focus = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  __InputEntriesState createState() => __InputEntriesState();
}

class __InputEntriesState extends State<_InputEntries> {
  bool visible;
  @override
  void initState() {
    super.initState();
    visible = true;
  }

  @override
  Widget build(BuildContext context) {
    final loginData = Provider.of<LoginProviders>(context);
    return Form(
      key: formLoginKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: loginData.username,
            onFieldSubmitted: (value) => logic.fieldFocusChange(
                _InputEntries._focus[0], _InputEntries._focus[1], context),
            focusNode: _InputEntries._focus[0],
            textInputAction: TextInputAction.next,
            validator: (value) => logic.validate(value, "usuario"),
            onChanged: (value) => loginData.username = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Usuario o Email",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            initialValue: loginData.password,
            onFieldSubmitted: (value) {
              _InputEntries._focus[1].unfocus();
              logic.validateAll();
            },
            focusNode: _InputEntries._focus[1],
            obscureText: visible,
            textInputAction: TextInputAction.done,
            validator: (value) => logic.validate(value, "contraseña"),
            onChanged: (value) => loginData.password = value,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => visible = !visible),
              ),
              prefixIcon: Icon(Icons.vpn_key),
              labelText: "Contraseña",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Recuerdame',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.grey[600])),
              SizedBox(width: 8.0),
              Checkbox(
                  value: loginData.rememberMe,
                  onChanged: (value) => loginData.rememberMe = value)
            ],
          )
        ],
      ),
    );
  }
}

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProviders>(context);
    final controller = Provider.of<ControllersProvider>(context);
    final user = Provider.of<UserProviders>(context);
    return Column(
      children: <Widget>[
        buttons.BoxButton(
            function: () async {
              if (logic.validateAll()) {
                controller.isLoading = true;
                if (await request.login(
                    email: login.username,
                    password: login.password,
                    context: context)) {
                  if (await request.getSolids(context: context)) {
                    if (!user.userType) {
                      await request.searchOrders(context: context);
                    }
                    controller.isLoading = false;
                    Navigator.pushReplacementNamed(context, 'home');
                    logic.savePreferences(context);
                  }
                }
                controller.isLoading = false;
              }
            },
            title: 'Iniciar Sesión',
            color: Theme.of(context).primaryColor),
        SizedBox(height: 8.0),
        buttons.BoxButton(
            function: () => Navigator.pushNamed(context, 'register'),
            title: 'Registrarse'),
      ],
    );
  }
}
