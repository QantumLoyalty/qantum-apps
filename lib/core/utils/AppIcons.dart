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

  static String getCardBackground(String? membershipType) {
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
