import 'package:buffalo_thai/model/farm_model.dart';
import 'package:flutter/material.dart';

class SelectedRegion with ChangeNotifier {
  String _region = '';
  List<FarmModel> _farms = [];

  String get region => _region;
  List<FarmModel> get farms => _farms;

  void setSelectedRegion(String region, List<FarmModel> farms) {
    _region = region;
    _farms = farms;
    notifyListeners();
  }
}
