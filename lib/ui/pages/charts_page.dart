import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/ui/widgets/charts.dart';
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart';
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart';
import 'package:waste_collection_app/utils/request.dart' as request;

class ChartsPage extends StatefulWidget {
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllersProvider>(context);
    final user = Provider.of<UserProviders>(context);
    return Column(
      children: <Widget>[
        Expanded(
            child: Stack(
          children: <Widget>[
            TabBarView(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PersonalCharts(),
                  GlobalCharts(),
                ]),
            controller.isLoading ? LoadingWidget() : Container(),
            controller.chartsRequest
                ? Container(
                    color: Colors.white70,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Solicitar la información'),
                          SizedBox(height: 16.0),
                          SizedBox(
                              width: 100.0,
                              child: BoxButton(
                                  title: 'Solicitar',
                                  function: () async {
                                    controller.chartsRequest = false;
                                    controller.isLoading = true;
                                    await request.getVolumeByGeneralOrder(
                                        context: context);
                                    await request.getVolumeByResidenceType(
                                        context: context);
                                    await request.getVolumeByMonth(
                                        context: context);
                                    await request.getVolumeByCity(
                                        context: context);
                                    await request.getTopFiveRecolectors(
                                        context: context);
                                    await request.getVolumeByPersonalResidence(
                                        id: user.user.id.toString(),
                                        context: context);
                                    await request.getVolumeByPersonalOrder(
                                        id: user.user.id.toString(),
                                        context: context);
                                    await request.getVolumeByPersonalMonth(
                                        id: user.user.id.toString(),
                                        context: context);
                                    controller.isLoading = false;
                                  },
                                  color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        )),
        TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
              insets: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 40.0),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w300),
            controller: _controller,
            tabs: [
              Tab(text: 'PERSONALES'),
              Tab(text: 'GLOBALES'),
            ])
      ],
    );
  }
}

class PersonalCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllersProvider>(context);
    final user = Provider.of<UserProviders>(context);
    return RefreshIndicator(
      onRefresh: () async {
        controller.isLoading = true;
        await request.getVolumeByGeneralOrder(context: context);
        await request.getVolumeByResidenceType(context: context);
        await request.getVolumeByMonth(context: context);
        await request.getVolumeByCity(context: context);
        await request.getTopFiveRecolectors(context: context);
        await request.getVolumeByPersonalResidence(
            id: user.user.id.toString(), context: context);
        await request.getVolumeByPersonalOrder(
            id: user.user.id.toString(), context: context);
        await request.getVolumeByPersonalMonth(
            id: user.user.id.toString(), context: context);
        controller.isLoading = false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300.0, child: PersonalFirst()),
            SizedBox(height: 300.0, child: PersonalSecond()),
            SizedBox(height: 300.0, child: PersonalThird()),
          ],
        ),
      ),
    );
  }
}

class GlobalCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllersProvider>(context);
    final user = Provider.of<UserProviders>(context);
    return RefreshIndicator(
      onRefresh: () async {
        controller.isLoading = true;
        await request.getVolumeByGeneralOrder(context: context);
        await request.getVolumeByResidenceType(context: context);
        await request.getVolumeByMonth(context: context);
        await request.getVolumeByCity(context: context);
        await request.getTopFiveRecolectors(context: context);
        await request.getVolumeByPersonalResidence(
            id: user.user.id.toString(), context: context);
        await request.getVolumeByPersonalOrder(
            id: user.user.id.toString(), context: context);
        await request.getVolumeByPersonalMonth(
            id: user.user.id.toString(), context: context);
        controller.isLoading = false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300.0, child: GlobalFirst()),
            SizedBox(height: 300.0, child: GlobalSecond()),
            SizedBox(height: 300.0, child: GlobalThird()),
            SizedBox(height: 300.0, child: GlobalFourth()),
            SizedBox(height: 300.0, child: GlobalFifth()),
          ],
        ),
      ),
    );
  }
}

class ChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('prueba charts')), body: ChartsPage());
  }
}
