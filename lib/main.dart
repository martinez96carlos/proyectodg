import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/charts_provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/login_providers.dart';
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/ui/pages/home_page.dart';
import 'package:waste_collection_app/ui/pages/login_page.dart';
import 'package:waste_collection_app/ui/pages/order_form_page.dart';
import 'package:waste_collection_app/ui/pages/orders_details_page.dart';
import 'package:waste_collection_app/ui/pages/register_form_page.dart';
import 'package:waste_collection_app/ui/pages/register_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/providers/recolections_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProviders()),
        ChangeNotifierProvider(create: (context) => UserProviders()),
        ChangeNotifierProvider(create: (context) => ControllersProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProviders()),
        ChangeNotifierProvider(create: (context) => RecolectionsProvider()),
        ChangeNotifierProvider(create: (context) => ChartsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('es', 'ES')],
        routes: {
          'register': (context) => RegisterPage(),
          'register_form': (context) => RegisterFormPage(),
          'home': (context) => Home(),
          'order_details': (context) => OrdersDetailsPage(),
          'order_form': (context) => OrdersFormPage(),
        },
        title: 'Recoin',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: LoginPage(),
      ),
    );
  }
}
