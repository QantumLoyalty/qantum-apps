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
    "txtSponsorship": AppNavigator.clubAndMembership,
    "txtGamingPreferences": AppNavigator.gamingPreferences,
    "txtPASStatement": AppNavigator.pasStatement,
  };
  final Map<String, String> _accountOptionsMHBC = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
    "txtSponsorship": AppNavigator.clubAndMembership,
  };
  final Map<String, String> _accountOptionsSR = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtSponsorship": AppNavigator.clubAndMembership,
    "txtTermsAndConditions": "",
  };
  final Map<String, String> _accountOptionsMannum = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
  };

  final Map<String, String> _accountOptionsOthers = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
    "txtSponsorship": AppNavigator.clubAndMembership,
  };
  final Map<String, String> _accountOptionsEDP = {
    "txtChangeMyDetails": AppNavigator.userDetailScreen,
    "txtCommunicationPreferences": AppNavigator.communicationPreference,
    "txtChangeFavouriteVenue": "",
  };

  Map<String, String> get accountOptions {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.qantumClub || Flavor.maxx || Flavor.maxClub:
        return _accountOptions;
      case Flavor.mhbc||Flavor.hogansReward:
        return _accountOptionsMHBC;
      case Flavor.starReward:
        return _accountOptionsSR;
      case Flavor.edp:
        return _accountOptionsEDP;
      case Flavor.bluewater:
        return _accountOptionsMHBC;

      default:
        return _accountOptionsOthers;
    }
  }

  String getClubSponsorshipTitle(AppLocalizations loc) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.northShoreTavern || Flavor.bluewater || Flavor.mhbc || Flavor.qantum|| Flavor.hogansReward||Flavor.qantumClub||Flavor.maxClub||Flavor.maxx:
        return loc.txtSponsorship;
      case Flavor.starReward:
        return loc.txtClubSponsorship;

      default:
        return loc.txtClubAndMembership;
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
      case "txtClubSponsorship":
        return loc.txtClubSponsorship;
      case "txtTermsAndConditions":
        return loc.txtTermsAndConditions;
      case "txtChangeFavouriteVenue":
        return loc.txtChangeFavouriteVenue;

      default:
        return key; // fallback
    }
  }


}
