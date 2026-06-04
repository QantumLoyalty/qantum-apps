import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';

import '../core/extensions/log_extension.dart';
import '../core/mixins/logging_mixin.dart';
import '../core/utils/AppHelper.dart';
import '../core/utils/FlavorConstants.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/models/PromotionModel.dart';
import '../data/models/SmartIncentivesParam.dart';
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

  getPromotions() async {
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = await sharedPreferenceHelper.getUserData();

      if (userData != null && !userData.isUserStatusCancelled()) {
        String userTier = FlavorConstants.getUserTierType(userData);
        String? venue = userData!.venueName;
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

  fetchSpecialIncentives(BuildContext context) async {
    try {
      final userInfoProvider = context.read<UserInfoProvider>();
      final user = userInfoProvider.getUserInfo;

      if (user != null) {
        SmartIncentivesParam param = SmartIncentivesParam(
            id: user.bluizeUniqueUserId!,
            audience: [FlavorConstants.getUserTierType(user)]);

        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchSmartIncentives(param: param);
        networkResponse.toString().logMessage();
      }
    } catch (e) {
      "Exception in fetchSpecialIncentives: ${e.toString()}".logMessage();
    }
  }
}
