import 'package:flutter/material.dart';

class SelectedBuffalo with ChangeNotifier {
  String _buffalo = '';

  String get buffalo => _buffalo;

  void setSelectedBuffalo(String buffalo) {
    _buffalo = buffalo;
    notifyListeners();
  }
}