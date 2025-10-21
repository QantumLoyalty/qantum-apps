import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
import '/core/mixins/logging_mixin.dart';
import '/core/navigation/AppNavigator.dart';
import '/data/models/NetworkResponse.dart';
import '/services/AppDataService.dart';
import '../core/flavors_config/flavor_config.dart';

class MyAccountProvider extends ChangeNotifier with LoggingMixin {
  final Map<String, String> _accountOptions = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
    "txtClubAndMembership": AppNavigator.clubAndMembership,
    "txtGamingPreferences": AppNavigator.gamingPreferences,
    "txtPASStatement": AppNavigator.pasStatement,
  };
  final Map<String, String> _accountOptionsMHBC = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
    "txtSponsorship": AppNavigator.clubAndMembership,
  };

  final Map<String, String> _accountOptionsOthers = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
  };

  Map<String, String> get accountOptions {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.maxx:
        return _accountOptions;
      case Flavor.mhbc || Flavor.starReward:
        return _accountOptionsMHBC;
      default:
        return _accountOptionsOthers;
    }
  }

  String getTranslatedText(AppLocalizations loc, String key) {
    switch (key) {
      case "txtChangeMyDetails":
        return loc.txtChangeMyDetails;
      case "txtCommunicationPreferences":
        return loc.txtCommunicationPreferences;
      case "txtClubAndMembership":
        return loc.txtClubAndMembership;
      case "txtGamingPreferences":
        return loc.txtGamingPreferences;
      case "txtPASStatement":
        return loc.txtPASStatement;
      case "txtSponsorship":
        return loc.txtSponsorship;

      default:
        return key; // fallback
    }
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  bool? _networkError;

  bool? get networkError => _networkError;

  String? _networkResponse;

  String? get networkResponse => _networkResponse;

  updateCoupon({required String coupon, required AppLocalizations loc}) async {
    try {
      _showLoader = true;
      notifyListeners();
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .updateCouponCode(couponCode: coupon);
      logEvent(networkResponse);

      _networkError = networkResponse.isError;
      if (networkResponse.isError) {
        _networkResponse = loc.msgCommonError;
      } else {
        _networkResponse = loc.msgClubCodeSaved;
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
