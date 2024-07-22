import 'package:flutter/material.dart';

class SelectedFarmOwner with ChangeNotifier {
  String _farmOwner = '';

  String get farmOwner => _farmOwner;

  void setSelectedFarmOwner(String farmOwner) {
    _farmOwner = farmOwner;
    notifyListeners();
  }
}