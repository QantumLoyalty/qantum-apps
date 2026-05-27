import 'package:flutter/material.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import '/l10n/app_localizations.dart';
import '/core/utils/AppHelper.dart';
import '/data/local/SharedPreferenceHelper.dart';
import '/data/models/NetworkResponse.dart';
import '/data/models/UserModel.dart';
import '/services/UserService.dart';

class UserLoginProvider extends ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  String loaderMessage = "";

  bool? _networkError;

  bool? get networkError => _networkError;

  bool? _isExistingUser;

  bool? get isExistingUser => _isExistingUser;

  String? _userId;

  String? get userId => _userId;

  bool? _isRegistered;

  bool? get isRegistered => _isRegistered;

  bool? _isTestUser;

  bool? get isTestUser => _isTestUser;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  UserModel? loggedInUser;

  Future<void> login(String phoneNo, BuildContext context) async {
    _showLoader = true;
    notifyListeners();

    try {
      final networkResponse = await UserService.getInstance().login(phoneNo);

      _networkError = networkResponse.isError;

      if (networkResponse.response is Map<String, dynamic>) {
        final response = networkResponse.response as Map<String, dynamic>;

        _networkMessage = response['message'];

        print(
            "LOGIN RESPONSE: ${response.toString()} && _networkMessage: $_networkMessage");

        if (response.containsKey("isCancel") &&
            (response["isCancel"] as bool)) {
          _networkError = true;
        } else {
          final isRegistered = response['registered'];

          if (isRegistered != null) {
            if (isRegistered == true) {
              _isTestUser = response['test'] == true;
              _isExistingUser = !_isTestUser!;
            } else {
              _isExistingUser = false;
            }

            final user = response['user'];
            if (user is Map<String, dynamic> && user['Id'] != null) {
              _userId = user['Id'];
            }
          } else {
            _isExistingUser = null;
          }
        }
      } else {
        _networkMessage = networkResponse.responseMessage;
      }

      _networkMessage!.logMessage('NETWORK LOG');
    } catch (e) {
      AppHelper.printMessage(">>> error ${e.toString()}");

      _networkError = true;

      String error = e.toString().toLowerCase();

      // ✅ Strong error handling
      if (error.contains('socketexception') ||
          error.contains('failed host lookup') ||
          error.contains('clientexception') ||
          error.contains('network is unreachable') ||
          error.contains('connection failed') ||
          error.contains('timed out')) {
        _networkMessage = AppLocalizations.of(context)!.msgUnableConnect;
      } else {
        _networkMessage = "Something went wrong. Please try again.";
      }
      _networkMessage!.logMessage('NETWORK LOG');
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  resetUserStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isExistingUser = null;
      _networkError = null;
      _networkMessage = null;
      _isTestUser = null;
      notifyListeners();
    });
  }

  signup(String phoneNo, Map<String, dynamic> params,
      {required AppLocalizations loc}) async {
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
        if (response.containsKey('Message') ||
            response.containsKey('message')) {
          if (response.containsKey('Message')) {
            _networkMessage = response['Message'];
          } else if (response.containsKey('message')) {
            _networkMessage = response['message'];
          }

          print(">>> $_networkMessage");
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
          _networkMessage = loc.msgCommonError;
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
      otpSent = null;
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

  verifyOTP(
      {required String userId,
      required String otp,
      required String countryCode,
      required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        loaderMessage = loc.msgVerifyingOTP;
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
          debugPrint(response.toString(), wrapWidth: 1024);
          Map<String, dynamic> data = response['user'] as Map<String, dynamic>;

          loggedInUser = UserModel.fromJson(data);
          if (response.containsKey("serverTime")) {
            loggedInUser!.serverTime = response["serverTime"];
          }
          AppHelper.printMessage(
              "PARSED USER DATA::: ${loggedInUser!.toString()}");

          await sharedPreferencesHelper.saveUserData(loggedInUser!);
          await sharedPreferencesHelper.saveAuthToken(response['token']);
          await sharedPreferencesHelper.saveCountryCode(countryCode);
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

  bool? otpSent;

  resendOTP({required String phoneNo, required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        loaderMessage = loc.msgResendOTP;
        notifyListeners();
      });

      NetworkResponse networkResponse =
          await UserService.getInstance().resendOTP(phoneNumber: phoneNo);

      otpSent = !networkResponse.isError;

      if (networkResponse.response != null) {
        if (networkResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.containsKey('message')) {
            _networkMessage = response['message'];
          } else {
            _networkMessage = networkResponse.responseMessage;
          }
        } else {
          _networkMessage = networkResponse.responseMessage;
        }
      } else {
        _networkMessage = networkResponse.responseMessage;
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
