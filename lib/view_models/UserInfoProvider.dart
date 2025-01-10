import 'dart:async';

import 'package:flutter/material.dart';

import '../core/utils/AppHelper.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/models/UserModel.dart';
import '../services/UserService.dart';

class UserInfoProvider extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get getUserInfo => _userModel;

  bool? _showCancelAccountLoader;

  bool? get showCancelAccountLoader => _showCancelAccountLoader;
  bool? _cancelledAccount;

  bool? get cancelledAccount => _cancelledAccount;

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
        AppHelper.printMessage("Updated user:: ${userModel.toString()}");

        SharedPreferenceHelper sharedPreferenceHelper =
            await SharedPreferenceHelper.getInstance();
        sharedPreferenceHelper.saveUserData(userModel);
        _userModel = userModel;
        notifyListeners();
      }
    } catch (e) {
      AppHelper.printMessage("Fetch profile error ${e.toString()}");
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
        AppHelper.printMessage("Var:: $i");
        await fetchUserProfile();
        _isFetching = false;
      }
    });
  }

  /*Future<String?> getFCMToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    AppHelper.printMessage("FCM Token $fcmToken");
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
      AppHelper.printMessage("FCM Token $fcmToken --> Device Token $params");
      NetworkResponse networkResponse = await UserService.getInstance()
          .uploadDeviceToken(sharedPreferenceHelper.getAuthToken()!, params);
      AppHelper.printMessage("Upload Device Token Response $networkResponse");
    }
  }*/

  fetchUserPoints() async {
    try {
      NetworkResponse networkResponse =
          await UserService.getInstance().getPoints();

      AppHelper.printMessage("USER POINTS RESPONSE $networkResponse");

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
      AppHelper.printMessage(e.toString());
    }
  }

  cancelAccount() async {
    try {
      _showCancelAccountLoader = true;
      notifyListeners();
      NetworkResponse networkResponse =
          await UserService.getInstance().cancelAccount();
      _cancelledAccount = !networkResponse.isError;
    } catch (e) {
      _cancelledAccount = false;
    } finally {
      _showCancelAccountLoader = false;
      notifyListeners();
    }
  }

  resetCancelledAccount() {
    _showCancelAccountLoader = null;
    _cancelledAccount = null;
  }
}
