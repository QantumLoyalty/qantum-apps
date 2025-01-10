import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

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

  Map<String, String> get accountOptions => _accountOptions;
}
