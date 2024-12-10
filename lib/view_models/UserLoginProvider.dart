import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/local/SharedPreferenceHelper.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:qantum_apps/services/UserService.dart';

class UserLoginProvider extends ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  bool? _networkError;

  bool? get networkError => _networkError;

  bool? _isExistingUser;

  bool? get isExistingUser => _isExistingUser;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  login(String phoneNo) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoader = true;
      notifyListeners();
    });
    try {
      NetworkResponse networkResponse =
          await UserService.getInstance().login(phoneNo);
      _networkError = networkResponse.isError;

      if (networkResponse.response != null) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;

        _networkMessage = response['message'];

        if (response['registered'] != null &&
            (response['registered'] as bool)) {
          _isExistingUser = true;
          SharedPreferenceHelper sharedPreferencesHelper =
              await SharedPreferenceHelper.getInstance();
          sharedPreferencesHelper
              .saveUserData(UserModel.fromJson(response['user']));
        } else {
          _isExistingUser = false;
        }
      }
    } catch (e) {
      print(">>> ${e.toString()}");
      _networkError = true;
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resetUserStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isExistingUser = null;
      notifyListeners();
    });
  }

  resetNetworkResponseStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _networkError = null;
      _networkMessage = null;
      notifyListeners();
    });
  }
}
