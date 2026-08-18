import 'dart:async';

import 'package:flutter/material.dart';

import '/data/models/incentives/SmartIncentivesResponse.dart';
import '../core/extensions/log_extension.dart';
import '../core/mixins/logging_mixin.dart';
import '../core/utils/AppHelper.dart';
import '../core/utils/FlavorConstants.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/models/PromotionModel.dart';
import '../data/models/incentives/SmartIncentivesParam.dart';
import '../data/models/UserModel.dart';
import '../services/AppDataService.dart';

class PromotionsProvider extends ChangeNotifier with LoggingMixin {
  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _isError;

  bool? get isError => _isError;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  PromotionModel? _promotions;

  PromotionModel? get promotions => _promotions;

  List<MatchedIncentive> _incentives = [];

  List<MatchedIncentive> get incentives => _incentives;

  getPromotions() async {
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = sharedPreferenceHelper.getUserData();

      if (userData != null && !userData.isUserStatusCancelled()) {
        String userTier = FlavorConstants.getUserTierType(userData);
        String? venue = userData.venueName;
        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchPromotions(userTier, selectedVenue: venue);
        _isError = networkResponse.isError;
        Map<String, dynamic> resultData =
            networkResponse.response as Map<String, dynamic>;
        if (resultData.containsKey("success") &&
            resultData["success"] as bool &&
            resultData.containsKey("data")) {
          _promotions = PromotionModel.fromJson(resultData["data"]);
        }
      }
    } catch (e) {
      _isError = true;
      _networkMessage = e.toString();
    } finally {
      //_showLoader = false;
      notifyListeners();
    }
  }

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  fetchPromotionsTimer() async {
    await getPromotions();
    Timer.periodic(Duration(seconds: AppHelper.defaultRequestTime),
        (value) async {
      if (!_isFetching) {
        _isFetching = true;
        await getPromotions();
        _isFetching = false;
      }
    });
  }

  bool _isFetchingSpecialIncentives = false;

  bool get isFetchingSpecialIncentives => _isFetchingSpecialIncentives;

  fetchSpecialIncentivesTimer() async {
    await fetchSpecialIncentives();
    Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTimeSpecialIncentives),
        (value) async {
      if (!_isFetchingSpecialIncentives) {
        _isFetchingSpecialIncentives = true;
        await fetchSpecialIncentives();
        _isFetchingSpecialIncentives = false;
      }
    });
  }

  fetchSpecialIncentives() async {
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? user = sharedPreferenceHelper.getUserData();
      "SMART INCENTIVES FOR USER: $user".logMessage();

      if (user != null) {
        SmartIncentivesParam param = SmartIncentivesParam(
            id: user.bluizeUniqueUserId!,
            audience: [FlavorConstants.getUserTierType(user)]);
        _incentives = [];
        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchSmartIncentives(param: param);
        "Smart Incentives Response: ${networkResponse.response}".logMessage();
        if (!networkResponse.isError &&
            networkResponse.response != null &&
            networkResponse.response is Map<String, dynamic>) {
          SmartIncentiveResponse response = SmartIncentiveResponse.fromJson(
              networkResponse.response as Map<String, dynamic>);

          if (response.success && response.matchedIncentives != null) {
            _incentives = response.matchedIncentives!;
            // _incentives = [];
          } else {
            _incentives = [];
          }
        }
      }
    } catch (e) {
      "Exception in fetchSpecialIncentives: ${e.toString()}".logMessage();
      _incentives = [];
    } finally {
      notifyListeners();
    }
  }

  String? _consumeIncentiveMessage;

  String? get consumeIncentiveMessage => _consumeIncentiveMessage;

  consumeSmartIncentive(String incentiveId) async {
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? user = sharedPreferenceHelper.getUserData();
      "SMART INCENTIVES FOR USER: $user".logMessage();

      if (user != null) {
        NetworkResponse networkResponse = await AppDataService.getInstance()
            .consumeSmartIncentive(params: {
          "Id": user.bluizeUniqueUserId!,
          "incentiveId": incentiveId
        });
        "Consume Smart Incentives Response: ${networkResponse.response}"
            .logMessage();
        if (!networkResponse.isError &&
            networkResponse.response != null &&
            networkResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.containsKey("success") && response["success"] as bool) {
            _incentives
                .removeWhere((element) => element.incentiveId == incentiveId);
          } else {
            _setErrorAndTimerSmartIncentive(
                "Ooppss..! Something went wrong while consuming the incentive. Please try again.");
          }
        } else {
          _setErrorAndTimerSmartIncentive(
              "Ooppss..! Something went wrong while consuming the incentive. Please try again.");
        }
      }
    } catch (e) {
      "Exception in Consume Smart Incentives: ${e.toString()}".logMessage();
      _setErrorAndTimerSmartIncentive(
          "Ooppss..! Something went wrong while consuming the incentive. Please try again.");
    } finally {
      notifyListeners();
    }
  }

  // Helper method to set the error and handle the safe 3-second auto-dismissal
  void _setErrorAndTimerSmartIncentive(String message) {
    _consumeIncentiveMessage = message;
    "Error message set for consuming incentive: $message".logMessage();
    notifyListeners();
    Future.delayed(const Duration(seconds: 5), () {
      resetConsumeIncentiveMessage();
    });
  }

  resetConsumeIncentiveMessage() {
    _consumeIncentiveMessage = null;
    notifyListeners();
  }
}
