import 'package:buffalo_thai/model/farm_model.dart';
import 'package:flutter/material.dart';

class SelectedRegion with ChangeNotifier {
  String _region = '';
  String _regionEn = '';
  List<FarmModel> _farms = [];

  String get region => _region;
  String get regionEn => _regionEn;
  List<FarmModel> get farms => _farms;

  String getRegionEnglishName(String region) {
    switch (region) {
      case 'เหนือ':
        return 'North';
      case 'อีสาน':
        return 'Northeastern';
      case 'ตะวันออก':
        return 'Eastern';
      case 'ตะวันตก':
        return 'Western';
      case 'กลาง':
        return 'Central';
      case 'ใต้':
        return 'South';
      default:
        return '';
    }
  }

  void setSelectedRegion(String region, List<FarmModel> farms) {
    _region = region;
    _farms = farms;
    _regionEn = getRegionEnglishName(region);
    notifyListeners();
  }
}
