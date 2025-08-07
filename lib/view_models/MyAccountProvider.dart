import 'package:flutter/material.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/services/AppDataService.dart';

import '../core/flavors_config/flavor_config.dart';
import '../core/utils/AppStrings.dart';

class MyAccountProvider extends ChangeNotifier with LoggingMixin {
  final Map<String, String> _accountOptions = {
    AppStrings.txtChangeMyDetails: AppNavigator.userDetailScreen,
    AppStrings.txtCommunicationPreferences:
        AppNavigator.communicationPreference,
    AppStrings.txtClubAndMembership: AppNavigator.clubAndMembership,
    AppStrings.txtGamingPreferences: AppNavigator.gamingPreferences,
    AppStrings.txtPASStatement: AppNavigator.pasStatement,
  };
  final Map<String, String> _accountOptionsMHBC = {
    AppStrings.txtChangeMyDetails: AppNavigator.userDetailScreen,
    AppStrings.txtCommunicationPreferences:
        AppNavigator.communicationPreference,
    AppStrings.txtSponsorship: AppNavigator.clubAndMembership,
  };

  Map<String, String> get accountOptions {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc:
        return _accountOptionsMHBC;
      default:
        return _accountOptions;
    }
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  bool? _networkError;

  bool? get networkError => _networkError;

  String? _networkResponse;

  String? get networkResponse => _networkResponse;

  updateCoupon({required String coupon}) async {
    try {
      _showLoader = true;
      notifyListeners();
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .updateCouponCode(couponCode: coupon);
      logEvent(networkResponse);

      _networkError = networkResponse.isError;
      if (networkResponse.isError) {
        _networkResponse = "Ooppss.. something went wrong, please try again.";
      } else {
        _networkResponse = "Club code saved successfully!";
      }
    } catch (e) {
      _networkError = true;
      _networkResponse = e.toString();
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  resetNetworkResponseStatus() {
    //  _networkResponse = null;
    _networkError = null;
    notifyListeners();
  }
}
