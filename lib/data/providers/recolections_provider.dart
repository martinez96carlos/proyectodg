import 'package:flutter/material.dart';
import 'package:waste_collection_app/models/recolections.dart';

class RecolectionsProvider with ChangeNotifier {
  Recolection _recolectionActive = Recolection();

  Recolection get recolectionActive => _recolectionActive;
  set recolectionActive(Recolection value) {
    _recolectionActive = value;
    notifyListeners();
  }

  List<Recolection> _recolections = [];

  List<Recolection> get recolections => _recolections;
  set recolections(List<Recolection> value) {
    _recolections = value;
    notifyListeners();
  }

  void addRecolection(Recolection value) {
    _recolections.add(value);
    notifyListeners();
  }

  void deleteRecolection(int pointer) {
    _recolections.removeAt(pointer);
    notifyListeners();
  }

}
