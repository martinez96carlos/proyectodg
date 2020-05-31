import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/database/dbHelper.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/orders_logic.dart';
import 'package:waste_collection_app/ui/pages/charts_page.dart';
import 'package:waste_collection_app/ui/pages/guide.dart';
import 'package:waste_collection_app/ui/pages/login_page.dart';
import 'package:waste_collection_app/ui/pages/orders_page.dart';
import 'package:waste_collection_app/ui/pages/profile_page.dart';
import 'package:waste_collection_app/ui/pages/register_form_page.dart';
import 'package:waste_collection_app/ui/pages/search_page.dart';
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart'
    as configure;
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart' as buttons;

final GlobalKey<ScaffoldState> scaffoldHomeKey = new GlobalKey<ScaffoldState>();

class Home extends StatelessWidget {
  final List<Widget> pagesRecolector = [
    ProfilePage(),
    SearchPage(),
    OrdersPage(),
    ChartsPage(),
  ];

  final List<Widget> pagesGenerator = [
    ProfilePage(),
    OrdersPage(),
    Guide(),
  ];

  Widget _drawer(BuildContext context, bool generator) {
    final controllers =
        Provider.of<ControllersProvider>(context, listen: false);
    final items =
        generator ? constant.menuItemsGenerator : constant.menuItemsRecolector;
    final icons = items.values.toList();
    final titles = items.keys.toList();
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
              child: Center(
                  child: SvgPicture.asset(
                'assets/arrows.svg',
                height: 100.0,
              )),
              padding: EdgeInsets.zero),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(generator ? 'Generator' : 'Recolector',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w300))),
          Divider(),
          for (int i = 0; i < items.length; i++)
            ListTile(
                onTap: () {
                  controllers.pickerMenu = i;
                  Navigator.pop(context);
                },
                leading: Icon(icons[i]),
                title: Text(
                  titles[i],
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: controllers.pickerMenu == i
                          ? Colors.blue
                          : Colors.black),
                )),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: buttons.BoxButton(
                title: 'CERRAR SESIÓN',
                function: () {
                  controllers.pickerMenu = 1;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                color: Colors.red),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    final items = user.userType
        ? constant.menuItemsGenerator
        : constant.menuItemsRecolector;
    final titles = items.keys.toList();
    return Stack(children: [
      Scaffold(
        key: scaffoldHomeKey,
        drawer: _drawer(context, user.userType),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            controllers.pickerMenu == 0
                ? IconButton(
                    icon:
                        Icon(Icons.edit, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register_form',
                          arguments: RegisterFormArguments(edit: true));
                    },
                  )
                : Container(),
            user.userType && controllers.pickerMenu == 1
                ? IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      controllers.isLoading = true;
                      await getOrdersGenerator(
                          context, user.user.id.toString());
                      controllers.isLoading = false;
                    },
                  )
                : Container(),
            !user.userType && controllers.pickerMenu == 2
                ? IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      controllers.isLoading = true;
                      await getOrdersRecolector(
                          context, user.user.id.toString());
                      controllers.isLoading = false;
                    },
                  )
                : Container(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                var dbHelper = DBHelper();
                controllers.isLoading = true;
                await dbHelper.cleanDB();
                controllers.isLoading = false;
              },
            )
          ],
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldHomeKey.currentState.openDrawer()),
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          elevation: 0.0,
          title: Text(titles[controllers.pickerMenu],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
          backgroundColor: Colors.white,
        ),
        body: user.userType
            ? pagesGenerator[controllers.pickerMenu]
            : pagesRecolector[controllers.pickerMenu],
      ),
      controllers.isLoading ? configure.LoadingWidget() : Container()
    ]);
  }
}
