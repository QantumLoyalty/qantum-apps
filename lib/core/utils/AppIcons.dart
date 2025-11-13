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
  static String lightBulb = "assets/common/lightbulb.png";

  static String getHeaderIcon() {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    if (selectedFlavor == Flavor.northShoreTavern) {
      return "assets/northShoreTavern/nst_header_logo.png";
    } else {
      return app_logo;
    }
  }

  static String getCardBackground(String? membershipType) {
    membershipType = membershipType!.toLowerCase().replaceAll(" ", "");
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    if (selectedFlavor == Flavor.mhbc) {
      switch (membershipType.toLowerCase()) {
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
    } else if (selectedFlavor == Flavor.aceRewards) {
      switch (membershipType.toLowerCase()) {
        case "staff":
          return "assets/aceRewards/card_staff.png";
        case "tens":
          return "assets/aceRewards/card_tens.png";
        case "jacks":
          return "assets/aceRewards/card_jacks.png";
        case "queens":
          return card_platinum;
        case "kings":
          return card_gold;
        case "ace":
          return "assets/aceRewards/card_ace.png";
        case "aceplus":
          return "assets/aceRewards/card_ace_plus.png";
        default:
          return "assets/aceRewards/card_staff.png";
      }
    } else if (selectedFlavor == Flavor.hogansReward) {
      switch (membershipType.toLowerCase()) {
        case "bronze":
          return card_lieutenant;
        case "silver":
          return card_silver;
        case "gold":
          return card_gold;
        case "platinum":
          return card_platinum;
        case "staff":
          return "assets/hogansReward/card_staff.png";
        case "management":
          return "assets/hogansReward/card_management.png";
        case "family":
          return "assets/hogansReward/card_family.png";
        case "directors":
          return "assets/hogansReward/card_directors.png";

        default:
          return card_lieutenant;
      }
    } else if (selectedFlavor == Flavor.clh) {
      switch (membershipType) {
        case "member":
          return "assets/centralLaneHotel/card_member.png";
        case "premiummember":
          return "assets/centralLaneHotel/card_premium_member.png";
        case "valued":
          return "assets/centralLaneHotel/card_value.png";
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
    } else if (selectedFlavor == Flavor.montaukTavern) {
      switch (membershipType.toLowerCase().trim()) {
        case "member":
          return "assets/montaukTavern/card_member.png";
        case "premiummember":
          return "assets/montaukTavern/card_premium_member.png";
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
        case "sapphire":
          return "assets/montaukTavern/card_sapphire.png";
        case "diamond":
          return "assets/montaukTavern/card_diamond.png";
        default:
          return "assets/montaukTavern/card_member.png";
      }
    } else if (selectedFlavor == Flavor.northShoreTavern) {
      switch (membershipType.toLowerCase().trim()) {
        case "prestaff":
          return "assets/northShoreTavern/card_pre_staff.png";
        case "staff":
          return "assets/northShoreTavern/card_staff.png";
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
    } else if (selectedFlavor == Flavor.queens) {
      switch (membershipType.toLowerCase().trim()) {
        case "queens":
          return "assets/queensHotel/card_queens.png";
        case "ruby":
          return "assets/queensHotel/card_ruby.png";
        case "emerald":
          return "assets/queensHotel/card_emerald.png";
        case "sapphire":
          return "assets/queensHotel/card_sapphire.png";
        case "diamond":
          return "assets/queensHotel/card_diamond.png";
        case "diamondplus":
          return "assets/queensHotel/card_diamond_plus.png";
        case "curtiscoast":
          return "assets/queensHotel/card_curtis_coast.png";

        default:
          return "assets/queensHotel/card_queens.png";
      }
    } else if (selectedFlavor == Flavor.brisbane) {
      switch (membershipType.toLowerCase().trim()) {
        case "brewcrew":
          return "assets/brisbaneBrewing/card_brew_crew.png";
        case "champion":
          return "assets/brisbaneBrewing/card_champion.png";
        case "legend":
          return "assets/brisbaneBrewing/card_legend.png";
        case "member":
          return "assets/brisbaneBrewing/card_member.png";
        case "regular":
          return "assets/brisbaneBrewing/card_regular.png";

        default:
          return "assets/brisbaneBrewing/card_brew_crew.png";
      }
    } else if (selectedFlavor == Flavor.woollahra) {
      switch (membershipType.toLowerCase().trim()) {
        case "crew":
          return "assets/woollahraHotel/crew.png";
        case "clubconnect":
          return "assets/woollahraHotel/card_club_connect.png";
        case "locallegends":
          return "assets/woollahraHotel/card_local_legends.png";
        case "regulars":
          return "assets/woollahraHotel/card_regulars.png";

        default:
          return "assets/woollahraHotel/card_regulars.png";
      }
    } else {
      switch (membershipType.toLowerCase()) {
        case "valued" || "staff" || "pre 3 months staff":
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
