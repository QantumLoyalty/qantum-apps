import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/utils/AppColors.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../data/models/UserModel.dart';
import '../flavors_config/flavor_config.dart';

class AppHelper with LoggingMixin {
  /// MAKE IT DEFAULT 5
  static int defaultRequestTime = 5;

  static printMessage(dynamic printableItem) {
    if (kDebugMode) {
      print(printableItem);
    }
  }

  static bool verifyPhoneNumber(String phoneNo) {
    if (phoneNo.isNotEmpty && phoneNo.length == 10) {
      return true;
    }

    return false;
  }

  static bool verifyURL(String url) {
    print("URL $url");
    return Uri.tryParse(url)?.hasScheme ?? false;
  }

  static bool verifyEmailAddress(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String getPostcode(String address) {
    // Regular expression to find any 4-digit number (Australian-style postcode)
    final regex = RegExp(r'\b\d{4}\b');
    final matches = regex.allMatches(address);

    if (matches.isNotEmpty) {
      // Return the last match (in case there are multiple 4-digit numbers)
      return matches.last.group(0) ?? "";
    }
    return ""; // No postcode found
  }

  static Map<String, String> extractNameParts(String fullName) {
    // Trim and split by spaces
    final parts = fullName.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty) {
      return {'firstName': '', 'lastName': ''};
    } else if (parts.length == 1) {
      // Only one name
      return {'firstName': parts[0], 'lastName': ''};
    } else {
      // First word = Last Name, Remaining = First Name(s)
      final lastName = parts.first;
      final firstName = parts.sublist(1).join(' ');
      return {'firstName': firstName, 'lastName': lastName};
    }
  }

  static double getFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double baseScreenWidth = 375.0; // Standard screen width
    double scaleFactor = screenWidth / baseScreenWidth;
    return baseFontSize * scaleFactor;
  }

  static String formatDate(String? date) {
    String formattedDate = "";
    if (date != null && date.isNotEmpty) {
      try {
        DateTime inputDate = DateFormat("yyyy-MM-ddThh:mm:ss.000Z").parse(date);
        formattedDate = DateFormat("dd MMM, yyyy").format(inputDate);
      } catch (e) {
        AppHelper.printMessage(e.toString());
      }
    }

    return formattedDate;
  }

  static showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.success_green,
    ));
  }

  static showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: TextStyle(
            color: AppColors.white,
          )),
      backgroundColor: AppColors.error_red,
    ));
  }

  static BoxDecoration appBackground(BuildContext context) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Theme.of(context).primaryColorDark,
          Theme.of(context).primaryColor,
        ]));
  }

  static String maskPhoneNumber(String phone) {
    //  return "*******${phone.substring(phone.length - 3, phone.length)}";
    if (phone.isEmpty || phone.length < 3) return phone;
    return '*' * (phone.length - 3) + phone.substring(phone.length - 3);
  }

  static String maskEmail(String? email) {
    if (email != null && email.isNotEmpty) {
      String maskedEmail = email;
      if (email.contains("@")) {
        List<String> emailParts = email.split("@");
        AppHelper.printMessage(emailParts);
        if (emailParts.isNotEmpty) {
          String firstPart =
              "${emailParts[0].replaceRange(1, emailParts[0].length, "*" * (emailParts[0].length))}@";
          maskedEmail = firstPart;

          if (emailParts.length > 1) {
            String secondPart = emailParts[1].replaceRange(
                1, emailParts[1].length, "*" * (emailParts[1].length));
            maskedEmail = maskedEmail + secondPart;
          }
        }
      }
      return maskedEmail;
    } else {
      return "";
    }
  }

  static String maskEmailSecond(String? email) {
    if (email != null && email.isNotEmpty) {
      String maskedEmail = email;
      if (email.contains("@")) {
        List<String> emailParts = email.split("@");
        AppHelper.printMessage(emailParts);
        if (emailParts.isNotEmpty) {
          String firstPart =
              "${emailParts[0].replaceRange(1, emailParts[0].length, "*" * (emailParts[0].length))}@";
          maskedEmail = firstPart + emailParts[1];

          /* if (emailParts.length > 1) {
            String secondPart = emailParts[1].replaceRange(
                1, emailParts[1].length, "*" * (emailParts[1].length));
            maskedEmail = maskedEmail + secondPart;
          }*/
        }
      }
      return maskedEmail;
    } else {
      return "";
    }
  }

  static Color getAccountsButtonTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum || Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;

      case Flavor.hogansReward ||
            Flavor.northShoreTavern ||
            Flavor.queens ||
            Flavor.brisbane:
        return Theme.of(context).primaryColor;

      case Flavor.flinders:
        return AppColors.white;

      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static Color getEditAccountsButtonTextColor(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.maxx:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.brisbane:
        return Theme.of(context).primaryColor;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static ButtonStyle getAccountsButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.maxx:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(AppColors.white));
      case Flavor.starReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.white));
      case Flavor.northShoreTavern:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                AppColors.nst_back_color.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.nst_back_color),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor:
                WidgetStatePropertyAll(AppColors.nst_canvas_color));
      case Flavor.aceRewards ||
            Flavor.bluewater ||
            Flavor.woollahra ||
            Flavor.flinders:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.queens:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.brisbane:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));

      default:
        return ButtonStyle();
    }
  }

  static ButtonStyle getEditAccountsButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.maxx:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(AppColors.white));
      case Flavor.starReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(Theme.of(context)
                .buttonTheme
                .colorScheme!
                .primary
                .withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.northShoreTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.aceRewards ||
            Flavor.queens ||
            Flavor.bluewater ||
            Flavor.woollahra:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.brisbane:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));
      case Flavor.flinders:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color:
                        Theme.of(context).buttonTheme.colorScheme!.onSecondary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).buttonTheme.colorScheme!.primary));

      default:
        return ButtonStyle();
    }
  }

  static ButtonStyle getDeleteButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.starReward:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      case Flavor.mhbc:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.clh:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.montaukTavern:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.hogansReward:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.northShoreTavern || Flavor.queens:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.aceRewards ||
            Flavor.bluewater ||
            Flavor.woollahra ||
            Flavor.flinders:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(AppColors.white.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.brisbane:
        return ButtonStyle(
            shadowColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      default:
        return const ButtonStyle();
    }
  }

  static Size getAppIconSize(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.mhbc ||
            Flavor.montaukTavern ||
            Flavor.hogansReward ||
            Flavor.clh ||
            Flavor.queens:
        return const Size(142, 42);

      case Flavor.northShoreTavern ||
            Flavor.aceRewards ||
            Flavor.brisbane ||
            Flavor.bluewater:
        return const Size(142, 58);

      case Flavor.woollahra:
        return const Size(252, 114);
      case Flavor.flinders:
        return const Size(96, 96);

      default:
        return const Size(72, 72);
    }
  }

  static Future<String?> getDeviceToken() async {
    final oneSignalUser = OneSignal.User;
    final pushSubscription = OneSignal.User.pushSubscription;
    printMessage("Push Subscription ${pushSubscription.optedIn}");
    printMessage(
        "Push ${OneSignal.User.pushSubscription.id} Token ${pushSubscription.token}");

    return oneSignalUser.pushSubscription.id;
  }

  static String getAppType() {
    final flavor = FlavorConfig.instance.flavor;
    const appTypeMap = {
      Flavor.starReward: "StarReward",
      Flavor.qantum: "Qantum",
      Flavor.maxx: "MaxGaming",
      Flavor.clh: "Central",
      Flavor.mhbc: "Manly",
      Flavor.montaukTavern: "Montauk",
      Flavor.senseOfTaste: "Sense",
      Flavor.hogansReward: "Hogan",
      Flavor.northShoreTavern: "North",
      Flavor.aceRewards: "Ace",
      Flavor.queens: "Queens",
      Flavor.brisbane: "Brisbane",
      Flavor.bluewater: "Bluewater",
      Flavor.flinders: "Flinders"
    };
    return appTypeMap[flavor] ?? "Qantum";
  }

  static String getUserTierType(UserModel userData) {
    if (userData.statusTier != null && userData.statusTier!.isNotEmpty) {
      if (userData.statusTier!.toLowerCase() == "") {
        return "STAFF PRE 3MTH";
      } else {
        return userData.statusTier!;
      }
    } else {
      /// STATUS TIER IS NULL, NEED TO RETURN DEFAULT TIER
      FlavorConfig flavorConfig = FlavorConfig.instance;
      switch (flavorConfig.flavor) {
        case Flavor.mhbc:
          return "Crewmate";
        case Flavor.montaukTavern:
          return "Member";
        case Flavor.clh:
          return "Member";
        case Flavor.hogansReward:
          return "Bronze";
        case Flavor.queens:
          return "Queens";
        case Flavor.aceRewards:
          return "Tens";
        case Flavor.brisbane:
          return "Member";
        case Flavor.woollahra:
          return "Regulars";
        case Flavor.bluewater:
          return "Deckhand";
        case Flavor.flinders:
          return "Member";
        case Flavor.northShoreTavern:
          return "Silver";
        default:
          return "Valued";
      }
    }
  }

  static bool isClubApp() {
    final flavor = FlavorConfig.instance.flavor;
    const clubFlavors = {Flavor.qantum, Flavor.aceRewards};
    return clubFlavors.contains(flavor);
  }

  static Future<bool> checkIfUserHasPurchasedTheMembership() async {
    SharedPreferenceHelper sharedPreferencesHelper =
        await SharedPreferenceHelper.getInstance();
    UserModel? userData = await sharedPreferencesHelper.getUserData();
    if (userData != null) {
      if (userData.paymentStatus!.isNotEmpty &&
          userData.paymentStatus!.toLowerCase() == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
