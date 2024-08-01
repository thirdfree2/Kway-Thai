import 'package:flutter/material.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/services/user_services.dart';

class FarmDataProvider with ChangeNotifier {
  List<BuffaloModel> _buffaloes = [];
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;

  List<BuffaloModel> get buffaloes => _buffaloes;
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFarmData(String farmId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _buffaloes = await fetchBuffaloesByFarmId(farmId);
      _users = await fetchUserByFarmId(farmId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
