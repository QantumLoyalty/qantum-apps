import 'package:flutter/material.dart';
import '/data/models/NetworkResponse.dart';
import '/services/AppDataService.dart';

import '../core/mixins/logging_mixin.dart';

class DocumentScanProvider extends ChangeNotifier with LoggingMixin {
  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _isErrorInScan;

  bool? get isErrorInScan => _isErrorInScan;

  bool? _isErrorInUpload;

  bool? get isErrorInUpload => _isErrorInUpload;

  Map<String, dynamic>? _scannedData;

  Map<String, dynamic>? get scannedData => _scannedData;

  NetworkResponse? _imageUploadResponse;

  NetworkResponse? get imageUploadResponse => _imageUploadResponse;

  String? _frontImageUrl;

  String? get frontImageUrl => _frontImageUrl;
  String? _backImageUrl;

  String? get backImageUrl => _backImageUrl;

  bool _isNavigated = false;

  bool get isNavigated => _isNavigated;

  markNavigated() {
    _isNavigated = true;
  }

  resetNavigated() {
    _isNavigated = false;
    notifyListeners();
  }

  resetErrorInScan() {
    _isErrorInScan = null;
  }

  resetError() {
    _isErrorInUpload = null;
    //notifyListeners();
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
      _isErrorInScan = response.isError;

      if (!response.isError) {
        Map<String, dynamic> data = response.response as Map<String, dynamic>;
        if (data["status"] == "success") {
          logEvent("DL Data: $data");
          _scannedData = data;
          _isErrorInScan = false;
        } else {
          _isErrorInScan = true;
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

  uploadDrivingLicenseImages(
      String frontImagePath, String backImagePath) async {
    try {
      _showLoader = true;
      notifyListeners();

      NetworkResponse response = await AppDataService.getInstance()
          .uploadDLImages(
              frontImagePath: frontImagePath, backImagePath: backImagePath);

      logEvent("DL Upload RESPONSE $response");
      _isErrorInUpload = response.isError;

      if (!response.isError) {
        Map<String, dynamic> data = response.response as Map<String, dynamic>;



        if (data.containsKey("front")) {
          _frontImageUrl = data["front"];
        }
        if (data.containsKey("back")) {
          _backImageUrl = data["back"];
        }

        logEvent(
            "FRONT IMAGE URL:$_frontImageUrl BACK IMAGE URL:$_backImageUrl");
      }
    } catch (e) {
      logEvent("Exception: $e");
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }
}
