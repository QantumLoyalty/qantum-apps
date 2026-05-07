import 'package:flutter/material.dart';
import 'package:qantum_apps/core/enums/MembershipFlowSource.dart';
import 'package:qantum_apps/core/enums/RenewMembershipSource.dart';
import 'package:qantum_apps/views/my_venues/ChooseFavouriteVenueScreen.dart';
import '../../views/membership/EarlyBirdRenewalMembershipScreen.dart';
import '../../views/partners_offer/united_fuels/UnitedFuelMainScreen.dart';
import '../../views/partners_offer/united_fuels/UnitedFuelsBarcodeLandscape.dart';
import '../../views/web_view/AppWebView.dart';
import '/views/membership/RenewMembershipScreen.dart';
import '../../views/signup/SelfieUploadScreen.dart';
import '/views/signup/DrivingLicenseScanScreen.dart';
import '../../views/login/WelcomeScreen.dart';
import '../../views/membership/ChooseMembershipScreen.dart';
import '../../views/membership/ChoosePaymentMethod.dart';
import '../../views/membership/MembershipPaymentScreen.dart';
import '../../views/membership/PendingPaymentScreen.dart';
import '../../views/membership/ReceptionPaymentScreen.dart';
import '../../views/accounts/ClubAndMembership.dart';
import '../../views/accounts/CommunicationPreference.dart';
import '../../views/accounts/GamingPreferences.dart';
import '../../views/accounts/PASStatement.dart';
import '../../views/accounts/recoverAccount/RecoverAccountEmailFailure.dart';
import '../../views/accounts/recoverAccount/RecoverAccountNewPhone.dart';
import '../../views/accounts/recoverAccount/RecoverAccountSuccess.dart';
import '../../views/accounts/recoverAccount/RecoverAccountVerificationScreen.dart';
import '../../views/accounts/UserDetailScreen.dart';
import '../../views/accounts/EditUserDetailsScreen.dart';
import '../../views/accounts/MyAccountScreen.dart';
import '../../views/accounts/recoverAccount/RecoverAccountScreen.dart';
import '../../views/accounts/VerifyOTPAccount.dart';
import '../../views/home/HomeScreen.dart';
import '../../views/login/LoginScreen.dart';
import '../../views/login/OTPScreen.dart';
import '../../views/signup/SignupScreen.dart';
import '../../views/splash/SplashScreen.dart';

class AppNavigator {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String home = "/home";
  static const String signup = "/signup";
  static const String promotionDetail = "/promotionDetail";
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
  static const String recoverAccountScreen = "/recoverAccountScreen";
  static const String recoverAccountVerificationScreen =
      "/recoverAccountVerificationScreen";
  static const String recoverAccountNewPhone = "/recoverAccountNewPhone";
  static const String recoverAccountSuccess = "/recoverAccountSuccess";
  static const String recoverAccountEmailFailure =
      "/recoverAccountEmailFailure";
  static const String appWebView = "/appWebView";
  static const String drivingLicenseScreen = "/drivingLicenseScanScreen";
  static const String welcomeScreen = "/welcomeScreen";
  static const String chooseMembershipScreen = "/chooseMembershipScreen";
  static const String membershipPaymentScreen = "/membershipPaymentScreen";
  static const String pendingPaymentScreen = "/pendingPaymentScreen";
  static const String choosePaymentMethod = "/choosePaymentMethod";
  static const String earlyBirdRenewalMembershipScreen =
      "/earlyBirdRenewalMembershipScreen";
  static const String receptionPaymentScreen = "/receptionPaymentScreen";
  static const String selfieUploadScreen = "/selfieUploadScreen";
  static const String renewMembershipScreen = "/renewMembershipScreen";
  static const String unitedFuelMainScreen = "/unitedFuelMainScreen";
  static const String chooseFavouriteVenue = "/chooseFavouriteVenueScreen";
  static const String unitedFuelsBarcodeLandscape =
      "/unitedFuelsBarcodeLandscape";

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
        {
          bool? hideChangeMobileOption = (args ?? false) as bool?;
          return MaterialPageRoute(
              builder: (_) => LoginScreen(
                    hideChangeMobileOption: hideChangeMobileOption,
                  ));
        }
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
      case chooseFavouriteVenue:
        {
          late Map<String, dynamic> argumentss;
          argumentss = args as Map<String, dynamic>;
          return MaterialPageRoute(
              builder: (_) => ChooseFavouriteVenueScreen(
                    argument: argumentss,
                  ));
        }
      case drivingLicenseScreen:
        return MaterialPageRoute(
            builder: (_) => DrivingLicenseScanScreen(
                  arguments: args as Map<String, String>,
                ));
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case chooseMembershipScreen:
        {
          Map<String, String>? argumentss;
          if (args != null) {
            argumentss = args as Map<String, String>;
          }

          return MaterialPageRoute(
              builder: (_) => ChooseMembershipScreen(arguments: argumentss));
        }

      case membershipPaymentScreen:
        {
          MembershipFlowSource? flowSource;
          if (args != null) {
            flowSource = args as MembershipFlowSource;
          }

          return MaterialPageRoute(
              builder: (_) => MembershipPaymentScreen(
                    membershipFlowSource: flowSource,
                  ));
        }
      case renewMembershipScreen:
        {
          return MaterialPageRoute(builder: (_) => RenewMembershipScreen());
        }
      case pendingPaymentScreen:
        {
          String? screenFlowSource;

          if (args != null) {
            screenFlowSource = args as String;
          }
          return MaterialPageRoute(
              builder: (_) => PendingPaymentScreen(
                    fromScreenFlow: screenFlowSource,
                  ));
        }
      case earlyBirdRenewalMembershipScreen:
        return MaterialPageRoute(
            builder: (_) => EarlyBirdRenewalMembershipScreen());
      case choosePaymentMethod:
        {
          Map<String, String>? argumentss;
          if (args != null) {
            argumentss = args as Map<String, String>;
          }

          return MaterialPageRoute(
              builder: (_) => ChoosePaymentMethod(arguments: argumentss));
        }

      case receptionPaymentScreen:
        return MaterialPageRoute(builder: (_) => ReceptionPaymentScreen());

      case unitedFuelMainScreen:
        return MaterialPageRoute(builder: (_) => UnitedFuelMainScreen());
      case unitedFuelsBarcodeLandscape:
        return MaterialPageRoute(builder: (_) => UnitedFuelsBarcodeLandscape());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case myAccountScreen:
        return MaterialPageRoute(builder: (_) => MyAccountScreen());
      case userDetailScreen:
        return MaterialPageRoute(builder: (_) => const UserDetailScreen());
      case clubAndMembership:
        return MaterialPageRoute(builder: (_) => ClubAndMembership());
      case selfieUploadScreen:
        {
          Map<String, String>? argumentss;
          if (args != null) {
            argumentss = args as Map<String, String>;
          }
          return MaterialPageRoute(
              builder: (_) => SelfieUploadScreen(
                    arguments: argumentss,
                  ));
        }
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
        return MaterialPageRoute(builder: (_) => const EditUserDetailsScreen());
      case recoverAccountScreen:
        return MaterialPageRoute(builder: (_) => const RecoverAccountScreen());
      case recoverAccountSuccess:
        return MaterialPageRoute(builder: (_) => const RecoverAccountSuccess());
      case recoverAccountEmailFailure:
        return MaterialPageRoute(
            builder: (_) => const RecoverAccountEmailFailure());
      case appWebView:
        return MaterialPageRoute(
            builder: (_) => AppWebView(
                  url: args as String,
                ));
      case recoverAccountNewPhone:
        return MaterialPageRoute(
            builder: (_) => RecoverAccountNewPhone(
                  params: args as Map<String, dynamic>,
                ));

      case recoverAccountVerificationScreen:
        return MaterialPageRoute(
            builder: (_) => RecoverAccountVerificationScreen(
                  params: args as Map<String, dynamic>,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
