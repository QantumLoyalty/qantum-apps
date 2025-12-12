import 'package:flutter/material.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Flavor flavor;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        flavor = FlavorConfig.instance.flavor!;
        _checkLoginStatus();
      });
    });
  }

  _checkLoginStatus() async {
    if (!mounted) return;
    try {
      final sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
      final hasUserData = sharedPreferenceHelper.getUserData() != null;
      if (!mounted) return;

      if (hasUserData) {
        /*if (AppHelper.isClubApp()) {



          /// CHECKING IF PURCHASED THE MEMBERSHIP
          if (await AppHelper.checkIfUserHasPurchasedTheMembership()) {
            /// ALREADY PURCHASED THE MEMBERSHIP
            AppNavigator.navigateAndClearStack(context, AppNavigator.home);
          } else {
            ///  DID NOT PURCHASED THE MEMBERSHIP
            AppNavigator.navigateAndClearStack(
                context, AppNavigator.pendingPaymentScreen);
          }
        } else {
          AppNavigator.navigateAndClearStack(context, AppNavigator.home);
        }*/

        if (AppHelper.isClubApp()) {
          /// TEMP CONDITION FOR MHBC APP ONLY
          if (flavor == Flavor.mhbc) {
            if (await AppHelper.checkIfUserIsNew()) {
              /// IF USER IS NEW AND NEEDS TO SELECT MEMBERSHIP
              /// CHECKING IF PURCHASED THE MEMBERSHIP
              if (await AppHelper
                  .checkIfUserHasPurchasedTheMembership()) {
                /// ALREADY PURCHASED THE MEMBERSHIP
                AppNavigator.navigateAndClearStack(
                    context, AppNavigator.home);
              } else {
                ///  DID NOT PURCHASED THE MEMBERSHIP
                AppNavigator.navigateAndClearStack(
                    context, AppNavigator.pendingPaymentScreen);
              }
            } else {
              /// IF USER IS OLD
              AppNavigator.navigateAndClearStack(
                  context, AppNavigator.home);
            }
          } else {
            /// FOR OTHER APPS
            /// CHECKING IF PURCHASED THE MEMBERSHIP
            if (await AppHelper
                .checkIfUserHasPurchasedTheMembership()) {
              /// ALREADY PURCHASED THE MEMBERSHIP
              AppNavigator.navigateAndClearStack(
                  context, AppNavigator.home);
            } else {
              ///  DID NOT PURCHASED THE MEMBERSHIP
              AppNavigator.navigateAndClearStack(
                  context, AppNavigator.pendingPaymentScreen);
            }
          }
        } else {
          AppNavigator.navigateAndClearStack(
              context, AppNavigator.home);
        }


      } else {
        AppNavigator.navigateAndClearStack(context, AppNavigator.login);
      }
    } catch (e) {
      if (!mounted) return;
      AppNavigator.navigateAndClearStack(context, AppNavigator.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppHelper.appBackground(context),
      child: AppScaffold(
        body: Center(
            child: Applogo(
          hideTopLine: true,
        )),
      ),
    );
  }
}
