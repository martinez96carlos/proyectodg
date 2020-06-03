import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waste_collection_app/data/providers/charts_provider.dart';
import 'package:waste_collection_app/models/charts_model.dart';

//PERSONAL CHARTS
//FIRST

class PersonalFirst extends StatelessWidget {
  List<ColumnSeries<ChartSampleData, String>> getLabelIntersectActionSeries(
      bool isTileView, List<ChartSampleData> chartData) {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.top))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por residuo personal'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          interval: 20,
          majorTickLines: MajorTickLines(size: 0)),
      series: getLabelIntersectActionSeries(false, charts.pone),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
          header: '',
          canShowMarker: false),
    ));
  }
}

//----------------------------------------------------------------------

//SECOND

class PersonalSecond extends StatelessWidget {
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries(
      bool isTileView, List<ChartSampleData> chartData) {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        markerSettings: MarkerSettings(isVisible: true),
        name: 'High',
      ),
      SplineSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        name: 'Low',
        markerSettings: MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por mes personal'),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10,
          axisLine: AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: getDefaultSplineSeries(false, charts.ptwo),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

//-------------------------------------------------------------------------------

//THIRD

class PersonalThird extends StatelessWidget {
  List<BarSeries<ChartSampleData, String>> getDefaultBarSeries(
      bool isTileView, final List<ChartSampleData> chartData) {
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: '2020'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: '2020'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
          name: '2020')
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por vivienda personal'),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: getDefaultBarSeries(false, charts.pthree),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

//---------------------------------------------------------------------------------

//GLOBAL CHARTS

//FIRST
class GlobalFirst extends StatelessWidget {
  List<ColumnSeries<ChartSampleData, String>> getLabelIntersectActionSeries(
      bool isTileViewm, List<ChartSampleData> chartData) {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.top))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por residuo general'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          interval: 50,
          majorTickLines: MajorTickLines(size: 0)),
      series: getLabelIntersectActionSeries(false, charts.gone),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
          header: '',
          canShowMarker: false),
    ));
  }
}

//----------------------------------------------------------

//SECOND

class GlobalSecond extends StatelessWidget {
  List<PieSeries<ChartSampleData, String>> getDefaultPieSeries(
      bool isTileView, List<ChartSampleData> pieData) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: pieData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return SfCircularChart(
      title: ChartTitle(text: 'Volumen por ciudad'),
      legend: Legend(isVisible: false),
      series: getDefaultPieSeries(false, charts.gtwo),
    );
  }
}

//------------------------------------------------------------------------------------

//THIRD

class GlobalThird extends StatelessWidget {
  List<ColumnSeries<ChartSampleData, String>> getLabelIntersectActionSeries(
      bool isTileView, List<ChartSampleData> chartData) {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.top))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Top cinco recolectores'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          interval: 50,
          majorTickLines: MajorTickLines(size: 0)),
      series: getLabelIntersectActionSeries(false, charts.gthree),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
          header: '',
          canShowMarker: false),
    ));
  }
}

//---------------------------------------------------------

//FOURTH

class GlobalFourth extends StatelessWidget {
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries(
      bool isTileView, List<ChartSampleData> chartData) {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        markerSettings: MarkerSettings(isVisible: true),
        name: 'High',
      ),
      SplineSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        name: 'Low',
        markerSettings: MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por mes'),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 150,
          axisLine: AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: getDefaultSplineSeries(false, charts.gfour),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

//------------------------------------------------------------------------

//FIFTH

class GlobalFifth extends StatelessWidget {
  List<BarSeries<ChartSampleData, String>> getDefaultBarSeries(
      bool isTileView, List<ChartSampleData> chartData) {
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: '2020'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: '2020'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
          name: '2020')
    ];
  }

  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<ChartsProvider>(context);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Volumen por tipo de vivienda'),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: getDefaultBarSeries(false, charts.gfive),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}
