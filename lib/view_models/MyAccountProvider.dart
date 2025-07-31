import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

import '../core/flavors_config/flavor_config.dart';
import '../core/utils/AppStrings.dart';

class MyAccountProvider extends ChangeNotifier {
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
}
