import 'package:qantum_apps/core/extensions/log_extension.dart';

import '../../data/models/UserModel.dart';
import '../flavors_config/flavor_config.dart';

class FlavorConstants {
  static String getScancode() {
    const Map<Flavor, String> scanCodes = {
      Flavor.mhbc: "MHBCAAAAA",
      Flavor.clh: "CLH",
      Flavor.northShoreTavern: "NST",
      Flavor.montaukTavern: "MTT",
      Flavor.hogansReward: "HWP",
      Flavor.starReward: "SHG",
      Flavor.aceRewards: "WML",
      Flavor.brisbane: "BBCAAAAAA",
      Flavor.woollahra: "WHT",
      Flavor.flinders: "FSW",
      Flavor.bluewater: "BBGAAAAAA",
      Flavor.kingscliff: "KBH",
      Flavor.drinkRewards: "DHQ",
      Flavor.wonthaggi: "WCC",
      Flavor.edp: "EDP",
      Flavor.bobsBulkBooze: "BBB",
      Flavor.senseOfTaste: "SOT",
      Flavor.mosaic: "",
      Flavor.mannumClub: "",
      Flavor.southportSharks: "SPS",
    };

    return scanCodes[FlavorConfig.instance.flavor] ?? "ABC1234";
  }

  static String getUserTierType(UserModel userData) {
    FlavorConfig flavorConfig = FlavorConfig.instance;

    if (
        flavorConfig.flavor == Flavor.drinkRewards ||
        flavorConfig.flavor == Flavor.bobsBulkBooze ||
        flavorConfig.flavor == Flavor.senseOfTaste) {

      "MEMBERSHIP CATEGORY: ${userData.membershipCategory}".logMessage();

      if (userData.membershipCategory != null &&
          userData.membershipCategory!.isNotEmpty) {
        if (userData.membershipCategory!.toLowerCase() == "") {
          return "STAFF PRE 3MTH";
        } else {
          return userData.membershipCategory!;
        }
      } else {
        return "Valued";
      }
    } else {
      if (userData.statusTier != null && userData.statusTier!.isNotEmpty) {
        if (userData.statusTier!.toLowerCase() == "") {
          return "STAFF PRE 3MTH";
        } else {
          return userData.statusTier!;
        }
      } else {
        /// STATUS TIER IS NULL, NEED TO RETURN DEFAULT TIER
        const Map<Flavor, String> defaultTiers = {
          Flavor.mhbc: "Crewmate",
          Flavor.montaukTavern: "Member",
          Flavor.clh: "Member",
          Flavor.hogansReward: "Bronze",
          Flavor.aceRewards: "Tens",
          Flavor.brisbane: "Member",
          Flavor.woollahra: "Regulars",
          Flavor.bluewater: "Deckhand",
          Flavor.flinders: "Member",
          Flavor.northShoreTavern: "Silver",
          Flavor.kingscliff: "Valued",
          Flavor.drinkRewards: "Explorer",
          Flavor.wonthaggi: "Valued",
          Flavor.starReward: "Valued",
          Flavor.edp: "Silver",
          Flavor.bobsBulkBooze: "Valued",
          Flavor.senseOfTaste: "Valued",
          Flavor.southportSharks: "Jade",
        };

        return defaultTiers[flavorConfig.flavor] ?? "Valued";
      }
    }
  }
}
