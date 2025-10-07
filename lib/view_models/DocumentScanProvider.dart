import 'package:flutter/material.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/services/AppDataService.dart';

import '../core/mixins/logging_mixin.dart';

class DocumentScanProvider extends ChangeNotifier with LoggingMixin {
  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _isError;

  bool? get isError => _isError;

  Map<String, dynamic>? _scannedData;

  Map<String, dynamic>? get scannedData => _scannedData;

  resetError() {
    _isError = null;
    notifyListeners();
  }

  getDrivingLicenseInformation(
      String frontImagePath, String backImagePath) async {
    logEvent("Front Image Path: $frontImagePath");
    logEvent("Back Image Path: $backImagePath");
    notifyListeners();
    try {
      _showLoader = true;
      notifyListeners();

      NetworkResponse response = await AppDataService.getInstance()
          .fetchDLInformation(
              frontImagePath: frontImagePath, backImagePath: backImagePath);

      logEvent("DL RESPONSE $response");

      if (!response.isError) {
        Map<String, dynamic> data = response.response as Map<String, dynamic>;

        if (data["status"] == "success") {
          logEvent("DL Data: $data");
          _scannedData = data;
          _isError = false;
        } else {
          _isError = true;
          logEvent("DL Scan Failed: ${data["message"]}");
        }
      }
    } catch (e) {
      logEvent("Exception: $e");
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }
}
