import 'package:flutter/material.dart';

class SelectedFarm with ChangeNotifier {
  String _region = '';
  String _farmNames = '';
  String _farmId = '';

  String get region => _region;
  String get farmNames => _farmNames;
  String get farmId => _farmId;

  void setSelectedFarm(String region, String farmNames, String farmId) {
    _region = region;
    _farmNames = farmNames;
    _farmId = farmId;
    notifyListeners();
  }
}