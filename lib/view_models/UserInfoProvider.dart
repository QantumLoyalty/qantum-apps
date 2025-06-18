import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/models/BenefitsModel.dart';
import '../core/flavors_config/flavor_config.dart';
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

  bool? _emailOTPSent;

  bool? get emailOTPSent => _emailOTPSent;

  bool? _newMobileOTPSent;

  bool? get newMobileOTPSent => _newMobileOTPSent;

  bool? _accountVerified;

  bool? get accountVerified => _accountVerified;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  BenefitsModel? _benefits;

  BenefitsModel? get benefits => _benefits;

  List<String>? _benefitItems;

  List<String>? get benefitItems => _benefitItems;

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
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        if (response.containsKey("user")) {
          UserModel userModel = UserModel.fromJson(response["user"]);
          logEvent("Event:: Updated user:: ${userModel.toString()}");
          SharedPreferenceHelper sharedPreferenceHelper =
              await SharedPreferenceHelper.getInstance();
          sharedPreferenceHelper.saveUserData(userModel);
          _userModel = userModel;
        }

        notifyListeners();
      }
    } catch (e) {
      logEvent("Event:: Fetch profile error ${e.toString()}");
    }
  }

  bool _isFetching = false;

  runFetchProfileTimer() async {
    await fetchUserProfile();
    Timer timer = Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTime), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        await fetchUserProfile();
        _isFetching = false;
      }
    });
  }

  uploadDeviceDetail() async {
    try {
      String? deviceToken = await AppHelper.getDeviceToken();
      Map<String, dynamic> params = {};
      params['device_token'] = deviceToken ?? "";
      // params['appType'] = "qantum";
      //params['appType'] = FlavorConfig.instance.flavorValues.appName;
      params['app_version'] = FlavorConfig.instance.flavorValues.appVersion;
      params['device_type'] =
          Platform.isAndroid ? "ANDROID" : (Platform.isIOS ? "IOS" : "");

      NetworkResponse networkResponse =
          await UserService.getInstance().updateDeviceDetail(params);
      logEvent("uploadDeviceDetail response: $networkResponse");
    } catch (e) {
      logEvent(e.toString());
    }
  }

  checkForAppUpdate() async {
    try {
      Map<String, dynamic> params = {};
      params['appType'] = FlavorConfig.instance.flavorValues.appName;
      params['version'] = FlavorConfig.instance.flavorValues.appVersion;

      NetworkResponse networkResponse =
          await UserService.getInstance().checkForAppUpdate(params);
      logEvent("uploadDeviceDetail response: $networkResponse");
    } catch (e) {
      logEvent(e.toString());
    }
  }

  getUsersBenefits() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });

      NetworkResponse networkResponse =
          await UserService.getInstance().getUsersBenefits();

      if (networkResponse.response != null &&
          networkResponse.response is Map<String, dynamic>) {
        if ((networkResponse.response as Map<String, dynamic>)
            .containsKey("data")) {
          _benefits = BenefitsModel.fromJson(
              (networkResponse.response! as Map<String, dynamic>)["data"]);

          if (_benefits != null &&
              _benefits!.htmlcontent != null &&
              _benefits!.htmlcontent!.isNotEmpty) {
            String benefits = _benefits!.htmlcontent!;
            benefits = benefits.replaceAll("<ul>", "");
            benefits = benefits.replaceAll("</ul>", "");
            benefits = benefits.replaceAll("<li>", "");
            _benefitItems = benefits.split("</li>");

            print(_benefitItems);
            _benefitItems!.removeWhere((test) => test == " ");
          }
        }
      }
    } catch (e) {
      _isNetworkError = true;
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
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

  verifyEmailOTPAccount({required String phone, required String OTP}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppStrings.msgVerifyingOTP;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      Map<String, String> params = {};
      params["otp"] = OTP;

      NetworkResponse networkResponse =
          await UserService.getInstance().verifyOTPEmail(phone, params);
      logEvent("VERIFY OTP RESPONSE:: $networkResponse");

      _accountVerified = !networkResponse.isError;

      if (networkResponse.response != null) {
        if (networkResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.containsKey('message')) {
            _networkMessage = response['message'];
          } else if (response.containsKey('error')) {
            _networkMessage = response['error'];
          }
/*
          if (response.containsKey("verified")) {
            _accountVerified = response['verified'] as bool;
          } else {
            _accountVerified = false;
          }*/
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

  verifyNewPhoneOTP(
      {required Map<String, dynamic> params, required String OTP}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppStrings.msgVerifyingOTP;
        notifyListeners();
      });

      Map<String, String> requestParams = {};
      requestParams["Otp"] = OTP;
      requestParams["Id"] = params["bluizeUniqueUserId"];
      requestParams["Mobile"] = params["newPhone"];

      NetworkResponse networkResponse =
          await UserService.getInstance().verifyOTPNewPhone(requestParams);
      logEvent("VERIFY OTP RESPONSE:: $networkResponse");

      _accountVerified = !networkResponse.isError;

      if (networkResponse.response != null) {
        if (networkResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;

          if (response.containsKey("verified") &&
              response.containsKey("user")) {
            _accountVerified = response["verified"] as bool;
            SharedPreferenceHelper sharedPreferencesHelper =
                await SharedPreferenceHelper.getInstance();
            await sharedPreferencesHelper
                .saveUserData(UserModel.fromJson(response["user"]));
            await sharedPreferencesHelper.saveAuthToken(response['token']);
            await sharedPreferencesHelper
                .saveCountryCode(params["countryCode"]);

            logEvent(
                "SAVED DATA :: ${sharedPreferencesHelper.getUserData()} --> ${sharedPreferencesHelper.getAuthToken()} --> ${sharedPreferencesHelper.getCountryCode()}");
          } else {
            _accountVerified = false;
          }

          if (response.containsKey('message')) {
            _networkMessage = response['message'];
          } else if (response.containsKey('error')) {
            _networkMessage = response['error'];
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

  resetNetworkResponse({bool? resetTempUser}) {
    _otpSent = null;
    _networkMessage = null;
    _accountVerified = null;
    _isNetworkError = null;
    if (resetTempUser == null) {
      _tempUser = null;
    }

    _emailOTPSent = null;
    _newMobileOTPSent = null;
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
        logEvent("UPDATE USER INFO:: ${networkResponse.response}");
        _isNetworkError = networkResponse.isError;

        if ((networkResponse.response is Map<String, dynamic>) &&
            (networkResponse.response as Map<String, dynamic>)
                .containsKey("user")) {
          _networkMessage = "Your profile is updated successfully!!";
          _userModel = UserModel.fromJson(
              (networkResponse.response as Map<String, dynamic>)["user"]);

          _tempUser = _userModel!.copyWith();
        } else {
          if ((networkResponse.response is Map<String, dynamic>) &&
              (networkResponse.response as Map<String, dynamic>)
                  .containsKey("error")) {
            if ((networkResponse.response as Map<String, dynamic>)["error"]
                    is Map<String, dynamic> &&
                ((networkResponse.response as Map<String, dynamic>)["error"]
                        as Map<String, dynamic>)
                    .containsKey("Message")) {
              _networkMessage =
                  ((networkResponse.response as Map<String, dynamic>)["error"]
                      as Map<String, dynamic>)["Message"];
            } else {
              _networkMessage =
                  (networkResponse.response as Map<String, dynamic>)["error"];
            }
          }
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
      if (sms != null) {
        params['AcceptsSMS'] = sms;
      }
      if (email != null) {
        params['AcceptsEmail'] = email;
      }
      NetworkResponse networkResponse =
          await UserService.getInstance().updateUserProfile(params);
      logEvent("updateCommunicationPreferences >> $networkResponse");

      _isNetworkError = networkResponse.isError;

      if (networkResponse.response is Map<String, dynamic>) {
        if ((networkResponse.response as Map<String, dynamic>)
            .containsKey("message")) {
          _networkMessage =
              (networkResponse.response as Map<String, dynamic>)["message"];
        } else {
          if (_isNetworkError!) {
            _networkMessage = AppStrings.msgCommonError;
          } else {
            _networkMessage = AppStrings.msgCommonUpdateSuccess;
          }
        }
      } else {
        if (_isNetworkError!) {
          _networkMessage = AppStrings.msgCommonError;
        } else {
          _networkMessage = AppStrings.msgCommonUpdateSuccess;
        }
      }

      if (!networkResponse.isError) {
        if (sms != null) {
          _userModel!.acceptsSMS = sms;
        }
        if (email != null) {
          _userModel!.acceptsEmail = email;
        }
      }
    } catch (e) {
      _networkMessage = e.toString();
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

  sendOTPNewPhone({required String phone}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().sendOTPNewPhone(phoneNo: phone);

      if (networkResponse.response != null &&
          networkResponse.response is Map<String, dynamic>) {
        print(networkResponse.toString());
        Map<String, dynamic> responseObject =
            networkResponse.response as Map<String, dynamic>;

        if (responseObject.containsKey("otp")) {
          _otpSent = responseObject["otp"] as bool;
          _networkMessage = responseObject["message"];
        } else {
          _otpSent = false;
          _networkMessage = "Issue while sending the OTP!!!";
        }
      } else {
        _otpSent = false;
        _networkMessage = "Issue while sending the OTP!!!";
      }
    } catch (e) {
      _networkMessage = e.toString();
      _otpSent = false;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  sendOTPEmail(String phone) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().sendOTPEmail(phoneNo: phone);
      logEvent(networkResponse.response);
      _otpSent = !networkResponse.isError;
      if (_otpSent! && networkResponse.response is Map<String, dynamic>) {
        Map<String, dynamic> responseObject =
            networkResponse.response as Map<String, dynamic>;

        if (responseObject.containsKey("user")) {
          _tempUser = UserModel.fromJson(responseObject["user"]);
        }
      } else {
        _networkMessage = "Issue while sending the OTP!!!";
      }
    } catch (e) {
      _networkMessage = e.toString();
      _otpSent = false;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  reSendOTPEmail(String phone) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().resendOTPEmail(phoneNo: phone);
      logEvent("reSendOTPEmail >> ${networkResponse.response}");
      _emailOTPSent = true;

      if (networkResponse.response is Map<String, dynamic>) {
        Map<String, dynamic> responseObject =
            networkResponse.response as Map<String, dynamic>;
        if (responseObject.containsKey("message")) {
          _networkMessage = responseObject["message"];
        } else {
          _networkMessage = "OTP sent successfully!!!";
        }
      }
    } catch (e) {
      logEvent("reSendOTPEmail error:: ${e.toString()}");
      _networkMessage = e.toString();
      _emailOTPSent = false;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  reSendOTPNewPhone(String phone) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().resendOTPNewPhone(phoneNo: phone);
      logEvent("reSendOTPNewPhone >> ${networkResponse.response}");

      if (networkResponse.response is Map<String, dynamic>) {
        Map<String, dynamic> responseObject =
            networkResponse.response as Map<String, dynamic>;
        if (responseObject.containsKey("otp")) {
          _newMobileOTPSent = responseObject["otp"] as bool;
          _networkMessage = responseObject["message"];
        } else {
          _newMobileOTPSent = false;
          _networkMessage = "Issue in sending the OTP";
        }
      }
    } catch (e) {
      logEvent("reSendOTPNewPhone error:: ${e.toString()}");
      _networkMessage = e.toString();
      _newMobileOTPSent = false;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }
}
