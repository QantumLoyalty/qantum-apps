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
      Flavor.queens: "QHG",
      Flavor.brisbane: "BBCAAAAAA",
      Flavor.woollahra: "WHT",
      Flavor.flinders: "FSW",
      Flavor.bluewater: "BBGAAAAAA",
      Flavor.kingscliff: "KBH",
      Flavor.drinkRewards: "DHQ",
      Flavor.wonthaggi: "WCC",
      Flavor.edp: "EDP",
    };

    return scanCodes[FlavorConfig.instance.flavor] ?? "ABC1234";
  }


  static String getUserTierType(UserModel userData) {
    FlavorConfig flavorConfig = FlavorConfig.instance;

    if (flavorConfig.flavor == Flavor.starReward ||
        flavorConfig.flavor == Flavor.drinkRewards) {
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
          Flavor.queens: "Queens",
          Flavor.aceRewards: "Tens",
          Flavor.brisbane: "Member",
          Flavor.woollahra: "Regulars",
          Flavor.bluewater: "Deckhand",
          Flavor.flinders: "Member",
          Flavor.northShoreTavern: "Silver",
          Flavor.kingscliff: "Valued",
          Flavor.drinkRewards: "Explorer",
          Flavor.wonthaggi: "Valued",
          Flavor.edp: "Silver",
        };

        return defaultTiers[flavorConfig.flavor] ?? "Valued";

      }
    }
  }


}
