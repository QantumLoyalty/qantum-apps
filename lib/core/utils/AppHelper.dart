import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qantum_apps/core/enums/MembershipStatus.dart';

import '../../core/mixins/logging_mixin.dart';
import '../../core/utils/AppColors.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../data/models/UserModel.dart';
import '../flavors_config/flavor_config.dart';

class AppHelper with LoggingMixin {
  /// MAKE IT DEFAULT 10
  static int defaultRequestTime = 10;

  static int defaultRequestTimeSpecialIncentives = 60;

  static printMessage(dynamic printableItem) {
    /*if (kDebugMode) {
      print(printableItem);
    }*/
    print(printableItem);
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
      case Flavor.qantum || Flavor.qantumClub || Flavor.starReward:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
      case Flavor.maxx || Flavor.maxClub:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;

      case Flavor.hogansReward ||
            Flavor.northShoreTavern ||
            Flavor.brisbane ||
            Flavor.wonthaggi:
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
      case Flavor.maxx || Flavor.maxClub:
        return Theme.of(context).buttonTheme.colorScheme!.onSecondary;
      case Flavor.brisbane || Flavor.wonthaggi:
        return Theme.of(context).primaryColor;
      case Flavor.mosaic:
        return AppColors.white;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.onPrimary;
    }
  }

  static ButtonStyle getAccountsButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.edp ||
            Flavor.bobsBulkBooze:
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
      case Flavor.maxx || Flavor.maxClub:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(AppColors.white));
      case Flavor.starReward || Flavor.kingscliff:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mhbc||Flavor.southportSharks:
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
      case Flavor.wonthaggi:
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
      case Flavor.mosaic||Flavor.mannumClub:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColorDark));
      default:
        return ButtonStyle();
    }
  }

  static ButtonStyle getEditAccountsButtonStyle(BuildContext context) {
    Flavor selectedFlavor = FlavorConfig.instance.flavor!;
    switch (selectedFlavor) {
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.wonthaggi ||
            Flavor.edp ||
            Flavor.senseOfTaste ||
            Flavor.bobsBulkBooze||Flavor.mosaic||Flavor.mannumClub:
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
      case Flavor.drinkRewards:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx || Flavor.maxClub:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.7)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: WidgetStatePropertyAll(AppColors.white));
      case Flavor.starReward || Flavor.kingscliff:
        return ButtonStyle(
            shadowColor:
                WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.1)),
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mhbc||Flavor.southportSharks:
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
      case Flavor.aceRewards||
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
      case Flavor.qantum ||
            Flavor.qantumClub ||
            Flavor.drinkRewards ||
            Flavor.edp:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.maxx || Flavor.maxClub || Flavor.bobsBulkBooze:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.mosaic:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color:Colors.transparent),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));
      case Flavor.starReward || Flavor.kingscliff:
        return ButtonStyle(
            elevation: const WidgetStatePropertyAll(20),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(80))),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent));

      case Flavor.mhbc||Flavor.southportSharks:
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
      case Flavor.northShoreTavern ||  Flavor.wonthaggi:
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
      case Flavor.montaukTavern ||
            Flavor.hogansReward ||
            Flavor.clh:
        return const Size(142, 42);

      case Flavor.northShoreTavern ||
            Flavor.aceRewards ||
            Flavor.brisbane ||
            Flavor.bluewater ||
            Flavor.kingscliff ||
            Flavor.drinkRewards ||
            Flavor.bobsBulkBooze||Flavor.southportSharks:
        return const Size(142, 58);

      case Flavor.woollahra:
        return const Size(252, 114);
      case Flavor.mhbc:
        return const Size(142, 48);
        case Flavor.maxClub:
        return const Size(142, 48);
      case Flavor.flinders:
        return const Size(56, 56);
      case Flavor.senseOfTaste:
        return const Size(280, 80);
      case Flavor.edp:
        return const Size(280, 100);
      case Flavor.mosaic:
        return const Size(100, 90);
      case Flavor.mannumClub:
        return const Size(250, 90);
      case Flavor.wonthaggi:
        return const Size(150, 100);
      default:
        return const Size(68, 68);
    }
  }

  static Future<String?> getDeviceToken() async {
    final oneSignalUser = OneSignal.User;
    final pushSubscription = OneSignal.User.pushSubscription;
    printMessage("Push Subscription ${pushSubscription.optedIn}");
    printMessage("Push ${OneSignal.User.pushSubscription.id} Token ${pushSubscription.token}");

    return oneSignalUser.pushSubscription.id;
  }

  static String getAppType() {
    final flavor = FlavorConfig.instance.flavor;
    const appTypeMap = {
      Flavor.starReward: "StarReward",
      Flavor.qantum: "Qantum",
      Flavor.qantumClub: "Qantum",
      Flavor.maxx: "MaxGaming",
      Flavor.maxClub: "MaxGaming",
      Flavor.clh: "Central",
      Flavor.mhbc: "Manly",
      Flavor.montaukTavern: "Montauk",
      Flavor.hogansReward: "Hogan",
      Flavor.northShoreTavern: "North",
      Flavor.aceRewards: "Ace",
      Flavor.brisbane: "Brisbane",
      Flavor.bluewater: "Bluewater",
      Flavor.flinders: "Flinders",
      Flavor.drinkRewards: "Drinks",
      Flavor.wonthaggi: "Wonthaggi",
      Flavor.edp: "EDP",
      Flavor.woollahra: "Woollahra",
      Flavor.senseOfTaste: "Sense",
      Flavor.bobsBulkBooze: "Bob",
      Flavor.mannumClub: "Mannum",
      Flavor.mosaic: "Mosaic",
    };
    return appTypeMap[flavor] ?? "Qantum";
  }

  static bool isClubApp() {
    final flavor = FlavorConfig.instance.flavor;
    //const clubFlavors = {Flavor.qantumClub, Flavor.aceRewards, Flavor.mhbc};
    const clubFlavors = {
      Flavor.aceRewards,
      Flavor.mhbc,
      Flavor.qantumClub,
      Flavor.maxClub,
      Flavor.mannumClub,
     // Flavor.southportSharks,
    };
    return clubFlavors.contains(flavor);
  }

  static Future<MembershipStatus> checkIfUserHasPurchasedTheMembership(
      {UserModel? user}) async {
    /*SharedPreferenceHelper sharedPreferencesHelper =
        await SharedPreferenceHelper.getInstance();
    UserModel? userData = sharedPreferencesHelper.getUserData();*/

    UserModel? userData;

    if (user != null) {
      userData = user;
    } else {
      SharedPreferenceHelper sharedPreferencesHelper =
          await SharedPreferenceHelper.getInstance();
      userData = sharedPreferencesHelper.getUserData();
    }

    if (userData != null) {
      debugPrint(
          "Event:: checkIfUserHasPurchasedTheMembership:: ${userData.toString()}",
          wrapWidth: 1024);

      if (userData.paymentType != null && userData.paymentType!.isNotEmpty) {
        print("PAYMENT TYPE ${userData.paymentType}");
        if (userData.paymentType!.toLowerCase() == "reception") {
          return MembershipStatus.pendingPayment;
        } else {
          if (userData.paymentType!.toLowerCase() == "card") {
            if (userData.paymentStatus!.isNotEmpty &&
                userData.paymentStatus!.toLowerCase() == 'success') {
              if (AppHelper.checkIfMembershipActive(userData)) {
                return MembershipStatus.active;
              } else {
                return MembershipStatus.inactive;
              }
            } else {
              return MembershipStatus.notMember;
            }
          } else {
            if (AppHelper.checkIfMembershipActive(userData)) {
              return MembershipStatus.active;
            } else {
              return MembershipStatus.inactive;
            }
          }
        }
      } else {
        return MembershipStatus.notMember;
      }
    } else {
      print("User data not found in shared preferences");
      return MembershipStatus.notMember;
    }
  }

  /// TEMP FUNCTION FOR MHBC APP ONLY
  static Future<bool> checkIfUserIsNew() async {
    SharedPreferenceHelper sharedPreferencesHelper =
        await SharedPreferenceHelper.getInstance();
    UserModel? userData = await sharedPreferencesHelper.getUserData();
    if (userData != null) {
      print("userData.type >> ${userData.type}");

      if (userData.type != null && userData.type!.toLowerCase() == "new") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static void decodeBase64Payload(String encodedData) {
    try {
      final normalized = base64.normalize(encodedData);
      final decodedBytes = base64.decode(normalized);
      final jsonString = utf8.decode(decodedBytes);

      final Map<String, dynamic> payload = jsonDecode(jsonString);

      print("DECODED DATA: $payload");
    } catch (e) {
      // log error
      print("DECODING ERROR: $e");
    }
  }

  static Future<bool> checkInternetConnection() async {
    final results = await Connectivity().checkConnectivity();

    print("Internet Status: $results");

    return !results.contains(ConnectivityResult.none);
  }

  static bool checkIfMembershipActive(UserModel user) {
    if (user.membershipExpiryDate != null &&
        user.membershipExpiryDate!.isNotEmpty) {
      print(
          "Membership Expiry: ${user.membershipExpiryDate} ServerTime ${user.serverTime}");

      if (user.serverTime != null && user.serverTime!.isNotEmpty) {
        /*DateTime expiry = DateTime.parse(user.membershipExpiryDate!).toUtc();
        DateTime serverTime = DateTime.parse(user.serverTime!).toUtc();
*/

        final server = DateTime.parse(user.serverTime!).toUtc();
        final expiry = DateTime.parse(user.membershipExpiryDate!).toUtc();

        final serverDateOnly =
            DateTime.utc(server.year, server.month, server.day);
        final expiryDateOnly =
            DateTime.utc(expiry.year, expiry.month, expiry.day);
        print("Membership status: ${serverDateOnly.isBefore(expiryDateOnly)}");
        return serverDateOnly.isBefore(expiryDateOnly) ||
            serverDateOnly.isAtSameMomentAs(expiryDateOnly);

        /*    print("Membership status: ${serverTime.isBefore(expiry)}");
        return serverTime.isBefore(expiry);
        //return serverTime.isAfter(expiry);*/
      }

      return false;
    }
    print("Membership Expiry Data ${user.membershipExpiryDate}");

    return false;
  }

  static Future<String> getAppVersion() async {
    final appInfo = await PackageInfo.fromPlatform();
    debugPrint('${appInfo.version} ${appInfo.appName}');
    String version = "${appInfo.version} (${appInfo.buildNumber})";
    return version;
  }

}
