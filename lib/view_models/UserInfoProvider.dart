import 'dart:async';
import 'package:flutter/material.dart';
import '../core/mixins/logging_mixin.dart';
import '../core/utils/AppStrings.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/models/UserModel.dart';
import '../services/UserService.dart';

class UserInfoProvider extends ChangeNotifier with LoggingMixin {
  UserModel? _userModel;

  UserModel? get getUserInfo => _userModel;

  UserModel? _tempUser;

  UserModel? get tempUser => _tempUser;

  bool? _showCancelAccountLoader;

  bool? get showCancelAccountLoader => _showCancelAccountLoader;
  bool? _cancelledAccount;

  bool? get cancelledAccount => _cancelledAccount;
  int? _selectedEditScreen;

  int? get selectedEditScreen => _selectedEditScreen;
  static int EDIT_SCREEN = 0;
  static int DETAILS_EDIT_SCREEN = 1;
  static int EMAIL_EDIT_SCREEN = 2;
  static int MOBILE_EDIT_SCREEN = 3;

  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _isNetworkError;

  bool? get isNetworkError => _isNetworkError;

  String? _loaderMessage;

  String? get loaderMessage => _loaderMessage;

  bool? _otpSent;

  bool? get otpSent => _otpSent;
  bool? _accountVerified;

  bool? get accountVerified => _accountVerified;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  updateSelectedEditScreen(value) {
    _selectedEditScreen = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  retrieveUserInfo() async {
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();
    _userModel ??= sharedPreferenceHelper.getUserData();
    notifyListeners();
  }

  fetchUserProfile() async {
    try {
      NetworkResponse networkResponse =
          await UserService.getInstance().fetchUserProfile();
      if (!networkResponse.isError) {
        UserModel userModel = UserModel.fromJson(
            networkResponse.response as Map<String, dynamic>);
        logEvent("Event:: Updated user:: ${userModel.toString()}");
        SharedPreferenceHelper sharedPreferenceHelper =
            await SharedPreferenceHelper.getInstance();
        sharedPreferenceHelper.saveUserData(userModel);
        _userModel = userModel;
        notifyListeners();
      }
    } catch (e) {
      logEvent("Event:: Fetch profile error ${e.toString()}");
    }
  }

  bool _isFetching = false;
  int i = 0;

  runFetchProfileTimer() async {
    await fetchUserProfile();
    Timer timer = Timer.periodic(const Duration(seconds: 60), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        i += 1;
        logEvent("Var:: $i");
        await fetchUserProfile();
        _isFetching = false;
      }
    });
  }

  /*Future<String?> getFCMToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    logEvent("FCM Token $fcmToken");
    return fcmToken;
  }*/

  /*uploadDeviceToken() async {
    String? fcmToken = await getFCMToken();
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();
    if (fcmToken != null &&
        fcmToken.isNotEmpty &&
        sharedPreferenceHelper.getAuthToken() != null) {
      Map<String, dynamic> params = {};
      params['device_token'] = fcmToken;
      logEvent("FCM Token $fcmToken --> Device Token $params");
      NetworkResponse networkResponse = await UserService.getInstance()
          .uploadDeviceToken(sharedPreferenceHelper.getAuthToken()!, params);
      logEvent("Upload Device Token Response $networkResponse");
    }
  }*/

  fetchUserPoints() async {
    try {
      NetworkResponse networkResponse =
          await UserService.getInstance().getPoints();

      logEvent("USER POINTS RESPONSE $networkResponse");

      if (!networkResponse.isError) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        if (response.containsKey('Points')) {
          _userModel!.pointsValue = response['Points'] as num;
        }
        if (response.containsKey('Balance')) {
          _userModel!.pointsBalance = (response['Balance'] as num);
        }

        SharedPreferenceHelper sph = await SharedPreferenceHelper.getInstance();
        sph.saveUserData(_userModel!);
        notifyListeners();
      }
    } catch (e) {
      logEvent(e.toString());
    }
  }

  cancelAccount() async {
    try {
      _showCancelAccountLoader = true;
      notifyListeners();
      NetworkResponse networkResponse =
          await UserService.getInstance().cancelAccount();
      _cancelledAccount = !networkResponse.isError;
      _networkMessage = networkResponse.responseMessage;
    } catch (e) {
      _cancelledAccount = false;
      _networkMessage = e.toString();
    } finally {
      _showCancelAccountLoader = false;
      notifyListeners();
    }
  }

  sendOTPAccount() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppStrings.msgSendingOTP;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      Map<String, String> params = {};
      params["countryCode"] = sharedPreferenceHelper.getCountryCode();

      NetworkResponse networkResponse =
          await UserService.getInstance().sendOTPAccount(params);
      logEvent("SEND OTP RESPONSE:: $networkResponse");
      _otpSent = !networkResponse.isError;
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
      logEvent(e.toString());
      _otpSent = false;
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resendOTPAccount() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppStrings.msgResendOTP;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      Map<String, String> params = {};
      params["countryCode"] = sharedPreferenceHelper.getCountryCode();

      NetworkResponse networkResponse =
          await UserService.getInstance().resendOTPAccount(params);
      logEvent("RE-SEND OTP RESPONSE:: $networkResponse");
      _otpSent = !networkResponse.isError;
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
      logEvent(e.toString());
      _otpSent = false;
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  verifyOTPAccount({required String OTP}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppStrings.msgVerifyingOTP;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      Map<String, String> params = {};
      params["countryCode"] = sharedPreferenceHelper.getCountryCode();
      params["otp"] = OTP;

      NetworkResponse networkResponse =
          await UserService.getInstance().verifyOTPAccount(params);
      logEvent("VERIFY OTP RESPONSE:: $networkResponse");

      if (networkResponse.response != null) {
        if (networkResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.containsKey('message')) {
            _networkMessage = response['message'];
          } else {
            _networkMessage = networkResponse.responseMessage;
          }

          if (response.containsKey("verified")) {
            _accountVerified = response['verified'] as bool;
          } else {
            _accountVerified = false;
          }
        } else {
          _networkMessage = networkResponse.responseMessage;
          _accountVerified = false;
        }
      } else {
        _networkMessage = networkResponse.responseMessage;
        _accountVerified = false;
      }
    } catch (e) {
      logEvent(e.toString());
      _accountVerified = false;
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resetNetworkResponse() {
    _otpSent = null;
    _networkMessage = null;
    _accountVerified = null;
    _isNetworkError = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  resetCancelledAccount() {
    _showCancelAccountLoader = null;
    _cancelledAccount = null;
  }

  initTempUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tempUser = _userModel!.copyWith();
      notifyListeners();
    });
  }

  updateUserInformation() async {
    if (tempUser != null) {
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLoader = true;
          notifyListeners();
        });
        Map<String, dynamic> params = {};
        params["GivenNames"] = tempUser!.firstName;
        params["Surname"] = tempUser!.lastName;
        params["Email"] = tempUser!.email;
        params["Mobile"] = tempUser!.mobile;
        params["DateOfBirth"] = tempUser!.dateOfBirth;
        NetworkResponse networkResponse =
            await UserService.getInstance().updateUserProfile(params);

        _isNetworkError = networkResponse.isError;
        _networkMessage = "Your profile is updated successfully!!";
        if ((networkResponse.response is Map<String, dynamic>) &&
            (networkResponse.response as Map<String, dynamic>)
                .containsKey("user")) {
          _userModel = UserModel.fromJson(
              (networkResponse.response as Map<String, dynamic>)["user"]);

          _tempUser = _userModel!.copyWith();
        }
      } catch (e) {
        _networkMessage = e.toString();
        _isNetworkError = true;
      } finally {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLoader = false;
          notifyListeners();
        });
      }
    }
  }

  updateCommunicationPreferences({bool? sms, bool? email}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      Map<String, dynamic> params = {};
      if (sms != null) {}
      if (email != null) {}
      NetworkResponse networkResponse =
          await UserService.getInstance().updateUserProfile(params);
    } catch (e) {
      logEvent("update info error: $e");
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  updateTempUser({String? name, String? dob, String? email, String? phone}) {
    if (name != null && name.isNotEmpty) {
      if (name.contains(" ")) {
        List<String> nameArr = name.split(" ");

        _tempUser!.firstName = nameArr[0];
        _tempUser!.lastName =
            nameArr.where((item) => item != nameArr[0]).toString();

        if (_tempUser!.lastName!.contains("(")) {
          _tempUser!.lastName = _tempUser!.lastName!.replaceAll("(", "");
        }
        if (_tempUser!.lastName!.contains(")")) {
          _tempUser!.lastName = _tempUser!.lastName!.replaceAll(")", "");
        }
        if (_tempUser!.lastName!.contains(",")) {
          _tempUser!.lastName = _tempUser!.lastName!.replaceAll(",", "");
        }

        logEvent("${_tempUser!.firstName} AND ${_tempUser!.lastName}");
      } else {
        _tempUser!.firstName = name;
        _tempUser!.lastName = "";
      }
    }
    if (dob != null && dob.isNotEmpty) {
      _tempUser!.dateOfBirth = dob;
    }
    if (email != null && email.isNotEmpty) {
      _tempUser!.email = email;
    }
    if (phone != null && phone.isNotEmpty) {
      _tempUser!.mobile = phone;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
