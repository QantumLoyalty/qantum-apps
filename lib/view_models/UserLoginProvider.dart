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

  String? _userId;

  String? get userId => _userId;

  bool? _isRegistered;

  bool? get isRegistered => _isRegistered;

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

        if (response['registered'] != null) {
          if (response['registered'] as bool) {
            _isExistingUser = true;
          } else {
            _isExistingUser = false;
          }

          if (response['user'] != null) {
            if ((response['user'] as Map<String, dynamic>)['Id'] != null) {
              _userId = (response['user'] as Map<String, dynamic>)['Id'];
            }
          }
        } else {
          _isExistingUser = null;
        }
      }
    } catch (e) {
      AppHelper.printMessage(">>> ${e.toString()}");
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
      _networkError = null;
      _networkMessage = null;
      notifyListeners();
    });
  }

  signup(String phoneNo, Map<String, dynamic> params) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().signup(phoneNo, params);
      AppHelper.printMessage(networkResponse);

      if (networkResponse.response != null) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        _networkError = networkResponse.isError;
        if (response.containsKey('message')) {
          _networkMessage = response['message'];
          if (response.containsKey('userId') && response['userId'] != null) {
            _isRegistered = true;

            if (response.containsKey('thirdPartyData') &&
                response['thirdPartyData'] is Map<String, dynamic>) {
              _userId =
                  (response['thirdPartyData'] as Map<String, dynamic>)['Id'];
            }
          } else {
            _isRegistered = false;
          }
        } else {
          _networkMessage =
              "Ooppss.. something went wrong, please try again or contact to our support team.";
          _isRegistered = false;
        }
      } else {
        _isRegistered = false;
      }
    } catch (e) {
      _networkError = true;
      _networkMessage = e.toString();
      AppHelper.printMessage(_networkMessage);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resetNetworkResponseStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _networkError = null;
      _networkMessage = null;
      notifyListeners();
    });
  }

  resetUserRegisterStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isRegistered = null;
      _networkMessage = null;
      _networkError = null;
      notifyListeners();
    });
  }

  verifyOTP({required String userId, required String otp, required String countryCode}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      Map<String, dynamic> params = {};
      params['Id'] = userId;
      params['otp'] = otp;
      params['countryCode'] = countryCode;

      AppHelper.printMessage("Post Param:: $params");
      NetworkResponse networkResponse =
          await UserService.getInstance().verifyOTP(params);
      _networkError = networkResponse.isError;
      _networkMessage = networkResponse.responseMessage;
      AppHelper.printMessage(networkResponse);
      if (networkResponse.response != null) {
        SharedPreferenceHelper sharedPreferencesHelper =
            await SharedPreferenceHelper.getInstance();
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;

        _networkMessage = response['message'];
        if (!_networkError!) {
          AppHelper.printMessage("SAVING RESPONSE");
          Map<String, dynamic> data = response['user'] as Map<String, dynamic>;
          AppHelper.printMessage(
              "PARSED USER DATA::: ${UserModel.fromJson(data)}");
          await sharedPreferencesHelper.saveUserData(UserModel.fromJson(data));
          await sharedPreferencesHelper.saveAuthToken(response['token']);
        }
      }
    } catch (e) {
      _networkError = true;
      _networkMessage = e.toString();
      AppHelper.printMessage(_networkMessage);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }
}
