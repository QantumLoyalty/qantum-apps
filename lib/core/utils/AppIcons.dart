import '../flavors_config/flavor_config.dart';

class AppIcons {
  static String app_logo =
      "assets/${FlavorConfig.instance.flavorValues.appName![0].toLowerCase()}${FlavorConfig.instance.flavorValues.appName!.substring(1).replaceAll(" ", "")}/app_logo.png";

  static String my_profile = "assets/common/my_profile.png";
  static String card_value =
      "assets/${FlavorConfig.instance.flavorValues.appName![0].toLowerCase()}${FlavorConfig.instance.flavorValues.appName!.substring(1).replaceAll(" ", "")}/card_value.png";
  static String card_silver = "assets/common/card_silver.png";
  static String card_gold = "assets/common/card_gold.png";
  static String card_platinum = "assets/common/card_platinum.png";
  static String card_platinum_black = "assets/common/card_platinum_black.png";
  static String my_account = "assets/common/my_account.png";
  static String card_lieutenant =
      "assets/manlyHarbourBoatClub/card_lieutenant.png";
  static String card_nonfinancial =
      "assets/manlyHarbourBoatClub/card_nonfinancial.png";
  static String birthday = "assets/common/birthday.png";
  static String mobile = "assets/common/mobile.png";
  static String email = "assets/common/email.png";

  static String getHeaderIcon() {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    if (selectedFlavor == Flavor.northShoreTavern) {
      return "assets/northShoreTavern/nst_header_logo.png";
    } else {
      return app_logo;
    }
  }

  static String getCardBackground(String? membershipType) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    if (selectedFlavor == Flavor.mhbc) {
      switch (membershipType!.toLowerCase()) {
        case "crewmate":
          return card_value;
        case "commander":
          return card_silver;
        case "captain":
          return card_gold;
        case "commodore":
          return card_platinum;
        case "lieutenant":
          return card_lieutenant;
        case "nonfinancial":
          return card_nonfinancial;
        default:
          return card_value;
      }
    } else if (selectedFlavor == Flavor.hogansReward) {
      switch (membershipType!.toLowerCase()) {
        case "pearl":
          return "assets/hogansReward/card_pearl.png";
        case "opal":
          return "assets/hogansReward/card_opal.png";
        case "ruby":
          return "assets/hogansReward/card_ruby.png";
        case "sapphire":
          return "assets/hogansReward/card_ruby.png";
        case "diamond":
        default:
          return "assets/hogansReward/card_ruby.png";
      }
    } else if (selectedFlavor == Flavor.clh) {
      switch (membershipType!.toLowerCase().trim()) {
        case "member":
          return "assets/centralLaneHotel/card_member.png";
        case "premiummember":
          return "assets/centralLaneHotel/card_premium_member.png";
        case "valued":
          return card_value;
        case "silver":
          return card_silver;
        case "gold":
          return card_gold;
        case "platinum":
          return card_platinum;
        case "platinumblack":
          return card_platinum_black;
        default:
          return card_value;
      }
    } else {
      switch (membershipType!.toLowerCase()) {
        case "valued":
          return card_value;
        case "silver":
          return card_silver;
        case "gold":
          return card_gold;
        case "platinum":
          return card_platinum;
        case "platinumblack":
          return card_platinum_black;
        default:
          return card_value;
      }
    }
  }
}
