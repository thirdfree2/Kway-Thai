import 'package:flutter/material.dart';

class SelectedRegion with ChangeNotifier {
  String _region = '';
  List<String> _farmNames = [];

  String get region => _region;
  List<String> get farmNames => _farmNames;

  void setSelectedRegion(String region, List<String> farmNames) {
    _region = region;
    _farmNames = farmNames;
    notifyListeners();
  }
}