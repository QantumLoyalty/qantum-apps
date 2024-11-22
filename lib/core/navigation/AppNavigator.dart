import 'package:flutter/material.dart';
import 'package:qantum_apps/views/login/OTPScreen.dart';
import 'package:qantum_apps/views/partners_offer/PartnerOfferDetailScreen.dart';
import 'package:qantum_apps/views/promotions/PromotionDetailScreen.dart';
import 'package:qantum_apps/views/signup/SignupScreen.dart';

import '../../views/home/HomeScreen.dart';
import '../../views/login/LoginScreen.dart';
import '../../views/special_offers/SpecialOfferDetailScreen.dart';
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
        return MaterialPageRoute(builder: (_) => const OTPScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case promotionDetail:
        return MaterialPageRoute(builder: (_) => const PromotionDetailScreen());
      case promotionDetail:
        return MaterialPageRoute(builder: (_) => const PromotionDetailScreen());
      case partnerOfferDetail:
        return MaterialPageRoute(
            builder: (_) => const PartnerOfferDetailScreen());
      case whatsOnDetailScreen:
        return MaterialPageRoute(builder: (_) => const WhatsOnDetailScreen());
      case specialOfferDetailScreen:
        return MaterialPageRoute(
            builder: (_) => const SpecialOfferDetailScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
