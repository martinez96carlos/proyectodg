import 'package:flutter/material.dart';
import 'package:waste_collection_app/models/charts_model.dart';

class ChartsProvider with ChangeNotifier {
  //GLOBAL
  List<ChartSampleData> _gone = [
    ChartSampleData(x: 'Josef Bican', y: 805),
    ChartSampleData(x: 'Romário', y: 772),
    ChartSampleData(x: 'Pelé', y: 767),
    ChartSampleData(x: 'Ferenc Puskás', y: 746),
    ChartSampleData(x: 'Gerd Müller', y: 735),
    ChartSampleData(x: 'Ronaldo', y: 725),
    ChartSampleData(x: 'Messi', y: 730)
  ];

  List<ChartSampleData> get gone => _gone;
  set gone(List<ChartSampleData> value) {
    _gone = value;
    notifyListeners();
  }

  List<ChartSampleData> _gtwo = [
    ChartSampleData(x: 'David', y: 30, text: 'David \n 30%'),
    ChartSampleData(x: 'Steve', y: 35, text: 'Steve \n 35%'),
    ChartSampleData(x: 'Jack', y: 39, text: 'Jack \n 39%'),
    ChartSampleData(x: 'Others', y: 75, text: 'Others \n 75%'),
  ];

  List<ChartSampleData> get gtwo => _gtwo;
  set gtwo(List<ChartSampleData> value) {
    _gtwo = value;
    notifyListeners();
  }

  List<ChartSampleData> _gthree = [
    ChartSampleData(x: 'Josef Bican', y: 805),
    ChartSampleData(x: 'Romário', y: 772),
    ChartSampleData(x: 'Pelé', y: 767),
    ChartSampleData(x: 'Ferenc Puskás', y: 746),
    ChartSampleData(x: 'Gerd Müller', y: 735),
    ChartSampleData(x: 'Ronaldo', y: 725),
    ChartSampleData(x: 'Messi', y: 730)
  ];

  List<ChartSampleData> get gthree => _gthree;
  set gthree(List<ChartSampleData> value) {
    _gthree = value;
    notifyListeners();
  }

  List<ChartSampleData> _gfour = [
    ChartSampleData(x: 'Jan', y: 43, yValue2: 37, yValue3: 41),
    ChartSampleData(x: 'Feb', y: 45, yValue2: 37, yValue3: 45),
    ChartSampleData(x: 'Mar', y: 50, yValue2: 39, yValue3: 48),
    ChartSampleData(x: 'Apr', y: 55, yValue2: 43, yValue3: 52),
    ChartSampleData(x: 'May', y: 63, yValue2: 48, yValue3: 57),
    ChartSampleData(x: 'Jun', y: 68, yValue2: 54, yValue3: 61),
    ChartSampleData(x: 'Jul', y: 72, yValue2: 57, yValue3: 66),
    ChartSampleData(x: 'Aug', y: 70, yValue2: 57, yValue3: 66),
    ChartSampleData(x: 'Sep', y: 66, yValue2: 54, yValue3: 63),
    ChartSampleData(x: 'Oct', y: 57, yValue2: 48, yValue3: 55),
    ChartSampleData(x: 'Nov', y: 50, yValue2: 43, yValue3: 50),
    ChartSampleData(x: 'Dec', y: 45, yValue2: 37, yValue3: 45)
  ];

  List<ChartSampleData> get gfour => _gfour;
  set gfour(List<ChartSampleData> value) {
    _gfour = value;
    notifyListeners();
  }

  List<ChartSampleData> _gfive = [
    ChartSampleData(
        x: 'France', y: 84452000, yValue2: 82682000, yValue3: 86861000),
    ChartSampleData(
        x: 'Spain', y: 68175000, yValue2: 75315000, yValue3: 81786000),
    ChartSampleData(x: 'US', y: 77774000, yValue2: 76407000, yValue3: 76941000),
    ChartSampleData(
        x: 'Italy', y: 50732000, yValue2: 52372000, yValue3: 58253000),
    ChartSampleData(
        x: 'Mexico', y: 32093000, yValue2: 35079000, yValue3: 39291000),
    ChartSampleData(x: 'UK', y: 34436000, yValue2: 35814000, yValue3: 37651000),
  ];

  List<ChartSampleData> get gfive => _gfive;
  set gfive(List<ChartSampleData> value) {
    _gfive = value;
    notifyListeners();
  }

  //PERSONAL
  List<ChartSampleData> _pone = [
    ChartSampleData(x: 'Josef Bican', y: 805),
    ChartSampleData(x: 'Romário', y: 772),
    ChartSampleData(x: 'Pelé', y: 767),
    ChartSampleData(x: 'Ferenc Puskás', y: 746),
    ChartSampleData(x: 'Gerd Müller', y: 735),
    ChartSampleData(x: 'Ronaldo', y: 725),
    ChartSampleData(x: 'Messi', y: 730)
  ];

  List<ChartSampleData> get pone => _pone;
  set pone(List<ChartSampleData> value) {
    _pone = value;
    notifyListeners();
  }

  List<ChartSampleData> _ptwo = [
    ChartSampleData(x: 'Jan', y: 43, yValue2: 37, yValue3: 41),
    ChartSampleData(x: 'Feb', y: 45, yValue2: 37, yValue3: 45),
    ChartSampleData(x: 'Mar', y: 50, yValue2: 39, yValue3: 48),
    ChartSampleData(x: 'Apr', y: 55, yValue2: 43, yValue3: 52),
    ChartSampleData(x: 'May', y: 63, yValue2: 48, yValue3: 57),
    ChartSampleData(x: 'Jun', y: 68, yValue2: 54, yValue3: 61),
    ChartSampleData(x: 'Jul', y: 72, yValue2: 57, yValue3: 66),
    ChartSampleData(x: 'Aug', y: 70, yValue2: 57, yValue3: 66),
    ChartSampleData(x: 'Sep', y: 66, yValue2: 54, yValue3: 63),
    ChartSampleData(x: 'Oct', y: 57, yValue2: 48, yValue3: 55),
    ChartSampleData(x: 'Nov', y: 50, yValue2: 43, yValue3: 50),
    ChartSampleData(x: 'Dec', y: 45, yValue2: 37, yValue3: 45)
  ];

  List<ChartSampleData> get ptwo => _ptwo;
  set ptwo(List<ChartSampleData> value) {
    _ptwo = value;
    notifyListeners();
  }

  List<ChartSampleData> _pthree = [
    ChartSampleData(
        x: 'France', y: 84452000, yValue2: 82682000, yValue3: 86861000),
    ChartSampleData(
        x: 'Spain', y: 68175000, yValue2: 75315000, yValue3: 81786000),
    ChartSampleData(x: 'US', y: 77774000, yValue2: 76407000, yValue3: 76941000),
    ChartSampleData(
        x: 'Italy', y: 50732000, yValue2: 52372000, yValue3: 58253000),
    ChartSampleData(
        x: 'Mexico', y: 32093000, yValue2: 35079000, yValue3: 39291000),
    ChartSampleData(x: 'UK', y: 34436000, yValue2: 35814000, yValue3: 37651000),
  ];

  List<ChartSampleData> get pthree => _pthree;
  set pthree(List<ChartSampleData> value) {
    _pthree = value;
    notifyListeners();
  }
}
