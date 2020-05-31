import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    return Column(
      children: <Widget>[
        Expanded(
            child: TabBarView(controller: _controller, children: [
          SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                  height: 300.0,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            // Bind data source
                            dataSource: <SalesData>[
                              SalesData('Jan', 35),
                              SalesData('Feb', 28),
                              SalesData('Mar', 34),
                              SalesData('Apr', 32),
                              SalesData('May', 40)
                            ],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales)
                      ])),
              Container(
                  height: 300.0,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            // Bind data source
                            dataSource: <SalesData>[
                              SalesData('Jan', 35),
                              SalesData('Feb', 28),
                              SalesData('Mar', 34),
                              SalesData('Apr', 32),
                              SalesData('May', 40)
                            ],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales)
                      ])),
            ],
          )),
          Container(),
        ])),
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
