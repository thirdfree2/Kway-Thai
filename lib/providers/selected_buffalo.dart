import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:flutter/foundation.dart';

class SelectedBuffalo with ChangeNotifier {
  BuffaloModel? _buffalo;

  BuffaloModel? get buffalo => _buffalo;

  void setSelectedBuffalo(BuffaloModel buffalo) {
    _buffalo = buffalo;
    notifyListeners();
  }
}