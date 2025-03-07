import 'dart:async';

import 'package:flutter/material.dart';

import '../core/mixins/logging_mixin.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/models/PromotionModel.dart';
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });

      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = sharedPreferenceHelper.getUserData();
      if (userData != null) {
        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchPromotions(
                userData.statusTier != null && userData.statusTier!.isNotEmpty
                    ? userData.statusTier!.toLowerCase()
                    : "valued");

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  bool _isFetching = false;
  int i = 0;

  fetchPromotionsTimer() async {
    await getPromotions();
    Timer timer = Timer.periodic(const Duration(seconds: 20), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        i += 1;
        logEvent("Promotion Var:: $i");
        await getPromotions();
        _isFetching = false;
      }
    });
  }
}
