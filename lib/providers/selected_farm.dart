import 'package:flutter/material.dart';

class SelectedFarm with ChangeNotifier {
  String _region = '';
  String _farmNames = '';

  String get region => _region;
  String get farmNames => _farmNames;

  void setSelectedFarm(String region, String farmNames) {
    _region = region;
    _farmNames = farmNames;
    notifyListeners();
  }
}