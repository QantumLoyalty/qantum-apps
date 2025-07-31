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
    return  Uri.tryParse(url)?.hasScheme ?? false;
  }
  static bool verifyEmailAddress(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
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
          //Color(0xFF1C4D61),
          Theme.of(context).primaryColor,
        ]));
  }

  static String maskPhoneNumber(String phone) {
    return "*******${phone.substring(phone.length - 3, phone.length)}";
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
      case Flavor.qantum:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;

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

      default:
        return const ButtonStyle();
    }
  }

  static Size getAppIconSize(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum:
        return const Size(72, 72);
      case Flavor.maxx:
        return const Size(72, 72);
      case Flavor.starReward:
        return const Size(72, 72);
      case Flavor.mhbc:
        return const Size(142, 42);
      case Flavor.clh:
        return const Size(142, 42);
      case Flavor.montaukTavern:
        return const Size(142, 42);

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
    FlavorConfig flavorConfig = FlavorConfig.instance;
    switch (flavorConfig.flavor) {
      case Flavor.starReward:
        return "StarReward";
      case Flavor.qantum:
        return "Qantum";
      case Flavor.maxx:
        return "MaxGaming";
      case Flavor.clh:
        return "Central";
      case Flavor.mhbc:
        return "Manly";
      case Flavor.montaukTavern:
        return "Montauk";
      case Flavor.senseOfTaste:
        return "Sense";

      default:
        return "Qantum";
    }
  }

  static Future<String> getUserTierType(UserModel userData) async {
    if (userData.statusTier != null && userData.statusTier!.isNotEmpty) {
      return userData.statusTier!;
    } else {
      /// STATUS TIER IS NULL, NEED TO RETURN DEFAULT TIER
      FlavorConfig flavorConfig = FlavorConfig.instance;
      switch (flavorConfig.flavor) {
        case Flavor.mhbc:
          return "Crewmate";
        default:
          return "Valued";
      }
    }
  }
}
