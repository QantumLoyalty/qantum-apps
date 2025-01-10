import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  String? _selectedGender;

  String? get selectedGender => _selectedGender;
  static var male = "Male";
  static var female = "Female";
  static var nonbinary = "Non-Binary";

  updateGender(String value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedGender = value;
      notifyListeners();
    });
  }

  bool _tcCheckStatus = false;

  bool get tcCheckStatus => _tcCheckStatus;

  updateTCCheckStatus(bool value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tcCheckStatus = value;
      notifyListeners();
    });
  }
}
