import 'package:buffalo_thai/model/association_model.dart';
import 'package:flutter/material.dart';

class SelectedAssociation with ChangeNotifier {
  AssociationModel? _association;

  AssociationModel? get association => _association;

  void setSelectedAssociation(AssociationModel association) {
    _association = association;
    notifyListeners();
  }
}
