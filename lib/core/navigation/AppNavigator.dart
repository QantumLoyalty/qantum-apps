import 'package:flutter/material.dart';
import 'package:qantum_apps/views/accounts/ClubAndMembership.dart';
import 'package:qantum_apps/views/accounts/CommunicationPreference.dart';
import 'package:qantum_apps/views/accounts/GamingPreferences.dart';
import 'package:qantum_apps/views/accounts/PASStatement.dart';
import 'package:qantum_apps/views/accounts/UserDetailScreen.dart';

import '../../views/accounts/EditUserDetailsScreen.dart';
import '../../views/accounts/MyAccountScreen.dart';
import '../../views/accounts/VerifyOTPAccount.dart';
import '../../views/home/HomeScreen.dart';
import '../../views/login/LoginScreen.dart';
import '../../views/login/OTPScreen.dart';
import '../../views/partners_offer/PartnerOfferDetailScreen.dart';
import '../../views/promotions/PromotionDetailScreen.dart';
import '../../views/signup/SignupScreen.dart';
import '../../views/splash/SplashScreen.dart';
import '../../views/whats_on/WhatsOnDetailScreen.dart';

class AppNavigator {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String home = "/home";
  static const String signup = "/signup";
  static const String promotionDetail = "/promotionDetail";
  static const String partnerOfferDetail = "/partnerOfferDetail";
  static const String whatsOnDetailScreen = "/whatsOnDetailScreen";
  static const String specialOfferDetailScreen = "/specialOfferDetailScreen";
  static const String myAccountScreen = "/myAccountScreen";
  static const String userDetailScreen = "/userDetailScreen";
  static const String clubAndMembership = "/clubAndMembership";
  static const String communicationPreference = "/communicationPreference";
  static const String gamingPreferences = "/gamingPreferences";
  static const String pasStatement = "/pasStatement";
  static const String verifyOTPAccount = "/verifyOTPAccount";
  static const String editUserDetailsScreen = "/editUserDetailsScreen";

  // Method to navigate to a specific screen
  static Future<void> navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // Method to navigate to a screen and replace the current screen
  static Future<void> navigateReplacement(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);
  }

  // Method to navigate to a screen and clear backstack
  static Future<void> navigateAndClearStack(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, arguments: arguments, (value) => false);
  }

  // Method to go back to the previous screen
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static Route<dynamic> generateRoute(RouteSettings setting) {
    var args = setting.arguments;
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case otp:
        return MaterialPageRoute(
            builder: (_) => OTPScreen(
                  argument: args as Map<String, String>,
                ));
      case signup:
        return MaterialPageRoute(
            builder: (_) => SignupScreen(
                  argument: args as Map<String, String>,
                ));
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case promotionDetail:
        return MaterialPageRoute(builder: (_) => const PromotionDetailScreen());
      case partnerOfferDetail:
        return MaterialPageRoute(
            builder: (_) => const PartnerOfferDetailScreen());
      case whatsOnDetailScreen:
        return MaterialPageRoute(builder: (_) => const WhatsOnDetailScreen());
      case myAccountScreen:
        return MaterialPageRoute(builder: (_) => MyAccountScreen());
      case userDetailScreen:
        return MaterialPageRoute(builder: (_) => const UserDetailScreen());
      case clubAndMembership:
        return MaterialPageRoute(builder: (_) => const ClubAndMembership());
      case communicationPreference:
        return MaterialPageRoute(
            builder: (_) => const CommunicationPreference());
      case gamingPreferences:
        return MaterialPageRoute(builder: (_) => GamingPreferences());
      case pasStatement:
        return MaterialPageRoute(builder: (_) => PASStatement());
      case verifyOTPAccount:
        return MaterialPageRoute(builder: (_) => VerifyOTPAccount());
      case editUserDetailsScreen:
        return MaterialPageRoute(builder: (_) => EditUserDetailsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
