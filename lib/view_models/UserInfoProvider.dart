import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/l10n/app_localizations.dart';
import '../core/utils/AppHelper.dart';
import '../data/models/BenefitsModel.dart';
import '../core/flavors_config/flavor_config.dart';
import '../core/mixins/logging_mixin.dart';
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
  static const int EDIT_SCREEN = 0;
  static const int DETAILS_EDIT_SCREEN = 1;
  static const int EMAIL_EDIT_SCREEN = 2;
  static const int MOBILE_EDIT_SCREEN = 3;

  bool _isNavigated = false;

  bool get isNavigated => _isNavigated;

  markNavigated() {
    _isNavigated = true;
  }

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
    if (_userModel != null) {
      OneSignal.User.addTagWithKey("mobile", "${_userModel!.mobile}");
    }

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
          debugPrint("Event:: Updated user:: ${userModel.toString()}",wrapWidth: 1024);
          SharedPreferenceHelper sharedPreferenceHelper =
              await SharedPreferenceHelper.getInstance();
          await sharedPreferenceHelper.saveUserData(userModel);
          _userModel = userModel;
        }

        notifyListeners();
      }
    } catch (e) {
      logEvent("Event:: Fetch profile error ${e.toString()}");
    }
  }

  bool _isFetching = false;
  Timer? profileTimer;

  runFetchProfileTimer() async {
    await fetchUserProfile();
    profileTimer = Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTime), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        await fetchUserProfile();
        _isFetching = false;
      }
    });
  }

  stopFetchProfileTimer() {
    logEvent(
        "PROFILE TIMER STATUS:: ${profileTimer != null && profileTimer!.isActive}");
    if (profileTimer != null && profileTimer!.isActive) {
      profileTimer!.cancel();
      profileTimer = null;
    }
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
      params['appType'] = AppHelper.getAppType();
      params['version'] = FlavorConfig.instance.flavorValues.appVersion;

      NetworkResponse networkResponse =
          await UserService.getInstance().checkForAppUpdate(params);
      logEvent("checkForAppUpdate response: $networkResponse");
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

            logEvent(_benefitItems);
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

  sendOTPAccount(BuildContext context) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = AppLocalizations.of(context)!.msgSendingOTP;
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

  resendOTPAccount({required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = loc.msgResendOTP;
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

  verifyOTPAccount({required String OTP, required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = loc.msgVerifyingOTP;
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

  verifyEmailOTPAccount(
      {required String phone,
      required String OTP,
      required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = loc.msgVerifyingOTP;
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
      {required Map<String, dynamic> params,
      required String OTP,
      required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        _loaderMessage = loc.msgVerifyingOTP;
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

  updateUserInformation({required AppLocalizations loc}) async {
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

/*
        String datePart = tempUser!.dateOfBirth!;
        if (datePart.contains('T')) datePart = datePart.split('T')[0];
        params["DateOfBirth"] = datePart;
*/

        //params["DateOfBirth"] = tempUser!.dateOfBirth;


        logEvent(params);

        NetworkResponse networkResponse =
            await UserService.getInstance().updateUserProfile(params);
        logEvent("UPDATE USER INFO:: ${networkResponse.response}");
        _isNetworkError = networkResponse.isError;

        if ((networkResponse.response is Map<String, dynamic>) &&
            (networkResponse.response as Map<String, dynamic>)
                .containsKey("user")) {
          _networkMessage = loc.msgProfileUpdateSuccess;
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

  updateCommunicationPreferences(
      {bool? sms, bool? email, required AppLocalizations loc}) async {
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
            _networkMessage = loc.msgCommonError;
          } else {
            _networkMessage = loc.msgCommonUpdateSuccess;
          }
        }
      } else {
        if (_isNetworkError!) {
          _networkMessage = loc.msgCommonError;
        } else {
          _networkMessage = loc.msgCommonUpdateSuccess;
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

        _tempUser!.firstName = nameArr[0].trim();
        _tempUser!.lastName =
            nameArr.where((item) => item != nameArr[0]).toString().trim();

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

  sendOTPNewPhone(
      {required String phone, required AppLocalizations loc}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().sendOTPNewPhone(phoneNo: phone);

      if (networkResponse.response != null &&
          networkResponse.response is Map<String, dynamic>) {
        logEvent(networkResponse.toString());
        Map<String, dynamic> responseObject =
            networkResponse.response as Map<String, dynamic>;

        if (responseObject.containsKey("otp")) {
          _otpSent = responseObject["otp"] as bool;
          _networkMessage = responseObject["message"];
        } else {
          _otpSent = false;
          _networkMessage = loc.msgOtpIssue;
        }
      } else {
        _otpSent = false;
        _networkMessage = loc.msgOtpIssue;
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

  sendOTPEmail(String phone, {required AppLocalizations loc}) async {
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
        _networkMessage = loc.msgOtpIssue;
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

  reSendOTPEmail(String phone, {required AppLocalizations loc}) async {
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
          _networkMessage = loc.msgOtpSent;
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

  reSendOTPNewPhone(String phone, {required AppLocalizations loc}) async {
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
          _networkMessage = loc.msgOtpIssue;
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

  String? version;

  /// Fetches the app version and name from the package info and logs it.
  getAppInfo() async {
    final appInfo = await PackageInfo.fromPlatform();
    logEvent('${appInfo.version} ${appInfo.appName}');
    version = "${appInfo.version} (${appInfo.buildNumber})";
    notifyListeners();
  }

  bool? _uploadedSelfie;

  bool? get uploadedSelfie => _uploadedSelfie;

  uploadUserSelfieImage(String imagePath) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      NetworkResponse networkResponse =
          await UserService.getInstance().uploadSelfie(imagePath);
      logEvent("uploadUserSelfieImage >> ${networkResponse.response}");

      _uploadedSelfie = !networkResponse.isError;
    } catch (e) {
      logEvent("reSendOTPNewPhone error:: ${e.toString()}");
      _networkMessage = e.toString();
      _uploadedSelfie = false;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resetUploadedSelfie() {
    _uploadedSelfie = null;
  }

  bool? _showLogoutLoader;

  bool? get showLogoutLoader => _showLogoutLoader;
  bool? _logoutSuccess;

  bool? get logoutSuccess => _logoutSuccess;

  logoutUser() async {
    try {
      // 🚨 STOP PROFILE TIMER IMMEDIATELY
      stopFetchProfileTimer();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLogoutLoader = true;
        notifyListeners();
      });

      NetworkResponse networkResponse =
      await UserService.getInstance().logout();

      logEvent("logoutUser >> ${networkResponse.response}");

      if (networkResponse.response != null &&
          networkResponse.response is Map<String, dynamic> &&
          (networkResponse.response as Map<String, dynamic>)
              .containsKey("user")) {
        _logoutSuccess = true;

        // 🧹 CLEAR USER STATE
        _userModel = null;
        _tempUser = null;
      } else {
        _logoutSuccess = false;
      }
    } catch (e) {
      logEvent("logoutUser error:: ${e.toString()}");
      _networkMessage = e.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLogoutLoader = false;
        notifyListeners();
      });
    }
  }


  resetLogoutStatus() {
    _showLogoutLoader = null;
    _logoutSuccess = null;
    notifyListeners();
  }

  bool? _internetStatus;

  bool? get internetStatus => _internetStatus;

  checkInternetStatus() async {
    _internetStatus = await AppHelper.checkInternetConnection();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
